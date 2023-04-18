#!/bin/bash -e

# Run our setup.
. "$PWD/.jenkins/jenkins-setup.sh"

# Update our keychain.
. "$ROOT_DIR/Tools/keychain.sh" $@
