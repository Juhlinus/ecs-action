#!/bin/sh -l
set -e

if test -f "composer.json"; then
    IGNORE_PLATFORM_REQS=""
    if [ "$CHECK_PLATFORM_REQUIREMENTS" = "false" ] || [ "$INPUT_COMPOSER_IGNORE_PLATFORM_REQS" = "true" ]; then
        IGNORE_PLATFORM_REQS="--ignore-platform-reqs"
    fi

    NO_DEV="--no-dev"
    if [ "$REQUIRE_DEV" = "true" ] || [ "$INPUT_COMPOSER_REQUIRE_DEV" = "true"  ]; then
        NO_DEV=""
    fi

    COMPOSER_COMMAND="composer install --no-scripts --no-progress $NO_DEV $IGNORE_PLATFORM_REQS"
    echo "::group::$COMPOSER_COMMAND"
    $COMPOSER_COMMAND
    echo "::endgroup::"
else
    echo "composer.json not found in repo, skipping Composer installation"
fi

ECS_COMMAND="/composer/vendor/bin/ecs check $1"
ECS_FIX_COMMAND="$ECS_COMMAND --fix"

OUTPUT=$(/composer/vendor/bin/ecs check $1 --fix)
OUTPUT="$OUTPUT $(/composer/vendor/bin/ecs check $1 --fix)" # Second run just in case
OUTPUT="${OUTPUT//$'\n'/\\n}}"

echo "OUTPUT: $OUTPUT"
echo "::set-output name=ecs_output::$OUTPUT"