#!/bin/bash

# Verify our parameters.
requireVariables            \
  BUILD_TARGET              \
  ROOT_DIR                  \
  TOOLS_ROOT

# Update our bundles to reflect our build number.
. "$TOOLS_ROOT/update-bundle.sh"

# Run the build
make -f "$ROOT_DIR/Makefile" "$BUILD_TARGET"
