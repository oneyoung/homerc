# ARCH install guide

#### 准备ISO 文件引导

##### 下载ISO文件
我下的是201108 i686版本

##### 用U盘启动。
因为我用的是multi-boot，不能直接dd，先做一个grub启动菜单

	menuentry "Arch Linux i686" {
		search --set -f "/archlinux_i686.iso"
		loopback loop "/archlinux_i686.iso"
		linux (loop)/arch/boot/i686/vmlinuz archisolabel=archiso
		initrd (loop)/arch/boot/i686/archiso.img
	}
>  注意，这里加了 *archisolable* 选项，会在之后系统安装的时候用到

然后,从U盘启动.系统会提示找不到boot device，这是因为从U盘启动的时候找不到arch iso 安装盘。这时会进入一个shell，可以在这里将ISO 挂载上：

	mkdir /u_disk # create a directory for later U-disk mount
	mount -t vfat /dev/sdb2 /u_disk #check your U-disk, I install multi-boot in the second partition.
	# assigned the ISO to the system
	modprobe loop
	losetup /dev/loop0 /u_disk/archlinux_i686.iso
	ln -s /dev/loop0 /dev/disk/by-label/archiso
	exit

从这之后就进入正常的安装过程了 ^\_^

###### install in new iso.

configure network if dhcp failed

	ip link set eth0 up
	ip addr show dev eth0
	ip addr add 192.168.1.100/24 dev eth0
	ip route add default via 192.168.1.1

add dns support

	echo "nameserver 8.8.8.8" > /etc/resolv.conf

format the disk

	mkfs -t ext4 /dev/sda1

choose the fast source

	/etc/pacman.d/mirrorlist

install the base and base-devel

	mount /dev/sda1 /mnt/root/
	pacstrap /mnt base base-devel

install grub

	pacstrap /mnt grub-bios
	pacstrap /mnt syslinux

chroot

	arch-chroot /mnt/root

configure timezone

	ln -s /usr/share/zoneinfo/Asaia/Shanghai /etc/localtime
	# then add time zone to rc.conf "TIMEZONE="Asia/Shanghai""
	config the below file
	/etc/fstab
	/etc/locale.gen
	/etc/locale.conf
	=> run: locale-gen
	/etc/mkinitcpio.conf
	=> run: mkinitcpio -p linux

#### Configure

##### add usr
建立一个普通帐号，直接使用以前Ubuntu下的home目录：

	useradd -d /home/oneyoung -s /bin/bash oneyoung
	passwd oneyoung

要让帐号拥有sudo权限的话：

> make sure you are root

	pacman -S sudo
	visudo #the recommended way to edit /etc/sudoers

##### 安装X和显卡驱动（ATI Mobility 2400XT）：
install basic X packages

	sudo pacman -S xorg-server xorg-xinit xorg-utils xorg-server-utils

install ati driver

	sudo pacman -S xf86-video-ati

##### install yaourt
add archlinuxfr to /etc/pacman.conf

	[archlinuxfr]
	Server = http://repo-fr.archlinuxcn.org/$arch

then install yaourt directly:

	sudo pacman -S yaourt


##### install input method (fcitx)
install the package:

	sudo pacman -Sy fcitx

make sure export the following variables to the environment

> better to put this in *.initrc*

	export XIM=fcitx
	export XIM_PROGRAM=fcitx
	export XMODIFIERS="@im=fcitx"
	export GTK_IM_MODULE=xim
	export QT_IM_MODULE=xim

add English input method for *word completion*

	yaourt -S fcitx-en-git

##### install awesome windows manager

	sudo pacman -Sy awesome

config the xinitrc

	# copy /etc/X11/xinit/xinitrc to ~/.xinitrc
	cp /etc/X11/xinit/xinitrc ~/.xinitrc
	# comment out the xterm 
	# and add awesome to the end of file
	# then just type startx, you can run awesome
	startx

copy awesome config file to home dir

	mkdir -p ~/.config/awesome/
	cp /etc/xdg/awesome/rc.lua ~/.config/awesome/

##### enable wireless support
install `net-tools`(ifconfig etc), `wireless_tools`(iwconfig etc.), `wpa_supplicant`(for WPA encryption)

	sudo pacman -S net-tools wireless_tools wap_supplicant

enable network manager

	sudo pacman -Sy wicd wicd-gtk

##### enable "comand not found" hint
install `pkgtools`:

	sudo pacman -Sy pkgtools pkgfile

and set `CMD_SEARCH_ENABLE=1` in */etc/pkgtools/pkgfile.conf*, then:

	sudo pkgfile --update
	source /etc/profile #if you don't want to logout again

##### audio support
install alsa and add the user to audio group

	pacman -S alsa-utils alsa-lib
	gpasswd -a oneyoung audio

add alsa daemo to rc.conf

	DAEMONS=(syslog-ng dbus crond wicd alsa vmwared)

