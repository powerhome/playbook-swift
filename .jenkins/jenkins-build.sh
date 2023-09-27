#!/bin/bash -e

# Run our setup.
. "$PWD/.jenkins/jenkins-setup.sh"

# Reset our checkout to a pristine state.
git reset --hard HEAD

# Run the build.
. "$ROOT_DIR/Tools/build.sh"
