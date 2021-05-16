#!/bin/sh
set -e

chia --root-path=/etc/chia/mainnet init

if [ -r /mnemonic.key ]; then
    chia --root-path=/etc/chia/mainnet keys add -f /mnemonic.key
else
    chia --root-path=/etc/chia/mainnet keys generate
fi

exec "chia --root-path=/etc/chia/mainnet $@"
