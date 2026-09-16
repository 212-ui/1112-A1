#!/bin/bash

echo "Running TC02 - More than one arguments"

#Run the script and capture the output
actual=$(./assembler.sh a.vs b.c)
#echo "$actual"

#Capture the exit code
status=$?
#echo $status

#Expected output
expected="usage: more than one arguments are provided."

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

echo "[PASS] TC02"
exit 0
