#!/bin/bash

set -ev

trap "rm -f ${HOME}/.config/snapcraft/snapcraft.cfg" EXIT

./scripts/login.sh

./scripts/push-candidate.sh $PROJECT

./scrips/push-in-docker.sh $PROJECT master edge
