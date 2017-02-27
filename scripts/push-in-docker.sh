#!/bin/bash
#
# Push a snap to the store using a docker container.
#
# Arguments:
#   project: The name of the project. It must be a directory relative to the root of the repo.

set -ev

trap "rm -f ${HOME}/.config/snapcraft/snapcraft.cfg" EXIT

./scripts/login.sh

docker run -v "${HOME}":/root -v "$(pwd)/$1":/cwd snapcore/snapcraft sh -c "cd /cwd && snapcraft push *.snap --release edge"
