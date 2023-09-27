#!/bin/bash

requireVariables      \
  BUILD_NUMBER        \
  BUILD_TARGET        \
  PLAYBOOK_ROOT

case $BUILD_TARGET in
  navigator-*)
    INFO_PLIST="$PLAYBOOK_ROOT/Info.plist"
    ;;

  *)
    ;;
esac

if [ -n "$INFO_PLIST" ]; then
  FOUND_VERSION=`/usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' "$INFO_PLIST"`
  echo "Detected CFBundleShortVersionString of $FOUND_VERSION"

  BUILD_VERSION="$FOUND_VERSION.$BUILD_NUMBER"
  /usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString $BUILD_VERSION" "$INFO_PLIST"
  echo "Overriding bundle-specified version with BUILD_VERSION $BUILD_VERSION"

  /usr/libexec/PlistBuddy -c "Set :CFBundleVersion $BUILD_NUMBER" "$INFO_PLIST"
  echo "Set CFBundleVersion to $BUILD_NUMBER"
else
  echo "Unrecognized build target \"$BUILD_TARGET\", skipping bundle update."
fi
