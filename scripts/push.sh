#!/bin/bash

set -ev

./scripts/push-candidate.sh $PROJECT

# Publish to the edge channel.
docker run -v "${HOME}":/root -v "$(pwd)/$1":/cwd snapcore/snapcraft sh -c "cd /cwd && snapcraft push *HEAD*.snap --release candidate"
rm -f "${HOME}/.config/snapcraft/snapcraft.cfg"
