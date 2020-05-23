.DEFAULT_GOAL := help
.PHONY: help install

OS = $(shell uname | tr [:upper:] [:lower:])

help:
	./view-help.sh README.md

install:
	./install-$(OS).sh
