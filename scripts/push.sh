#!/bin/bash
#
# Push snap updates to the store.
#
# Arguments:
#   project: The name of the project. It must be a directory relative to the
#            root of the repo.
#   arch:    The architecture of the snap to build.

set -ev

trap "rm -f ${HOME}/.config/snapcraft/snapcraft.cfg" EXIT

./scripts/login.sh

./scripts/push-candidate.sh $1 $2

./scripts/push-in-docker.sh $1 $2 master edge
