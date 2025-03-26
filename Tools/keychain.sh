#!/bin/bash

KEYCHAIN_NAME="build-$BUILD_NUMBER.keychain"

#
# Creates $KEYCHAIN_NAME as keychain and unlocks it
#
function createBuildKeychain {
  security create-keychain -p "$BUILD_KEYCHAIN_PASSWORD" $KEYCHAIN_NAME

  # Add the keychain to our search path so that it'll be found by xcode:
  EXISTING_KEYCHAIN_NAMES=()

  for EXISTING_KEYCHAIN_FILE in $(security list-keychains -d user)
  do
    EXISTING_KEYCHAIN_NAME=$(basename "$EXISTING_KEYCHAIN_FILE")
    EXISTING_KEYCHAIN_NAME=${EXISTING_KEYCHAIN_NAME::${#EXISTING_KEYCHAIN_NAME}-4}
    EXISTING_KEYCHAIN_NAMES+=("$EXISTING_KEYCHAIN_NAME")
  done

  security list-keychains -d user -s $KEYCHAIN_NAME ${EXISTING_KEYCHAIN_NAMES[@]}

  security unlock-keychain -p "$BUILD_KEYCHAIN_PASSWORD" $KEYCHAIN_NAME
  security set-keychain-settings -u $KEYCHAIN_NAME
}

#
# Adds project certificates to $KEYCHAIN_NAME
#
function addBuildKeys {
  # other certs in /fastlane/certs/ are being added direct on each machine, in Keychain -> System
  security import "$ROOT_DIR/fastlane/git_prov_profiles/certificates/ios_distribution_TL4UXWCB85_2028_03.p12" -k "$KEYCHAIN_NAME" -P "$KEY_PASSWORD" -T /usr/bin/codesign
  security import "$ROOT_DIR/fastlane/git_prov_profiles/certificates/mac_ui_test_dev.p12" -k "$KEYCHAIN_NAME" -P "" -T /usr/bin/codesign
  security import "$ROOT_DIR/fastlane/git_prov_profiles/certificates/developerID_application_2030_03.p12" -k "$KEYCHAIN_NAME" -P "$KEY_PASSWORD" -T /usr/bin/codesign
  security set-key-partition-list -S apple-tool:,apple: -s -k "$BUILD_KEYCHAIN_PASSWORD" "$KEYCHAIN_NAME"
}

function keychainSetup {
  echo "Keychain setup in progress; current keychains:"
  security list-keychains
  echo ""

  createBuildKeychain
  addBuildKeys

  echo ""
  echo "Keychain \"$KEYCHAIN_NAME\" created and assigned certificates; current keychains:"
  security list-keychains
}

function keychainDestroy {
  echo "Keychain cleanup in progress; current keychains:"
  security list-keychains
  echo ""

  security delete-keychain $KEYCHAIN_NAME

  echo ""
  echo "Keychain \"$KEYCHAIN_NAME\" removed; current keychains:"
  security list-keychains
}

#
# For temporarily-created build keychain
#
BUILD_KEYCHAIN_PASSWORD=ci_keychain_password

case $1 in
  setup)
    keychainSetup
    ;;

  destroy)
    keychainDestroy
    ;;

  *)
    echo "Unrecognized parameter \"$1\" (expected 'setup' or 'destroy') - exiting keychain.sh"
    exit 1
    ;;
esac

