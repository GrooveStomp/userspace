#!/usr/bin/env bash

if [[ -z $(which urlencode) ]]; then
    "Couldn't find urlencode to encode password"
    exit
fi

if [[ -z $(which gpg) ]]; then
    "Couldn't find gpg; can't decrypt password"
    exit
fi

gpg --decrypt --quiet psql_password.gpg | xargs -0 urlencode > password

rm -f password
