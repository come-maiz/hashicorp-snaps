#!/bin/bash
#
# Push a snap to the candidate channel.
#
# If the version of the latest snap in the candidate channel is not the same as
# the latest tag in the source repository, it will build a snap using the
# latest tag and push it to the candidate channel.
#
# Arguments:
#   project: The name of the project. It must be a directory relative to the
#            root of the repo.

set -ev

# Check if there is a new tag to push to the candidate channel.
tmp_dir="$(mktemp -d)"
source="$(cat "$1"/snapcraft.yaml | grep source | awk '{print $2}'"
git clone "$source" "${tmp_dir}"
last_committed_tag="$(git -C "${tmp_dir}" describe --tags --abbrev=0)"
docker run -v "${HOME}":/root snapcore/snapcraft sh -c "snapcraft status "$1"-elopio | grep candidate | awk '{print $2}' > tag)"
last_published_tag="$(cat tag)"

if [ "${last_committed_tag}" != "${last_published_tag}" ]; then
    # Build using the latest tag.
    ./scripts/snap-in-docker.sh "$1" "${last_published_tag}"
    # Publish to the candidate channel.
    docker run -v "${HOME}":/root -v "$(pwd)/$1":/cwd snapcore/snapcraft sh -c "cd /cwd && snapcraft push "*${last_published_tag}*".snap --release candidate"
fi
