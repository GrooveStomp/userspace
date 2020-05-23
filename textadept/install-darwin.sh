#!/bin/sh

set -e

if [ "darwin" != "$(uname | tr [:upper:] [:lower:])" ]; then
    echo "This script is only valid on Darwin systems"
    exit 1
fi

if [ -z "$(brew cask list textadept | grep -i textadept)" ]; then
    brew cask install textadept
    INSTALL_PATH=/Applications/TextAdept.app/Contents/MacOS
	  ln -fs $(INSTALL_PATH)/textadept_osx /usr/local/bin/ta
	  ln -fs $(INSTALL_PATH)/textadept-curses /usr/local/bin/ta-nox
else
    exit 0
fi
