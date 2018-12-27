#!/bin/bash
#start webserver for naominet.jp
cd /home/pi/pi0-netboot/; python -m SimpleHTTPServer 80&

#grab filename from rom dir
thefile=$(ls /home/pi/pi0-netboot/RomBINS/)

#find live host
z=192.168.1
foundit=0

sleep 10

while [ ${foundit} -ne 1 ]
do
for i in `seq 100 102`
do
	ping -c1 ${z}.${i} > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		hostlive=${z}.${i}
		foundit=1
		break
	fi
done
done

#shipit
/home/pi/pi0-netboot/netboot_upload_tool $hostlive 10703 /home/pi/pi0-netboot/RomBINS/$thefile 
