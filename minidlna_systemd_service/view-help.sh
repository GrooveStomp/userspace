#!/bin/sh

if [ $(which mdv) ]; then
    mdv $1
else
    cat $1
fi
