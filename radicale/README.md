Radicale Caldav/Cardav server

# Dependencies
- Linux system
- systemd
- python 3
- python 3 pip

# Usage

    make help
    sudo make install

# What it does
- Install radicale if it isn't available via `which radicale`.
- Create the radicale user if it isn't present in `/etc/passwd`.
- Create `/var/lib/radicale` and copy the config there.
- Install the radicale systemd unit, enable it and start it.
