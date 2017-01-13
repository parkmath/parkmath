#!/bin/bash

# To run on a Mac, this script relies on:
#  - Mono http://www.mono-project.com/
#  - A modified copy of the MathType 6.9 SDK, backed up at s3://parkmath-mtsdk-backup.  Restore with aws s3 sync s3://parkmath-mtsdk-backup tools/MathTypeSDK6.9

# Usage: tools/convert-equations.sh path/to/exported/indesign/document/Links /path/to/output/dir

# Sometimes MathType fails to export equations once, but works on a subsequent
# try.  Run the same command multiple times to keep trying -- to save time,
# equations that are already converted will not be processed twice.

set -e

INPUT_DIR=$1
OUTPUT_DIR=${2:-$(pwd)}

CONVERT="mono tools/MathTypeSDK6.9/DotNET/ConvertEquations/ConvertEquations/Program.exe"

mkdir -p "$OUTPUT_DIR"

rm -rf /tmp/inputeqns /tmp/outputeqns
mkdir /tmp/inputeqns
mkdir /tmp/outputeqns

cp "$INPUT_DIR"/*.* /tmp/inputeqns

find /tmp/inputeqns -iname '*.eps' -print0 | while read -d $'\0' eqn; do
  eqn_name="$(basename "$eqn")"
  tex_name="$(echo $eqn_name | sed 's/eps/tex/i')"
  dest_raw="$OUTPUT_DIR"/"$tex_name"
  dest_cleaned="$OUTPUT_DIR"/"${tex_name/tex/clean.tex}"

  if [[ -f "$dest_cleaned" ]]; then
    continue
  fi

  printf '%s/%s ' "$INPUT_DIR" "$eqn_name"

  $CONVERT "$eqn" /tmp/outputeqns >> convert-equations.log

  touch /tmp/outputeqns/"$tex_name"
  cleaned=$(cat /tmp/outputeqns/"$tex_name" | tr '\r' '\n' \
    | sed 's/%.*//' \
    | tr -d '\n')

  chars=$(printf '%s' "$cleaned" | wc -c)

  if [[ $chars -gt 0 ]]; then
    mv /tmp/outputeqns/"$tex_name" "$dest_raw"
    printf '%s' "$cleaned" > "$dest_cleaned"

    printf '\e[1;32msuccess\e[0m\n' "$INPUT_DIR" "$eqn_name"
    echo "$cleaned"
  else
    printf '\e[1;31mfailed\e[0m\n'
    echo "$INPUT_DIR/$eqn_name" >> failures.txt
  fi
done

rm convert-equations.log
