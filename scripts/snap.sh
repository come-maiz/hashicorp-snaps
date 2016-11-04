#!/bin/bash

set -ev

docker run -v $(pwd)/$1:/cwd snapcore/snapcraft sh -c 'apt install software-properties-common -y && add-apt-repository -y ppa:gophers/archive && apt update && cd /cwd && snapcraft'
