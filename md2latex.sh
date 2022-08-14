#!/bin/bash

# Usage
# md2latex.sh <input.md> <output.tex>
pandoc --from=markdown+ignore_line_breaks --to=latex  --strip-comments \
--number-sections --standalone --top-level-division=section $1 -o $2