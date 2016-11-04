#!/bin/bash

set -ev

if [ -z "$SNAPCRAFT_SECRET" ]; then
    exit 1
fi

if [ ! -e "${HOME}/.config/snapcraft/snapcraft.cfg" ]; then

    if [ ! -e ".encrypted/snapcraft.cfg.enc" ]; then
        # Get the encrypted config.
        mkdir -p ".encrypted"
        echo "${SNAPCRAFT_CONFIG}" > ".encrypted/snapcraft.cfg.enc"
    fi

    # Decrypt the authorization config.
    mkdir -p "${HOME}/.config/snapcraft"
    openssl enc -aes-256-cbc -base64 -pass env:SNAPCRAFT_SECRET -d -in ".encrypted/snapcraft.cfg.enc" -out "${HOME}/.config/snapcraft/snapcraft.cfg"

fi
