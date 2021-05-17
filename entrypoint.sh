#!/bin/sh
set -e

if [ -d /ca ]; then
    # Creates a new certificate signed by your main machine's CA
    chia --root-path=/etc/chia/mainnet init -c /ca
else
    chia --root-path=/etc/chia/mainnet init
fi

if [ -r /mnemonic.key ]; then
    chia --root-path=/etc/chia/mainnet keys add -f /mnemonic.key
else
    chia --root-path=/etc/chia/mainnet keys generate
fi

sed -i 's/localhost/127.0.0.1/g' /etc/chia/mainnet/config/config.yaml

if [ -n "$ROLE" ]; then
    if [ "$ROLE" = "harvester" ]; then
        if [ -n "$FARMER_ADDRESS" ] && [ -n "$FARMER_PORT" ]; then
            chia --root-path=/etc/chia/mainnet configure --set-farmer-peer $FARMER_ADDRESS:$FARMER_PORT
        fi
        chia --root-path=/etc/chia/mainnet start harvester
        while true; do sleep 30; done;
    else
        echo "unknown role."
        exit 127
    fi
else
    exec chia --root-path=/etc/chia/mainnet "$@"
fi
