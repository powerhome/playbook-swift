#!/bin/bash -e

# Set our pull request ID, if available.
if [ -n "$CHANGE_ID" ]; then
  export GITHUB_PULL_REQUEST_ID=$CHANGE_ID
fi

# Set up our branch name
export GITHUB_BRANCH_NAME=$BRANCH_NAME

# Set up our root directory.
export ROOT_DIR="$PWD"

# Run the remainder of our setup.
. "$ROOT_DIR/Tools/setup.sh"
