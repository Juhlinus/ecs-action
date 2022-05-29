#!/bin/sh -l
set -e

echo "Got these files $1"

OUTPUT=$(/composer/vendor/bin/ecs check $1 --fix)
OUTPUT="$OUTPUT $(/composer/vendor/bin/ecs check $1 --fix)" # Second run just in case
OUTPUT="$OUTPUT $(/composer/vendor/bin/ecs check $1 --fix)" # Third run just in case
OUTPUT="${OUTPUT//'%'/'%25'}"
OUTPUT="${OUTPUT//$'\n'/'%0A'}"
OUTPUT="${OUTPUT//$'\r'/'%0D'}"

echo "OUTPUT: $OUTPUT"
echo "::set-output name=ecs_output::$OUTPUT"