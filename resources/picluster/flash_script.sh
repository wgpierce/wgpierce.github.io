#set up the master node
#inform it of all nodes on the network
for i in `seq -f "%02g" 0 11`; do
	echo -e "192.168.2.1$i\trpi$i" >> /etc/hosts
done
mkdir boot
mkdir root
ssh-keygen

# make sure ethernet-static file is configured

#let i be the number to be edited
for i in `seq -f "%02g" 1 11`; do

read -p "Press enter when sd card is loaded"

#verify the card is found in filesystem
#will only work if a parition is present
while ! [ -e /dev/sdb1 ]; do
	echo "waiting for sd card"
	sleep 1
done

echo "sd card found. Setting up.."

#filesystem formatting
parted -s /dev/sdb mklabel msdos mkpart primary fat32 1MiB 100MiB set 1 boot on mkpart primary ext4 100MiB 100%
sync
mkfs.vfat /dev/sdb1
mkfs.ext4 -F /dev/sdb2
sync
mount /dev/sdb1 boot
mount /dev/sdb2 root
sync
bsdtar -xpf ArchLinuxARM-rpi-2-latest.tar.gz -C root
sync
mv root/boot/* boot

#automatic cluster configuration

#hostnames for each node
echo rpi$i >> root/etc/hostname

#passwordless ssh
echo "PubkeyAuthentication yes" >> root/etc/ssh/sshd_config
mkdir -p root/home/alarm/.ssh
cp .ssh/id_rsa.pub root/home/alarm/.ssh/authorized_keys

#give root access too
mkdir -p root/root/.ssh
cp .ssh/id_rsa.pub root/root/.ssh/authorized_keys

#change password
#XXX: yes, probably more secure way
#chroot root echo "alarm:<password>" | chpasswd
#cannot chroot across different architectures - equivalents are used

#disable default dhcp services to allow static ethernet connection
#chroot root systemctl disable netctl-ifplugd@eth0.service
#rm root/etc/systemd/system/multi-user.target.wants/netctl-ifplugd@eth0.service

#chroot root systemctl disable systemd-networkd
rm root/etc/systemd/system/dbus-org.freedesktop.network1.service
rm root/etc/systemd/system/multi-user.target.wants/systemd-networkd.service
rm root/etc/systemd/system/sockets.target.wants/systemd-networkd.socket
rm root/etc/systemd/system/network-online.target.wants/systemd-networkd-wait-online.service

#declare static ethernet connection
cp ethernet-static root/etc/netctl
echo "Address=('192.168.2.1$i/24')" >> root/etc/netctl/ethernet-static

#enable static ethernet
#chroot root netctl enable ethernet-static
cp 'netctl@ethernet\x2dstatic.service' 'root/etc/systemd/system/netctl@ethernet\x2dstatic.service'
ln -s 'root/etc/systemd/system/netctl@ethernet\x2dstatic.service' 'root/etc/systemd/system/multi-user.target.wants/netctl@ethernet\x2dstatic.service'

umount boot root
done
