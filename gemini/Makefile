.DEFAULT_GOAL := help
.PHONY: help install

help:
	../view-help.sh README.md

install:
	bash install-geminid.sh
	mkdir -p /var/lib/gemini
	cp geminid.conf /var/lib/gemini
	mkdir -p /var/www/gemini/home.groovestomp.com
	cp geminid.service /etc/systemd/system/
	systemctl enable geminid.service
	systemctl start geminid.sevice
