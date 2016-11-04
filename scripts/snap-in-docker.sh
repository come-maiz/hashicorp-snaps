#!/bin/bash
#
# Build a snap using a docker container.
#
# Arguments:
#   project: The name of the project. It must be a directory relative to the root of the repo.
#   version: The version of the snap to build.

set -ev

docker run -v "$(pwd)":/cwd snapcore/snapcraft sh -c "cd /cwd && ./scripts/snap.sh $1 $2"