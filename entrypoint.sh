#!/bin/sh
set -e

ROOT_PATH="/etc/chia/mainnet"
CHIA="chia --root-path=$ROOT_PATH"

${CHIA} init

# Creates a new certificate signed by the main machine's CA
if [ -d /ca ]; then
    $CHIA init -c /ca
fi

if [ -r /mnemonic.key ]; then
    $CHIA keys add -f /mnemonic.key
else
    $CHIA keys generate
fi

$CHIA plots add -d /plots

sed -i 's/localhost/127.0.0.1/g' $ROOT_PATH/config/config.yaml
sed -i 's/log_stdout: false/log_stdout: true/g' $ROOT_PATH/config/config.yaml

if [ -n "$ROLE" ]; then
    if [ "$ROLE" = "harvester" ]; then
        if [ -n "$FARMER_ADDRESS" ] && [ -n "$FARMER_PORT" ]; then
            $CHIA configure --set-farmer-peer $FARMER_ADDRESS:$FARMER_PORT
        fi
        $CHIA start harvester -r
        while true; do sleep 30; done;
    else
        echo "unknown role."
        exit 127
    fi
else
    exec chia --root-path=$ROOT_PATH "$@"
fi
