#!/bin/bash

# TODO: Sort out this, mst use globbing to make a match
# Works perfectly with tests.sh, but not when called from bot
if [[ "$1" == .erekebabfredag* ]]; then
    echo "Kebabfredag status wanted" >> bashbot.log
    curl -s ere.kebabfredag.nu | grep h2 | grep -o ">.*<" | sed -E "s/[<>]//g"
fi
