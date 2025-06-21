#!/bin/bash

SPLIIT_APP_NAME=$(node -p -e "require('./package.json').name")

# Get git commit SHA - use GITHUB_SHA if in GitHub Actions, otherwise get from git
if [ -n "$GITHUB_SHA" ]; then
  COMMIT_SHA=$GITHUB_SHA
else
  COMMIT_SHA=$(git rev-parse --short HEAD)
fi

# we need to set dummy data for POSTGRES env vars in order for build not to fail
docker buildx build \
    -t ${SPLIIT_APP_NAME}:${COMMIT_SHA} \
    -t ${SPLIIT_APP_NAME}:latest \
    .

docker image prune -f
