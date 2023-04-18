#!/bin/bash

export ROOT_DIR="$PWD"

. "$ROOT_DIR/Tools/include.sh"
export BUILD_ROOT="$ROOT_DIR/Build"
export GITHUB_PULL_REQUEST_ID=$CHANGE_ID
if [ -z "$GITHUB_COMMIT_SHA" ]; then
  export GITHUB_COMMIT_SHA=`git rev-parse HEAD`
fi

mkdir -p "$BUILD_ROOT"

#
# Nitro Runway
#

echo ""
echo "****************************"
echo "*    Runway PR Details     *"
echo "****************************"

if [ -n "$GITHUB_PULL_REQUEST_ID" ]; then
  export NITRO_PR_DETAILS="$BUILD_ROOT/pr-$GITHUB_PULL_REQUEST_ID-details.json"

  getPullRequestDetails "$GITHUB_PULL_REQUEST_ID" \
    | tee "$NITRO_PR_DETAILS" \
    | jq ". | {url, id, number, title, state, commits, mergeable}"
else
  echo "GITHUB_PULL_REQUEST_ID not set, skipping PR details"
fi

echo ""
echo "*********************************"
echo "*    Runway Commit Statuses     *"
echo "*********************************"

if [ -n "$NITRO_PR_DETAILS" ]; then
  export GITHUB_COMMIT_SHA=`jq -r .head.sha "$NITRO_PR_DETAILS"`
  export NITRO_COMMIT_STATUSES="$BUILD_ROOT/commit-$GITHUB_COMMIT_SHA-statuses.json"

  getCommitStatuses "$GITHUB_COMMIT_SHA" \
    | tee "$NITRO_COMMIT_STATUSES" \
    | jq "[.[] | {context, state, created_at}]"
else
  echo "NITRO_PR_DETAILS not set, skipping commit statuses"
fi

echo ""
echo "***********************************"
echo "*     Runway Backlog Item ID      *"
echo "***********************************"

# e.g. [REBL-1234]
BACKLOG_ITEM_ID_REGEX='s/.\([a-zA-Z0-9]\{1,\}-[0-9]\{1,\}\).*/\1/p'
EXTRACT_BACKLOG_ITEM_CMD="sed -n $BACKLOG_ITEM_ID_REGEX"

if [ -n "$GITHUB_PULL_REQUEST_ID" ]; then
  export RUNWAY_BACKLOG_ITEM_ID=`jq -r .title "$NITRO_PR_DETAILS" | $EXTRACT_BACKLOG_ITEM_CMD`

  if [ -n "$RUNWAY_BACKLOG_ITEM_ID" -a "$RUNWAY_BACKLOG_ITEM_ID" != "null" ]; then
    echo "RUNWAY_BACKLOG_ITEM_ID = $RUNWAY_BACKLOG_ITEM_ID"
  elif [[ -z "$RUNWAY_BACKLOG_ITEM_ID" ]]; then
      echo "No backlog item ID found, setting ID to 000, this could be Renovate bot or wrong PR title."
      RUNWAY_BACKLOG_ITEM_ID="ROGUE-000"
  fi
else
  echo "Not building a pull request - locating Runway Backlog Item ID in last commit message"
  export RUNWAY_BACKLOG_ITEM_ID=`git show-branch --no-name HEAD | $EXTRACT_BACKLOG_ITEM_CMD`

  if [ -n "$RUNWAY_BACKLOG_ITEM_ID" ]; then
    echo "RUNWAY_BACKLOG_ITEM_ID = $RUNWAY_BACKLOG_ITEM_ID"
  else
    echo "Unable to parse Runway Backlog Item ID from commit message title"
  fi
fi

echo $RUNWAY_BACKLOG_ITEM_ID
