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