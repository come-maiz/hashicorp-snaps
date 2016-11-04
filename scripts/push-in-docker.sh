#!/bin/bash
#
# Push a snap to the store using a docker container.
#
# Arguments:
#   project: The name of the project. It must be a directory relative to the root of the repo.
#   version: The version of the snap to push.
#   channel: The channel where the snap will be pushed.

set -ev

docker run -v "${HOME}":/root -v "$(pwd)/$1":/cwd snapcore/snapcraft sh -c "cd /cwd && snapcraft push *$2*.snap --release $3"
