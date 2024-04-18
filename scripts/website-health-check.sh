#!/bin/bash

URL="https://bloxico.com/"

response_headers=$(curl -sI "$URL")

status_code=$(echo "$response_headers" | grep -i "^HTTP" | awk '{print $2}')

# Check if the status code is 200
if [ "$status_code" = "200" ]; then
    echo "Website responding with status code: $status_code"
else
    echo "Website not responding."
fi
