#!/bin/bash
#
# Push updated snaps to the store.
#
# Environment variables
#   PROJECT: The name of the project. It must be a directory relative to the
#             root of the repo.

set -ev

trap "rm -f ${HOME}/.config/snapcraft/snapcraft.cfg" EXIT

./scripts/login.sh

./scripts/push-candidate.sh $PROJECT

./scripts/push-in-docker.sh $PROJECT master edge