alsaconf配置声卡，生成/etc/asound。state文件。保存以后的音量调节数据：

	根据提示操作，程序会找到你机器上的声卡类型（大多数情况下都会正确地找到）
会在/etc下生成asound。state文件，用来保存以后对音量的调解数据，要不每次开机后会默认给你开静音。

音量调节：alsamixer

	运行alsamixer，出现图形话界面，使用上下箭头键来调解音量大小，使用左右键来移动到不同的项目。例如：耳麦声音等。在界面上你会发现，只有下面显示为“00”的项目，才可以使用上下键来调节音量。而“MM”标示的却不成,如果想启用这些项目。只需移到“00”处，按下“m”键，皆可激活，再按一次会再禁用。 调节完毕后，按esc键退出，程序会自动保存数据。

测试：

	aplay /usr/share/sounds/alsa/Front-Center.wav

会听到女声说:"Front-Center",当然你可以一次都测试完：

	aplay /usr/share/sounds/alsa/*.wav

graphy tool for volumecontorl

	pacman -S volumeicon

##### key mapping: swap `Esc` and `Caps_Locks`
add .Xmodmap file to HOME dir with the below content

	remove Lock = Caps_Lock
	keysym Escape = Caps_Lock
	keysym Caps_Lock = Escape
	add Lock = Caps_Lock

then run below to take effect

	xmodmap ~/.Xmodmap

##### auto mount USB mass storage
install udiskie:

	sudo yaourt -S udiskie #now change to python2-udiskie
	sudo pacman -S consolekit #for permission control

start udiskie daemon:

	exec ck-launch-session awesome
	#then add "os.execute "udiskie &" to rc.lua

polkit config (*permission for disk mount*):

	# file: /etc/polkit-1/localauthority/50-local.d/10-udiskie.pkla

	[Local Users]
	Identity=unix-group:storage
	Action=org.freedesktop.udisks*.*
	ResultAny=yes
	ResultInactive=no
	ResultActive=yes

##### sudo password can't work
solution reinstall packages: 

	pambase pam

##### install thunder download tool

	sudo yaourt -S wine-thunder

##### install login manager

	pacman -S slim

edit /etc/slim.conf

	"session awesome"

add slim to login session

+ open file `/etc/inittab`
+ change line `id:3:initdefault:` to `id:5:initdefault:`
+ find the line `x:5:respawen...` and replace the cmd with `/usr/bin/slim > /dev/null 2>&1`

##### install vmplayer
download vmplayer from [offical website](http://www.vmware.com/go/downloadplayer/)

then:
	chmod +x VMware-<edition>-<version>.<release>.<architecture>.bundle
	./VMware-<edition>-<version>.<release>.<architecture>.bundle --console

start `vmwared` in `/etc/rc.conf`

install hal for vmwared 

	yaourt -S hal

USB support:

	./VMware-<edition>-<version>.<release>.<architecture>.bundle --console --extract /tmp
	cp /tmp/vmware-usbarbitrator/etc/init.d/vmware-USBArbitrator /etc/rc.d/


##### install 32bit support for `ARCH_64`
uncomment the line in `/etc/pacman.conf`

	[multilib]
	SigLevel = PackageRequired
	Include = /etc/pacman.d/mirrorlist

install the packages

	sudo pacman -Sy lib32-zlib lib32-ncurses lib32-readline gcc-libs-multilib gcc-multilib lib32-gcc-libs

##### font config

	yaourt -Sy cairo-ubuntu fontconfig-lcd fontconfig-ubuntu freetype2-ubuntu libxft-ubuntu

##### install kupfer to replace gnome-do

	yaourt -S kupfer

##### android build support
!!!the packages in ARCH Linux is too new!!!

+ subversion -- 1.6 (addition: sudo ln -s /usr/lib/libdb.so /usr/lib/libdb-5.2.so)
	mali use subversion in its makefile
+ make -- 3.81
+ gcc -- 4.4
	1. install gcc44 from aur,
	2. modify the PKGBUILD, remove the option --disable-multilib, add --with-multilib-list=m32,m64
	3. install package with pacman -Uf gcc.pag to ignore file conflic in /usr/lib32
	4. better to reinstall gcc-multilib to resotre file conflict
	5. make link: ln -s /usr/lib32 /lib32 to avoid ld error
	6. add link to gcc and g++ with gcc-4.4 and make sure import the path before /usr/bin
+ libgl -- 32 bits: pacman -S lib32-libgl
+ kmod -- arch version is also has problem (it will search usr/lib/ instead of lib/)
+ rlimit -- not found in davlink, add <sys/resource.h>


##### bash completion

	pacman -S bash-completion


##### install virtualbox
install virutalbox

	pacman -S virtualbox virtualbox-guest-iso virtualbox-host-modules

load vbox modules at bootup

+ automode: create a file, for example `vbox.conf` under dir /etc/modules-load.d/ with the content `vboxdrv`
+ manual way: `modprobe vboxdrv`
