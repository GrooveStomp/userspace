.DEFAULT_GOAL := help
.PHONY: help install install-darwin

OS = $(shell uname | tr [:upper:] [:lower:])
DARWIN_INSTALL_PATH = /Applications/TextAdept.app/Contents/MacOS

help:
	./view-help.sh README.md

install:
	make install-$(OS)

install-darwin:
	./install-darwin.sh
	ln -fs $(DARWIN_INSTALL_PATH)/textadept_osx /usr/local/bin/ta
	ln -fs $(DARWIN_INSTALL_PATH)/textadept-curses /usr/local/bin/ta-nox
