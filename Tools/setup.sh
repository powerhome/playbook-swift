#!/bin/bash

. "$ROOT_DIR/Tools/include.sh"

requireVariables      \
  BUILD_NUMBER        \
  ROOT_DIR

export BUILD_ROOT="$ROOT_DIR/Build"
export PLAYBOOK_ROOT="$ROOT_DIR/PlaybookShowcase/PlaybookShowcase"
export TOOLS_ROOT="$ROOT_DIR/Tools"

if [ -z "$GITHUB_COMMIT_SHA" ]; then
  export GITHUB_COMMIT_SHA=`git rev-parse HEAD`
fi

mkdir -p "$BUILD_ROOT"

# Figure out our app and IPA names.
case $BUILD_TARGET in
  playbook-ios-*)
    export BUILD_APP_NAME="PlaybookShowcase-iOS"
    export BUILD_IPA_FILE_NAME="${BUILD_APP_NAME}.ipa"
    export APP_BUNDLE="com.powerhrg.PlaybookShowcase"

    . "$TOOLS_ROOT/setup-story-details.sh"
    ;;
    
  *)
    ;;
esac

echo ""
echo "****************************"
echo "*          Setup           *"
echo "****************************"
echo "PLAYBOOK_ROOT             = $PLAYBOOK_ROOT"
echo "BUILD_ROOT                = $BUILD_ROOT"
echo "TOOLS_ROOT                = $TOOLS_ROOT"
echo ""
echo "BUILD_APP_NAME            = $BUILD_APP_NAME"
echo "BUILD_IPA_FILE_NAME       = $BUILD_IPA_FILE_NAME"
echo "BUILD_NUMBER              = $BUILD_NUMBER"
echo "BUILD_TARGET              = $BUILD_TARGET"
echo "GITHUB_BRANCH_NAME        = $GITHUB_BRANCH_NAME"
echo "GITHUB_COMMIT_SHA         = $GITHUB_COMMIT_SHA"
echo "GITHUB_PULL_REQUEST_ID    = $GITHUB_PULL_REQUEST_ID"
echo "WORKSPACE_CONFIGURATION   = $WORKSPACE_CONFIGURATION"
echo ""