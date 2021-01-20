# What is Userspace?
This is just a grab-bag of miscellaneous scripts and utilities I find useful for my personal computing devices.
Primarily these are POSIX-compliant systems running systemd; but that's not the sole focus; it just happens to be that way.

Each directory is concerned with a single application.  That directory will typically include scripts for installing the program using the system's package manager, setting up .desktop files, enabling systemd units and other such things.  Not every directory does all of these things or even any of these things.

These programs are only tested on my personal devices and sometimes not even then - they might just be a place to dump configuration.

Within each directory you will find a `Makefile`.  You can always run `make help` which shows the directory-local README.md.  If you have `mdv` or `glow` then it prints the README nicely for you.
