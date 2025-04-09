#!/usr/bin/env bash
#
# Segment batches of texts with MeCab.
#
# The input for this script is the name of a directory filled with text files.
# Each text file must have the extension `.txt`.
#
# The output of this script is a set of CSV files, one for each input file.
# Each row of the output CSV files contains information about one "token."
# Additional fields include the lemma form of the token and part of speech
# information. Output files share the name of the input file, with
# `-segmented.csv` appended.
#
# This script uses the following `mecab` keys:
#
# - %m: The original token
# - %f[7]: The lemma form
# - %f[6]: Reading of the lemma form
# - %f[0]: Part of speech 1
# - %f[1]: Part of speech 2
# - %f[2]: Part of speech 3
# - %f[3]: Part of speech 4
#
# This script also adds a letter in the final field to indicate if the token
# was "known" (1), "unknown" (0), or the end of string (2).
#
# Example usage:
#
# $ input_directory=<INPUT>
# $ output_directory=<OUTPUT>
# $ segment input_directory output_directory
#
# - MeCab details: <https://taku910.github.io/mecab/>
# - Output format details: <https://clrd.ninjal.ac.jp/unidic/faq.html>

# Specify the output format for a "known" node (token)
node="%m,%f[7],%f[6],%f[0],%f[1],%f[2],%f[3],1\n"

# Specify the output for an "unkown" node
unk="%m,%m,%m,%f[0],%f[1],%f[2],%f[3],0\n"

# Specify "EOS" (end of string) output
eos="EOS,,,,,,,2\n"

# MeCab flags
flags="--node-format=${node} --unk-format=${unk} --eos-format=${eos}"

# Default empty extension
ext=

# Options
while :; do
  case $1 in
    # Extension option
    --ext)
      if [ "$2" ]; then
        ext=$2
        shift
      else
        die 'Error: "--ext" option requires non-empty argument.'
      fi
      ;;
    *)
      break
  esac
  shift
done

# Iterate over the directory given
for file in $1/*${ext}
do
  # Check file exists (avoid unexpected behavior if no glob match)
  [ -e "$file" ] || continue
  # Get the file name without the extension or path
  noext="${file%${ext}}"
  basename="${noext##*/}"
  # Specify the output path
  output="$2/${basename}-segmented.csv"
  # Segment text with MeCab
  mecab ${flags} ${file} > ${output}
  # Print message
  echo "Segmented: ${output}"
done
