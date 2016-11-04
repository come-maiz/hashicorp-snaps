#!/bin/bash

set -ev

if [ -z "$SNAPCRAFT_SECRET" ]; then
    exit 0
fi

mkdir -p ".encrypted"
if [ ! -e ".encrypted/snapcraft.cfg.enc" ]; then
    echo "Seeding a new macaroon."
    echo "$SNAPCRAFT_CONFIG" > ".encrypted/snapcraft.cfg.enc"
fi

mkdir -p "$HOME/.config/snapcraft"
openssl enc -aes-256-cbc -base64 -pass env:SNAPCRAFT_SECRET -d -in ".encrypted/snapcraft.cfg.enc" -out "$HOME/.config/snapcraft/snapcraft.cfg"

docker run -v $HOME:/root -v $(pwd)/$1:/cwd snapcore/snapcraft sh -c "cd /cwd; snapcraft push *.snap --release edge"

rm -f "$HOME/.config/snapcraft/snapcraft.cfg"
