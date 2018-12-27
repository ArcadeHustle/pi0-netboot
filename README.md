# pi0-netboot
Single Game USB based NetBoot interface for Raspberry and Orange Pi Zero

# Example script to install on Orange Pi Zero - https://www.armbian.com/orange-pi-zero/

https://dl.armbian.com/orangepizero/Debian_stretch_next.7z

This will download a file named Armbian_5.65_Orangepizero_Debian_stretch_next_4.14.78.7z

Unpack and write with Etcher
https://www.etcher.io/

Connect to USB, wait approx 1-2 minutes while system  boots 

screen /dev/tty.usbxxx 115200
 
Login with root /1234 , set yourself a password. 

create a new user as asked. 

apt-get update
apt-get dist-upgrade
apt-get install openssh-server dnsmasq lockfile-progs

update-rc.d -f dnsmasq remove
rm /etc/systemd/system/multi-user.target.wants/dnsmasq.service

wget http://http.us.debian.org/debian/pool/main/u/usbmount/usbmount_0.0.22_all.deb
dpkg -i usbmount_0.0.22_all.deb

echo -e "\nauto eth0" >> /etc/network/interfaces
echo "allow-hotplug eth0" >> /etc/network/interfaces
echo "iface eth0 inet static" >> /etc/network/interfaces
echo "address 192.168.1.1" >> /etc/network/interfaces
echo "netmask 255.255.255.0" >> /etc/network/interfaces 
echo "network 192.168.1.1" >> /etc/network/interfaces
echo "gateway 192.168.1.1" >> /etc/network/interfaces

apt-get remove network-manager
apt autoremove

echo '#!/bin/sh -e' > /etc/rc.local
echo 'cd /home/pi/pi0-netboot/; python -m SimpleHTTPServer 80&' >> /etc/rc.local
echo 'rm /var/lib/misc/dnsmasq.leases' >> /etc/rc.local
echo 'dnsmasq --interface=eth0 --except-interface=lo -R --dhcp-range=192.168.1.100,192.168.1.102,255.255.255.0,5m --dhcp-option=6,192.168.1.1 --dhcp-option=3,192.168.1.1 --log-dhcp -q -K -d &'  >> /etc/rc.local
echo '/home/pi/pi0-netboot/uploadbin.sh&'  >> /etc/rc.local
echo 'exit 0'   >> /etc/rc.local


## Todo ###

/etc/usbmount/usbmount.conf edit 
create /etc/systemd/system/usbmount@.service
/lib/udev/rules.d/usbmount.rules
/etc/systemd/system/systemd-udevd.service.d/shared-mount-ns.conf

