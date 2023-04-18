#
# Utility Functions
#
function requireVariable {
  if [ -z "${!1}" ]; then
    echo "$1 environment variable not set."
    exit 1
  fi
}

function requireVariables {
  for arg in $*; do
    requireVariable $arg
  done
}

export -f requireVariable requireVariables

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
    "https://api.github.com/repos/powerhome/connect-apple/commits/$COMMIT_SHA/statuses"
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
    "https://api.github.com/repos/powerhome/connect-apple/pulls/$PULL_REQUEST_ID"
}

export -f getCommitStatuses getPullRequestDetails
