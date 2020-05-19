#!/bin/sh
# Darwin usage only.
if [ -z "$(brew cask list textadept | grep -i textadept)" ]; then
    brew cask install textadept
else
    exit 0
fi
