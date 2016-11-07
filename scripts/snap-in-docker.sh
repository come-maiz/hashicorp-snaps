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
    sudo apt-get --yes --no-install-recommends install binfmt-support qemu-user-static
    echo ':arm:M::\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28\x00:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff:/usr/bin/qemu-arm-static:' | sudo tee -a /proc/sys/fs/binfmt_misc/register
fi

docker run -v "$(pwd)":/cwd "$docker_image" sh -c "cd /cwd && ./scripts/snap.sh $1 $3"
