#! /bin/bash

for file in *_*.md; do

    if [[ "$file" =~ _([0-9]+)\.md ]]; then
    LESSON_NUM="${BASH_REMATCH[1]}" # Get the lesson number

    # Fill number in prompt
    PROMPT="# 104.${LESSON_NUM} Exercises

Both guided and exploration exercises for 104.${LESSON_NUM}.

## Guided Exercises
    
1.

## Exploration Exercises

1. "

    echo "$PROMPT" > "E104_${LESSON_NUM}.md"
    fi
done
