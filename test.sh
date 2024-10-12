#/bin/bash

if [ $(swift run | grep -c "Tables: 17") -eq 1 ]; then
    echo "[Test 1]: Test 1 passed!"
else
    echo "[Test 1]: Test 1 failed!"
fi
