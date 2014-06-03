# Raspberry PI WiFi Hotspot
**This is work in progress, so no garantuees it will work as advertised...**

## Instructions
1. Create a ssh keypair
2. Specify the custom settings in `bootstrap.conf`
3. Create the host_vars file as described in 'Configuration'
4. Run `./bootstrap.sh`

## Configuration
Place the configuration in `ansible/config/host_vars/localhost.yml`
This is an example of the configuration
```
---
nameservers:
  - 8.8.8.8
  - 8.8.4.4
local_network:
  device: wlan0
  macaddress: aa:aa:aa:aa:aa:aa
  ipaddress: 192.168.1.1
  dhcp:
    start: 192.168.1.100
    end: 192.168.1.199
  ssid: RPI-local
  passphrase: passphrase-local
upstream_network:
  device: wlan1
  macaddress: aa:aa:aa:aa:aa:aa
  ssid: RPI-upstream
  passphrase: passphrase-upstream
forward_device: eth0
```
