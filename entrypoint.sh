#!/bin/sh -l
set -e

# Run three times to make sure we get everything
JSON_ONE=$(/composer/vendor/bin/ecs check $1 --fix --clear-cache --output-format=json)
JSON_TWO=$(/composer/vendor/bin/ecs check $1 --fix --clear-cache --output-format=json)
JSON_THREE=$(/composer/vendor/bin/ecs check $1 --fix --clear-cache --output-format=json)
OUTPUT=$(jq -s '.[0] * .[1] * .[2]' $(echo $JSON_ONE) $(echo $JSON_TWO) $(echo $JSON_THREE))

OUTPUT="${OUTPUT//'%'/'%25'}"
OUTPUT="${OUTPUT//$'\n'/'%0A'}"
OUTPUT="${OUTPUT//$'\r'/'%0D'}"

echo "OUTPUT: $OUTPUT"
echo "::set-output name=ecs_output::$OUTPUT"