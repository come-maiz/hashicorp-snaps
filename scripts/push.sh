#!/bin/bash

set -ev

./scripts/login.sh

./scripts/push-candidate.sh $PROJECT

# Push to the edge channel.
docker run -v "${HOME}":/root -v "$(pwd)/$1":/cwd snapcore/snapcraft sh -c "cd /cwd && snapcraft push *HEAD*.snap --release candidate"
rm -f "${HOME}/.config/snapcraft/snapcraft.cfg"
