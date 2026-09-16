#!/bin/bash

echo "Running TC04 - Input is not a .vsc file"

#Run the script and capture the output
#Make sure the file a.vs exists in pwd

actual=$(./assembler.sh a.vs)
#echo "$actual"

#Capture the exit code
status=$?
#echo $status

#Expected output
expected="usage: input does not have the extension .vsc."

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

echo "[PASS] TC04"
exit 0