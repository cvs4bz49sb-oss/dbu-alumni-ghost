#!/bin/bash
# Railway sets PORT dynamically — map it to Ghost's config
export server__port="${PORT:-2368}"
export server__host="0.0.0.0"
exec docker-entrypoint.sh node current/index.js
