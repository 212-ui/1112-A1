#!/bin/bash

echo "Running TC03 - Input is not a file"

#Run the script and capture the output
actual=$(./assembler.sh ~)
#echo "$actual"

#Capture the exit code
status=$?
#echo $status

#Expected output
expected="usage: input is not a file or it does not exist."

#check exit code
if [ "$status" -ne 1 ]; then
    echo "[FAIL] Expected exit code: 1"
    exit 1
fi

#check output contains desired message
if [ "$actual" != "$expected" ]; then
    echo "[FAIL] Expected output: $expected"
    exit 1
fi

echo "[PASS] TC03"
exit 0