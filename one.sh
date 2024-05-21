debootstrap --arch amd64 bookworm /mnt http://ftp.us.debian.org/debian
mount -t proc /proc /mnt/proc
mount --rbind /sys /mnt/sys
mount --rbind /dev /mnt/dev
mount -o bind /dev/pts /mnt/dev/pts
cp ./fstab /mnt/etc/fstab
cp /etc/adjtime /mnt/etc/adjtime
cp /etc/network/interfaces /mnt/etc/network/interfaces
cp /etc/resolv.conf /mnt/etc/resolv.conf
cp ./hosts /mnt/etc/hosts
cp ./hostname /mnt/etc/hostname
cp ./sources.list /mnt/etc/apt/sources.list
cp ./90-limits.conf /mnt/etc/security/limits.d/
cp *.sh /mnt/root
LANG=en_US.UTF-8 chroot /mnt /bin/bash

