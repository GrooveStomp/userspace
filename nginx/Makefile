.DEFAULT_GOAL := help
.PHONY: help install

help:
	../view-help.sh README.md

install:
	cp home.groovestomp.com /etc/nginx/sites-available/
	ln -s /etc/nginx/sites-available/home.groovestomp.com /etc/nginx/sites-enabled/home.groovestomp.com
