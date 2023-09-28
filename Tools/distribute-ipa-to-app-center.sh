#!/bin/bash -e

# Verify our parameters.
requireVariables              \
  APP_CENTER_API_TOKEN        \
  BUILD_APP_NAME              \
  BUILD_IPA_FILE_NAME         \
  BUILD_NUMBER                \
  BUILD_ROOT                  \
  BUILD_TARGET

# Figure out our App Center properties.
case $BUILD_TARGET in

  playbook-ios)
    ORG_NAME="powerhome"
    APP_NAME="Playbook-Showcase";;

  playbook-ios-beta)
    ORG_NAME="powerhome"
    APP_NAME="Playbook-Showcase-Beta";;

  *)
    echo "Unrecognized build target: $BUILD_TARGET"
    exit 1
    ;;

esac

echo ""
echo "****************************"
echo "*  Generate Release Notes  *"
echo "****************************"

RELEASE_DATE=`date '+%Y-%m-%d'`
RELEASE_TIME=`date '+%H:%M:%S UTC'`
RELEASE_NOTES="Build: $BUILD_NUMBER Uploaded: $RELEASE_DATE $RELEASE_TIME"
if [ -n "$RUNWAY_BACKLOG_ITEM_ID" ]; then
  RELEASE_NOTES="$RELEASE_NOTES

[$RUNWAY_BACKLOG_ITEM_ID](https://nitro.powerhrg.com/runway/backlog_items/$RUNWAY_BACKLOG_ITEM_ID)"
fi

echo "$RELEASE_NOTES"

echo ""
echo "****************************"
echo "*   Upload to App Center   *"
echo "****************************"

echo ""
(cd "$IOS_ROOT" && asdf exec bundle exec fastlane distribute_to_appcenter app_name:"$APP_NAME" org_name:"$ORG_NAME" token:"$APP_CENTER_API_TOKEN" file:"$BUILD_ROOT/$BUILD_IPA_FILE_NAME" release_notes:"$RELEASE_NOTES")

PUBLIC_URL="https://appcenter.ms/orgs/$ORG_NAME/apps/$APP_NAME"

echo ""
echo "*****************************************"
echo "*   Create Runway backlog item comments *"
echo "*****************************************"

if [ -z "$GITHUB_PULL_REQUEST_ID" ]; then
  echo "Not a pull request build, skipping comment update."
elif [[ -z "$RUNWAY_BACKLOG_ITEM_ID" ]]; then
  echo "No backlog item ID found, unable to create comment."
elif [[ -z "$PUBLIC_URL" ]]; then
  echo "No public URL found, unable to create comment."
else
  echo "Updating Runway backlog item (distributing .ipa to APP Center):"
  RUNWAY_BACKLOG_ITEM_COMMENT="Build $BUILD_NUMBER of $BUILD_APP_NAME may be downloaded <a href=$PUBLIC_URL>here<a/>."
  echo $RUNWAY_BACKLOG_ITEM_COMMENT
  addRunwayBacklogItemComment "$RUNWAY_BACKLOG_ITEM_COMMENT"
fi
