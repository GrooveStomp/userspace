#!/usr/bin/env bash

if [[ -z $(which urlencode) ]]; then
    "Couldn't find urlencode to encode password"
    exit
fi

if [[ -z $(which gpg) ]]; then
    "Couldn't find gpg; can't decrypt password"
    exit
fi

PASSWORD=$(gpg --decrypt --quiet psql_password.gpg | xargs -0 urlencode)
sed -e "s/<PASSWORD>/${PASSWORD}/" miniflux.conf.template > miniflux.conf
