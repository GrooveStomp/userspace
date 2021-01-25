#!/usr/bin/env bash

if [[ -z $(which radicale) ]]; then
    python3 -m pip install setuptools
    python3 -m pip install --upgrade https://github.com/Kozea/Radicale/archive/master.tar.gz
fi

if [[ -z $(cat /etc/passwd | grep radicale) ]]; then
    useradd --system --user-group --home-dir / --shell /sbin/nologin radicale
fi

if [[ ! -d /var/lib/radicale/collections ]]; then
    mkdir -p /var/lib/radicale/collections
    chown -R radicale:radicale /var/lib/radicale
    chmod o- /var/lib/radicale/collections
fi
