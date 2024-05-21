export TERM=xterm-color
mount -a
dpkg-reconfigure tzdata
apt update
apt -y install locales
dpkg-reconfigure locales
apt -y install linux-image-amd64 firmware-linux-nonfree firmware-iwlwifi ncdu
apt install linux-image-$(uname -r|sed 's,[^-]*-[^-]*-,,') linux-headers-$(uname -r|sed 's,[^-]*-[^-]*-,,') broadcom-sta-dkms
modprobe -r b44 b43 b43legacy ssb brcmsmac bcma
modprobe wl
apt -y install mtools dosfstools grub-efi-amd64
grub-install --efi-directory=/boot/efi
apt -y install ssh vim tmux refind git ufw htop
passwd
adduser user
tasksel install standard
apt clean
tasksel
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw logging off
ufw enable
systemctl enable ufw
apt -y install fail2ban
