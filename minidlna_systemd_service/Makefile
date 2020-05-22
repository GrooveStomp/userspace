.DEFAULT_GOAL := help
.PHONY: help install

help:
	./view-help.sh README.md

install:
	cp bash/minidlna-mount-check /usr/local/bin/
	cp systemd/minidlna-mount-check.timer /etc/systemd/system/
	cp systemd/minidlna-mount-check.service /etc/systemd/system/
	systemctl enable minidlna-mount-check.timer
