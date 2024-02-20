. "$ROOT_DIR/Tools/utils.sh"

#
# GitHub API Functions
#

function getCommitStatuses {
  COMMIT_SHA="$1"

  requireVariables            \
    COMMIT_SHA                \
    GITHUB_API_TOKEN

  curl \
    -s \
    -X GET \
    -H "Authorization: token $GITHUB_API_TOKEN" \
    "https://api.github.com/repos/powerhome/playbook-swift/commits/$COMMIT_SHA/statuses"
}

function getPullRequestDetails {
  PULL_REQUEST_ID="$1"

  requireVariables            \
    GITHUB_API_TOKEN          \
    PULL_REQUEST_ID

  curl \
    -s \
    -X GET \
    -H "Authorization: token $GITHUB_API_TOKEN" \
    "https://api.github.com/repos/powerhome/playbook-swift/pulls/$PULL_REQUEST_ID"
}

export -f getCommitStatuses getPullRequestDetails
