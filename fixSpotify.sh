#!/bin/bash
sPATH=$(dirname $(realpath -L $(which spotify)))  # absolute path to Spotify
cd ${sPATH}/Apps/

if [ "$1" == 'restore' ]; then
    if [ -w xpui.spa_bak ] && [ -w . ]; then
        rm -f xpui.spa
        mv xpui.spa_bak xpui.spa
        echo "Restore success"
    else
        [ -f xpui.spa_bak ] && echo "Permission denied" || echo "Backup not found"
    fi
    exit 0
fi

if [ -w xpui.spa ] && [ -w . ]; then
    cp xpui.spa xpui.spa_bak  # create a backup, in case of trouble
    unzip -p xpui.spa xpui.js | sed 's/{adsEnabled:\!0}/{adsEnabled:false}/' > xpui.js
    zip --update xpui.spa xpui.js
    rm xpui.js
    echo "Success"
else
    [ -f xpui.spa ] && echo "Permission denied" || echo "File not found"
fi
