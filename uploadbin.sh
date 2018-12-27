#!/bin/bash

#grab filename from rom dir

#find live host
thefile=""
while ! ping -c1 -w1 $host  &> /dev/null
do
	thefile=$(ls /media/usb0/ | head -1) # Limit to one file
	host=$(cat /var/lib/misc/dnsmasq.leases | grep -i 00:D0:F1 | cut -f3 -d " ") # Filter for only Naomis
        echo "pinging $host"
        sleep 2
done

echo "Naomi is up at $host"
#shipit
echo sending $thefile
echo /home/pi/pi0-netboot/netboot_upload_tool $host 10703 /media/usb0/$thefile 
/home/pi/pi0-netboot/netboot_upload_tool $host 10703 /media/usb0/$thefile 


