# wgutil
A utility for creating and removing users and interfaces in a wireguard server.

Just execute `wgutil` to see the manual.

This utility comes handy when you have installed "wireguard" module on your server and want to set it up and start using it.
The script assumes "eth0" as the public interface on the server. In order to change that, change the variable `MAINIF` in the script to your public network interface name.

### Requirements
- wireguard (Follow installation instructions for your distro [**here**](https://www.wireguard.com/install/))
- qrencode
