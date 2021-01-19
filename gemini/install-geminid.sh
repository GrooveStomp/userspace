#!/usr/bin/env bash

if [ ! $(which geminid) ]; then
    git clone https://github.com/jovoro/geminid.git
    cd geminid
    make
    mv geminid /usr/local/bin/
fi
