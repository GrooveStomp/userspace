.DEFAULT_GOAL := help
.PHONY: help install

help:
	../view-help.sh README.md

install:
	apt install ddclient
	cp ddclient.conf /etc/
	sed "s/password=/password=$(gpg -d password.gpg)/" /etc/ddclient.conf
	systemctl enable ddclient
	systemctl start ddclient
