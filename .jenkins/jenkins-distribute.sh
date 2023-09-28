#!/bin/bash -e

# Run our setup.
. "$PWD/.jenkins/jenkins-setup.sh"

# Run the appropriate script based on our destination.
for DESTINATION in "$@"; do
  case "$DESTINATION" in
    app-center)
      . "$TOOLS_ROOT/distribute-ipa-to-app-center.sh"
      ;;
      
    *)
      echo "Unknown destination: $DESTINATION"
      exit 1
      ;;
  esac
done
