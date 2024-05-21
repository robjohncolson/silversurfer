#!/bin/bash
#bash ansi escape sequences: https://www.ing.iac.es/~docs/external/bash/abs-guide/colorizing.html
#

function get_efi_label {

clear
read -p "After you press enter, BLKID will run.  Copy or remember the PARTUUID or PARTLABEL that corresponds with where you want to create the EFI partition."
clear
echo $'\n'
		blkid
	echo $'\n'
	echo -n "enter partition label for EFI: "
	read efilabel
	clear
	result=$(blkid | grep $efilabel)
	echo $result | grep -w -q $efilabel
	if [ $? -lt 1 ]; then
echo -en '\E[47;31m'"\033[1mMATCH\033[0m"   # Red
tput sgr0
	else
echo -e '\E[37;44m'"\033[1mNO MATCH\033[0m"
tput sgr0
fi
	echo $'\n'
	echo -n "satisfied with output of blkid? [Y/N] "
	read YN
	re=[Nn]

		if [[ "$YN" =~ $re ]]; then
		exit
	else
		echo "YES?!?!"
	fi

	read -p "press enter if satisfied with output"
}


function get_root_label {

	clear
	read -p "After you press enter, BLKID will run.  Copy or remember the PARTUUID or PARTLABEL that corresponds with where you want to create the root partition."
clear
echo $'\n'
		blkid
	echo $'\n'
	echo -n "enter partition label for root: "
	read rootlabel
	clear
	result=$(blkid | grep $rootlabel)
	echo $result | grep -w -q $rootlabel
	if [ $? -lt 1 ]; then
echo -en '\E[47;31m'"\033[1mMATCH\033[0m"   # Red
tput sgr0
	else
echo -e '\E[37;44m'"\033[1mNO MATCH\033[0m"
tput sgr0
fi
	echo $'\n'
	echo -n "satisfied with output of blkid? [Y/N] "
	read YN
	re=[Nn]

		if [[ "$YN" =~ $re ]]; then
		exit
	else
		echo "YES?!?!"
	fi

	read -p "press enter if satisfied with output"
}

get_root_label
echo $rootlabel
	read -p "press enter if satisfied with output"
get_efi_label
echo $efilabel
	read -p "press enter if satisfied with output"
exit
re=$?

if [[ $re =~ ^[0-9]+$ ]]; then
   echo "${re} is a number"
else
   echo "${re} is not a number"
fi

if [[ "$?" =~ re ]]; then
	echo $'\n'
	echo "successful root-labelling"
	exit
else
	echo $'\n'
	echo "unsuccessful root-labeling"
	exit
fi



if test -d /mnt; then
	mount PARTLABEL="unecrypted" /mnt
	echo "mounted root onto /mnt"
else
	mkdir /mnt
	echo "created /mnt"
	mount PARTLABEL="unecrypted" /mnt
	echo "mounted root onto /mnt"
fi

swapon PARTUUID="35506838-06"
#swapon UUID="acc82c62-be14-41e6-82fc-9d623844014c"
debootstrap --arch amd64 bookworm /mnt http://ftp.us.debian.org/debian
mount -t proc /proc /mnt/proc
mount --rbind /sys /mnt/sys
mount --rbind /dev /mnt/dev
mount -o bind /dev/pts /mnt/dev/pts
mount PARTUUID="35506838-02" /mnt/boot
mkdir /mnt/boot/EFI
mount PARTUUID="35506838-01" /mnt/boot/EFI
cp ./fstab /mnt/etc/fstab
cp /etc/adjtime /mnt/etc/adjtime
cp /etc/network/interfaces /mnt/etc/network/interfaces
cp /etc/resolv.conf /mnt/etc/resolv.conf
cp ./hosts /mnt/etc/hosts
cp ./hostname /mnt/etc/hostname
cp ./sources.list /mnt/etc/apt/sources.list
cp ./install-commands.sh /mnt/root/
cp ./90-limits.conf /mnt/etc/security/limits.d/

LANG=en_US.UTF-8 chroot /mnt /bin/bash

