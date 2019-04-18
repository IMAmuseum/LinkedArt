#!/bin/bash
#THIS BASH FILE DOES NOT CURRENTLY WORK AS EXPECTED.
#Something is off with storing keys for use in the second part of the script. The result is output files with extra character in filename, with no data in file. Two options for first part so far, neither working.

# Test 1: First part stores keys[] as strings:
#for f in `cat ObjectsSample.json | jq -r '.objects[] | keys[]'` ; do
#  cat ObjectsSample.json | jq '.objects[] | ."$f"//empty' > $f.json
#done

# Test 2: First part stores keys[] as numbers:
#for f in `cat ObjectsSample.json | jq -r '.objects[] | .[].identified_by[0].content'` ; do
#  cat ObjectsSample.json | jq '.objects[]."$f"//empty' > $f.json
#done