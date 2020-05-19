.DEFAULT_GOAL := help
.PHONY: help install install-linux

OS = $(shell uname | tr [:upper:] [:lower:])

help:
	./view_help README.md

install:
	make install-$(OS)

install-linux:
	cp godot.desktop /usr/share/applications/
	cp godot.svg /usr/share/app-install/icons/
	echo "godot is expected to be on your path"
