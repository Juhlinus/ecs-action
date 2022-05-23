#!/bin/sh -l

wget https://raw.githubusercontent.com/deprecated-packages/easy-coding-standard-prefixed/$1/bin/ecs -O ecs \
    && chmod a+x ecs \
    && mv ecs /usr/local/bin/ecs $(git diff --name-only $2) $3