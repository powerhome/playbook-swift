#!/bin/bash

export ROOT_DIR="$PWD"

. "$ROOT_DIR/Tools/github-utils.sh"

export BUILD_ROOT="$ROOT_DIR/Build"
export GITHUB_PULL_REQUEST_ID=$CHANGE_ID

if [ -z "$GITHUB_COMMIT_SHA" ]; then
  export GITHUB_COMMIT_SHA=`git rev-parse HEAD`
fi

mkdir -p "$BUILD_ROOT"

# Nitro Runway

export FAKE_RUNWAY_STORY_ID="PBIOS-000"

echo ""
echo "****************************"
echo "*    Runway PR Details     *"
echo "****************************"

if [ -n "$GITHUB_PULL_REQUEST_ID" ]; then
  export PR_DETAILS="$BUILD_ROOT/pr-$GITHUB_PULL_REQUEST_ID-details.json"

  echo "details file is: $PR_DETAILS"

  getPullRequestDetails "$GITHUB_PULL_REQUEST_ID" \
    | tee "$PR_DETAILS" \
    | jq ". | {commits, draft, id, labels, mergeable, number, state, title, url, user}"

  export PR_USER_HANDLE=`jq -r .user.login "$PR_DETAILS"`
else
  echo "GITHUB_PULL_REQUEST_ID not set, skipping PR details"
fi

echo ""
echo "*********************************"
echo "*    Runway Commit Statuses     *"
echo "*********************************"

if [ -n "$PR_DETAILS" ]; then
  export GITHUB_COMMIT_SHA=`jq -r .head.sha "$PR_DETAILS"`
  export NITRO_COMMIT_STATUSES="$BUILD_ROOT/commit-$GITHUB_COMMIT_SHA-statuses.json"

  getCommitStatuses "$GITHUB_COMMIT_SHA" \
    | tee "$NITRO_COMMIT_STATUSES" \
    | jq "[.[] | {context, state, created_at}]"
else
  echo "PR_DETAILS not set, skipping commit statuses"
fi

echo ""
echo "***********************************"
echo "*     Runway Backlog Item ID      *"
echo "***********************************"

# e.g. [REBL-1234]
BACKLOG_ITEM_ID_REGEX='s/.\([a-zA-Z0-9]\{1,\}-[0-9]\{1,\}\).*/\1/p'
EXTRACT_BACKLOG_ITEM_CMD="sed -n $BACKLOG_ITEM_ID_REGEX"

if [ -n "$GITHUB_PULL_REQUEST_ID" ]; then
  export RUNWAY_BACKLOG_ITEM_ID=`jq -r .title "$PR_DETAILS" | $EXTRACT_BACKLOG_ITEM_CMD`

  if [ -n "$RUNWAY_BACKLOG_ITEM_ID" -a "$RUNWAY_BACKLOG_ITEM_ID" != "null" ]; then
    echo "RUNWAY_BACKLOG_ITEM_ID = $RUNWAY_BACKLOG_ITEM_ID"
  elif [[ -z "$RUNWAY_BACKLOG_ITEM_ID" ]]; then
      echo "No backlog item ID found, setting ID to 000, this could be Renovate bot or wrong PR title."
      RUNWAY_BACKLOG_ITEM_ID=$FAKE_RUNWAY_STORY_ID
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
