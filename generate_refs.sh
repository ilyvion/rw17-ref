#!/bin/bash
set -euo pipefail

RIMWORLD_DIR="${RIMWORLD_DIR:-$HOME/.var/app/com.valvesoftware.Steam/.steam/steam/steamapps/common/RimWorld}"
OUTPUT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/refs"

if [[ ! -d "$RIMWORLD_DIR" ]]; then
    echo "RimWorld directory not found: $RIMWORLD_DIR" >&2
    exit 1
fi

shopt -s nullglob
assemblies=("$RIMWORLD_DIR"/*.dll)
if (( ${#assemblies[@]} == 0 )); then
    echo "No assemblies found in $RIMWORLD_DIR" >&2
    exit 1
fi

rm -rf "$OUTPUT_DIR"
refasmer -v --all -c -O "$OUTPUT_DIR" "${assemblies[@]}"
