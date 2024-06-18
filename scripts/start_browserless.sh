#!/bin/sh

echo "CONNECTION_TIMEOUT is set to: $CONNECTION_TIMEOUT"

exec node ./build/index.js 2>&1
