#!/bin/bash
#
# Build a snap using a docker container.
#
# Arguments:
#   project: The name of the project. It must be a directory relative to the root of the repo.

set -ev

trap "rm -f ${HOME}/.config/snapcraft/snapcraft.cfg" EXIT

./scripts/login.sh

# Check if the latest tag is in the beta channel.
tmp_dir="$(mktemp -d)"
source="$(cat $1/snapcraft.yaml | grep source: | head -n 1 | awk '{pri
git clone "${source}" "${tmp_dir}"
last_committed_tag="$(git -C "${tmp_dir}" describe --tags --abbrev=0)"
docker run -v $(pwd):$(pwd) snapcore/snapcraft sh -c "apt update && apt install -y snapcraft && cd $(pwd) && ((snapcraft status $1-elopio || echo "none") > status)"
last_released_tag="$(cat status | grep beta | awk '{print $2}')"

if [ "${last_committed_tag}" != "${last_released_tag}" ]; then
  # Build using the latest tag.
  sed -i "0,/source-tag/s/source-tag:.*$/source-tag: '"$last_committed_tag"'/g" $1/snapcraft.yaml
  sed -i "s/version:.*$/version: '"$last_committed_tag"'/g" $1/snapcraft.yaml
fi

docker run -v "$(pwd)":/cwd snapcore/snapcraft sh -c "apt update && apt upgrade -y && cd /cwd && ./scripts/snap.sh $1
