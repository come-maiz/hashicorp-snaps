#!/bin/bash
#
# Build a snap using a docker container.
#
# Arguments:
#   project: The name of the project. It must be a directory relative to the root of the repo.
#   arch:    The architecture of the snap to build.
#   version: The version of the snap to build.

set -ev

docker_image=snapcore/snapcraft

if [ $2 == 'armhf' ]; then
    docker_image='multiarch/ubuntu-core:armhf-xenial'
    docker run --rm --privileged multiarch/qemu-user-static:register --reset
fi

docker run -v "$(pwd)":/cwd "$docker_image" sh -c "cd /cwd && ./scripts/snap.sh $1 $2 $3"
