#! /bin/bash

printf "%s\n" {1..7} | xargs -I{} touch E104_{}.md
./template.sh
