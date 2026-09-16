#!/bin/bash
# INFO1112 Assembler: .vsc -> .bin
# Instruction Opcode(6bit):
# LOAD  = 000000
# STORE = 000001
# ADD   = 000010
# SUB   = 000011
# PRINT = 000100
# QUIT  = 000101

if [ $# -eq 0 ];then
    echo -e "usage: no arg is provided."
    exit 1
elif [ $# -gt 1 ]; then
    echo -e "usage: more than one arguments are provided"
    exit 1
fi

INFILE="$1"
OUTFILE="${INFILE%.vsc}.bin"

# opcode map
declare -A OP_MAP
OP_MAP["LOAD"]="000000"
OP_MAP["STORE"]="000001"
OP_MAP["ADD"]="000010"
OP_MAP["SUB"]="000011"
OP_MAP["PRINT"]="000100"
OP_MAP["QUIT"]="000101"

# temp binary string
BIN_RAW=""

# parse .vsc line‑by‑line
while IFS= read -r line; do
    # trim whitespace
    line=$(echo "$line" | xargs)
    [[ -z "$line" ]] && continue
    [[ "$line" =~ ^# ]] && continue

    # Case 1: memory init value e.g. 0:20
    if [[ "$line" =~ ^([0-9]+):([0-9]+)$ ]]; then
        ADDR=${BASH_REMATCH[1]}
        VAL=${BASH_REMATCH[2]}
        # convert val to 8‑bit binary
        B8=$(printf "%08b" "$VAL")
        # memory init stored as special marker: @ADDR:BITS
        BIN_RAW+="@${ADDR}:${B8} "
        continue
    fi

    # Case2: instruction lines
    parts=($line)
    OP=${parts[0]}
    R=${parts[1]}
    MEMADDR=${parts[2]}

    OP_BIN=${OP_MAP[$OP]}
    if [ -z "$OP_BIN" ]; then
        echo "ERROR unknown opcode $OP"
        exit 1
    fi

    # register: 2 bit (0‑3)
    R_BIN=$(printf "%02b" "$R")

    # QUIT does not use register/memaddr; fill zero
    if [ "$OP" = "QUIT" ];then
        R_BIN="00"
        MEMADDR=0
    fi
    if [ "$OP" = "PRINT" ];then
        MEMADDR=0
    fi

    ADDR_BIN=$(printf "%08b" "$MEMADDR")
    # full 16‑bit instruction: 6+2+8
    INS_BIN="${OP_BIN}${R_BIN}${ADDR_BIN}"
    BIN_RAW+="${INS_BIN} "

done < "$INFILE"

# write binary file, store text‑format bin for emulator (simple implementation for bash)
echo "$BIN_RAW" > "$OUTFILE"
echo "Assembled $INFILE -> $OUTFILE"
