#!/bin/bash

echo "Running TC05 - Input is an empty .vsc file"

#Run the script and capture the output
#Make sure the file a.vsc is empty

actual=$(./assembler.sh a.vsc)
#echo "$actual"

#Capture the exit code
status=$?
#echo $status

#Expected output
expected="usage: the file is empty - no .bin file is produced."

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

echo "[PASS] TC05"
exit 0