#!/bin/bash

. "$ROOT_DIR/Tools/github-utils.sh"

requireVariables      \
  BUILD_NUMBER        \
  ROOT_DIR

export BUILD_ROOT="$ROOT_DIR/Build"
export TOOLS_ROOT="$ROOT_DIR/Tools"

if [ -z "$GITHUB_COMMIT_SHA" ]; then
  export GITHUB_COMMIT_SHA=`git rev-parse HEAD`
fi

mkdir -p "$BUILD_ROOT"

. "$TOOLS_ROOT/setup-story-details.sh"

echo ""
echo "****************************"
echo "*          Setup           *"
echo "****************************"
echo "ROOT_DIR                  = $ROOT_DIR"
echo "BUILD_ROOT                = $BUILD_ROOT"
echo "TOOLS_ROOT                = $TOOLS_ROOT"
echo ""
echo "BUILD_NUMBER              = $BUILD_NUMBER"
echo "GITHUB_BRANCH_NAME        = $GITHUB_BRANCH_NAME"
echo "GITHUB_COMMIT_SHA         = $GITHUB_COMMIT_SHA"
echo "GITHUB_PULL_REQUEST_ID    = $GITHUB_PULL_REQUEST_ID"
echo ""