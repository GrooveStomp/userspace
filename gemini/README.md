# Dependencies
- Linux system
- systemd
- git
- [geminid](https://github.com/jovoro/geminid.git)

If geminid is not available then we attempt to install it.

# Usage

    make help
    sudo make install

# What it does
- Create the library path for geminid @ /var/lib/gemini.
- Create the www path for geminid @ /var/www/gemini.
- Install the geminid configuration to /var/lib/gemini/geminid.conf.
- Install the systemd unit for geminid to /etc/systemd/system/geminid.service.
- Enable and start the systemd unit.

# Other Reading
geminid requires SSL certs to be present.
AFAICT there are 1000 different ways to generate certs; most of which will be invalid for our purposes.

This is the mechanism I used that seemed to work:

    openssl ecparam -genkey -name secp384r1 -out server.key
    openssl req -new -x509 -sha256 -key server.key -out server.crt -days 3650

This was documented in the repo for a [different gemini server](https://github.com/a-h/gemini).
