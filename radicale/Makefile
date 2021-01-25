.DEFAULT_GOAL := help
.PHONY: help install

help:
	../view-help.sh README.md

install:
	setup.sh
	cp config /var/lib/radicale/
	cp radicale.service /etc/systemd/system/
	systemctl enable radicale.service
	systemctl start radicale.service
