#!/bin/sh
#Autor: Henry Chumo 
#Alias : ChumoGH

id1=$(free -h | grep -i mem | awk {'print $4'})
idM=$(echo $id1 |sed 's/[A-Z]//g')
idm=$(echo $idM |sed 's/[a-z]//g')
n=90
tiempo=$(printf '%(%D-%H:%M:%S)T') 
if [ "$n" -gt "$idm" ]; then 
echo $idm "Mbs  -  Limpiando y Reiniciado el " $tiempo >> /root/lm.log
echo 3 > /proc/sys/vm/drop_caches 1> /dev/null 2> /dev/null
sysctl -w vm.drop_caches=3 1> /dev/null 2> /dev/null
swapoff -a && swapon -a 1> /dev/null 2> /dev/null
sudo sync
sudo sysctl -w vm.drop_caches=3
sysctl -w vm.drop_caches=3 > /dev/null 2>&1
swapoff -a && swapon -a 1> /dev/null 2> /dev/null
rm -rf /tmp/*
sudo apt autoremove -y
sudo apt purge & sudo apt clean 
sudo rm /var/lib/apt/lists/lock && sudo rm /var/cache/apt/archives/lock && sudo rm /var/lib/dpkg/lock

else 
echo $n "Mbs - Esta bajo el limite " $id1 " el " $tiempo >> /root/lm.log
fi
