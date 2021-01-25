#!/usr/bin/env bash

if [[ ! -d /usr/local/src/shaarli ]]; then
    cd /usr/local/src
    wget https://github.com/shaarli/Shaarli/releases/download/v0.11.1/shaarli-v0.11.1-full.zip
    unzip shaarli
    mv Shaarli shaarli
    rm shaarli*.zip
    chown -R root:www-data /usr/local/src/shaarli
    chmod -R g+rX /usr/local/src/shaarli
    chmod -R g+rwX /usr/local/src/shaarli/{cache/,data/,pagecache/,tmp/}
fi
