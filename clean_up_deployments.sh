#!/bin/bash

TOKEN="XYZ"

ID=$(curl -H "Authorization: token $TOKEN" -s https://api.github.com/repos/jarkmaen/jarkmaen.github.io/deployments | grep -m 1 '"id":' | grep -o "[0-9]\+")

curl -s -X POST https://api.github.com/repos/jarkmaen/jarkmaen.github.io/deployments/$ID/statuses \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: token $TOKEN" \
    -d '{"state":"inactive"}' > /dev/null

curl -s -X DELETE https://api.github.com/repos/jarkmaen/jarkmaen.github.io/deployments/$ID \
    -H "Authorization: token $TOKEN"

echo "Deployment $ID removed."
