#!/bin/bash

# Usage
# md2latex.sh <input.md> <output.tex>

pandoc --from=markdown+ignore_line_breaks+yaml_metadata_block --to=latex  --strip-comments \
--number-sections --standalone --top-level-division=chapter \
-V classoption=pandoc $1 -o $2