.DEFAULT_GOAL := help
.PHONY: help install

help:
	../view-help.sh README.md

install:
	bash generate-conf.sh && mv miniflux.conf /etc/miniflux.conf
