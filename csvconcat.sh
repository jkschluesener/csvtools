#!/bin/bash

# This script concatenates a pattern match of csv files.
# It works on plaintext files. 
#
# Of the matching, sorted files, the first file's first line is used as the first line of the concatenated file. 
# In csv files, this line contains column titles.
#
# Should the output file already exist, it will throw an error unless you supply the -w flag.
#
# This script does not run any sanity checks on your data. 
# If you have csv files with differing column counts, it will not notice. 
# Same goes for weird input patterns, such as mixed csv files and text files. 
#
# This script automatically excludes the requested output file from the list of concatenations.
#
# Use on your own risk. 
#
#
# necessary flags:
# -i: input pattern in "..."
# -o: output file in "..."
#
# further flags:
# -w: overWrite output file if it exists
#
#
# example: 
# ./csvconcat -i "./data/*.csv" -o "./data/data.csv"
#
#
# github.com/jkschluesener
#
#

# parse flags
while getopts i:o:w flag; do
  case "${flag}" in
    i) input=${OPTARG};;
    o) output=${OPTARG};;
    w) overwrite=1;;
  esac
done

# If file exists and is not empty, throw an error.
# Unless the -w flag was supplied.
if [[ -s $output ]]; then
  if [[ "$overwrite" -ne 1 ]]; then
    echo "Output file exist and is not empty. Delete/Rename it or use the -w flag to overwrite."
    exit 1
  fi
fi

# create a list of matching files, sorted and excluding the output file. 
files=(`ls $input | sort -g | grep -w -v $output`)
echo ${files[@]}

# first file's header is header of output
head -1 "${files[0]}" > "$output"

for fname in "${files[@]}"; do 
  # append all lines starting with the second one
  tail -n +2 $fname >>  $output
  # newline
  echo -en "\n" >> $output
done