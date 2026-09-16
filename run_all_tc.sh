#!/bin/bash

chmod +x $0

for test in run_tc*.sh
do
    chmod +x "$test"
    bash "$test"
done