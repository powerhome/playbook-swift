#!/bin/bash -e

# Run our setup.
. "$PWD/.jenkins/jenkins-setup.sh"

# Dump the tail of each of our build logs.
for buildLog in "$BUILD_ROOT/"*.log; do
    echo "****************************************"
    echo "*"
    echo "* Tail of $buildLog:"
    echo "*"
    tail -50 "$buildLog"
    echo ""
done

# Dump the results of each of our REST API resposnes.
for jsonResponse in "$BUILD_ROOT/"*.json; do
    echo "****************************************"
    echo "*"
    echo "* $jsonResponse:"
    echo "*"
    cat "$jsonResponse"
    echo ""
done

# Handle the failure.
exit 0
