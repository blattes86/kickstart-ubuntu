#!/bin/sh
#
# On vérifie que le script n'a pas déjà été
# exécuté
if [ ! -e /root/post_exec ]
then
	graphique=graphique1
	if [ $graphique = "xubuntu" ]
	then
	/etc/init.d/lightdm stop
	fi
	if [ $graphique = "kubuntu" ]
	then
	/etc/init.d/kdm stop
	fi
	exec < /dev/tty1 > /dev/tty1
	chvt 1
	echo "Performing post-install" > /etc/nologin
	
	date 2>&1 | tee -a /root/post.log
	version=`cat /etc/lsb-release | grep CODENAME | sed 's/DISTRIB_CODENAME=//'`

	echo "$graphique" >> /root/post.log
	echo "deb http://depot.alis44.org/ubuntu/ $version main restricted universe multiverse" > /etc/apt/sources.list
	echo "deb http://depot.alis44.org/ubuntu/ $version-security main restricted universe multiverse" >> /etc/apt/sources.list
	echo "deb http://depot.alis44.org/ubuntu/ $version-updates main restricted universe multiverse" >> /etc/apt/sources.list
	echo "deb http://depot.alis44.org/ubuntu/ $version-backports main restricted universe multiverse" >> /etc/apt/sources.list
	echo "deb http://depot.alis44.org/ubuntu/ $version-proposed main restricted multiverse universe" >> /etc/apt/sources.list
	echo "deb http://depot.alis44.org/ubuntu-security/ $version main restricted universe multiverse" >> /etc/apt/sources.list
	echo "deb http://depot.alis44.org/ubuntu-security/ $version-security main restricted universe multiverse" >> /etc/apt/sources.list
	echo "deb http://depot.alis44.org/ubuntu-security/ $version-updates main restricted universe multiverse" >> /etc/apt/sources.list
	echo "deb http://depot.alis44.org/ubuntu-security/ $version-backports main restricted universe multiverse" >> /etc/apt/sources.list
	echo "deb http://depot.alis44.org/ubuntu-security/ $version-proposed main restricted multiverse universe" >> /etc/apt/sources.list
	echo "deb http://depot.alis44.org/canonical/ $version partner" >> /etc/apt/sources.list
	echo "deb http://depot.alis44.org/canonical/ $version-security partner" >> /etc/apt/sources.list
	echo "deb http://depot.alis44.org/canonical/ $version-updates partner" >> /etc/apt/sources.list
	echo "deb http://depot.alis44.org/canonical/ $version-backports partner" >> /etc/apt/sources.list
	echo "deb http://depot.alis44.org/canonical/ $version-proposed partner" >> /etc/apt/sources.list
	echo "deb http://depot.alis44.org/medibuntu/ $version free non-free" >> /etc/apt/sources.list
	echo "deb http://depot.alis44.org/libreoffice $version main" >> /etc/apt/sources.list
	echo "deb http://depot.alis44.org/java $version main" >> /etc/apt/sources.list
	if [ $graphique = "xubuntu" ]
	then
		echo "deb http://depot.alis44.org/xfce $version main" >> /etc/apt/sources.list
	fi

	### ajout clé dépot
	wget -q http://depot.alis44.org/cle/medibuntu-key.gpg -O- | apt-key add - 2>&1 | tee -a /root/post.log
	wget -q http://depot.alis44.org/cle/java-ppa.gpg -O- | apt-key add - 2>&1 | tee -a /root/post.log
	wget -q http://depot.alis44.org/cle/libreoffice-ppa.gpg -O- | apt-key add - 2>&1 | tee -a /root/post.log
	if [ $graphique = "xubuntu" ]
	then
	wget -q http://depot.alis44.org/cle/xfce-ppa.gpg -O- | apt-key add - 2>&1 | tee -a /root/post.log
	fi

	### mise à jour de la liste des paquets
	apt-get update 2>&1 | tee -a /root/post.log

	### rajout réponse automatique
	apt-get -fy install debconf-utils 2>&1 | tee -a /root/post.log

	cat > /root/debconf << EOF
echo acroread-common	acroread-common/default-viewer	boolean	true
echo ttf-mscorefonts-installer	msttcorefonts/dlurl	string	
echo ttf-mscorefonts-installer	msttcorefonts/accepted-mscorefonts-eula	boolean	true
echo ttf-mscorefonts-installer	msttcorefonts/present-mscorefonts-eula	note	
echo ttf-mscorefonts-installer	msttcorefonts/baddldir	error	
echo ttf-mscorefonts-installer	msttcorefonts/dldir	string	
echo ttf-mscorefonts-installer	msttcorefonts/error-mscorefonts-eula	error
echo oracle-java6-installer	shared/present-oracle-license-v1-1	note	
echo oracle-java6-installer	shared/accepted-oracle-license-v1-1	boolean	true
echo oracle-java6-installer	oracle-java6-installer/not_exist	error	
echo oracle-java6-installer	shared/error-oracle-license-v1-1	error	
echo oracle-java6-installer	oracle-java6-installer/local	string	
EOF
	2>&1 | tee -a /root/post.log
	debconf-set-selections < /root/debconf
	###mise a jour de la distrib
	echo "upgrade" >> /root/post.log
	apt-get -fy upgrade 2>&1 | tee -a /root/post.log
	echo "dist-upgrade" >> /root/post.log
	apt-get -fy dist-upgrade 2>&1 | tee -a /root/post.log

	### installation de paquet
	if [ $graphique = "xubuntu" ]
	then
		echo "install logiciel Xubuntu" >> /root/post.log
		apt-get -fy install aspell-fr gimp-help-fr thunderbird libreoffice gnome-orca gedit 2>&1 | tee -a /root/post.log
	fi
	if [ $graphique = "kubuntu" ]
	then
		echo "install logiciel Kubuntu" >> /root/post.log
		apt-get install -fy thunderbird gimp gimp-help-fr gedit firefox libreoffice gnome-orca synaptic software-center gnome-terminal kde-l10-fr language-pack-kde-fr language-pack-kde-fr-base 2>&1 | tee -a /root/post.log
	fi
	echo "install commun" >> /root/post.log
	apt-get -fy install thunderbird-locale-fr wfrench firefox-locale-fr poppler-data libreoffice-l10n-fr libreoffice-help-fr mythes-fr oracle-java6-installer libdvdcss2 skype non-free-codecs mozilla-libreoffice mozilla-plugin-vlc libxine1-all-plugins xine-plugin unrar unrar-free unace unace-nonfree gnucash rhythmbox firefox-launchpad-plugin hyphen-fr hunspell-fr ubuntu-restricted-addons ubuntu-restricted-extras gstreamer0.10-fluendo-mp3 gstreamer0.10-plugins-ugly gstreamer0.10-sdl locate htop acroread-fonts adobe-flashplugin adobereader-fra jargoninformatique openjdk-7-jre openjdk-7-jdk htop locate htop unp 2>&1 | tee -a /root/post.log
		
	### supression paquet
	if [ $graphique = "xubuntu" ]
	then
		echo "supression logiciel Xubuntu" >> /root/post.log
		apt-get -fy remove --purge abiword* xchat* gmusicbrowser gnumeric* leafpad* orage* onboard* xfce4-dict 2>&1 | tee -a /root/post.log
	fi
	if [ $graphique = "kubuntu" ]
	then
		echo "supression logiciel Kubuntu" >>root/post.log
		apt-get -fy remove --purge kontact* kmail* rekonq* koffice* language-pack-en language-pack-en-base language-pack-gnome-en language-pack-gnome-en-base language-pack-kde-en language-pack-kde-en-base 2>&1 | tee -a /root/post.log
	fi
	
	#### installation dvd
	/usr/share/doc/libdvdread4/install-css.sh 2>&1 | tee -a /root/post.log

	### mise en place dépot ext
	echo "deb http://fr.archive.ubuntu.com/ubuntu/ $version main restricted universe multiverse" > /etc/apt/sources.list
	echo "deb http://fr.archive.ubuntu.com/ubuntu/ $version-security main restricted universe multiverse" >> /etc/apt/sources.list
	echo "deb http://fr.archive.ubuntu.com/ubuntu/ $version-updates main restricted universe multiverse" >> /etc/apt/sources.list
	echo "deb http://fr.archive.ubuntu.com/ubuntu/ $version-backports main restricted universe multiverse" >> /etc/apt/sources.list
	echo "deb http://fr.archive.ubuntu.com/ubuntu/ $version-proposed main restricted multiverse universe" >> /etc/apt/sources.list
	echo "deb http://security.ubuntu.com/ubuntu $version main restricted universe multiverse" >> /etc/apt/sources.list
	echo "deb http://security.ubuntu.com/ubuntu $version-security main restricted universe multiverse" >> /etc/apt/sources.list
	echo "deb http://security.ubuntu.com/ubuntu $version-updates main restricted universe multiverse" >> /etc/apt/sources.list
	echo "deb http://security.ubuntu.com/ubuntu $version-backports main restricted universe multiverse" >> /etc/apt/sources.list
	echo "deb http://security.ubuntu.com/ubuntu $version-proposed main restricted multiverse universe" >> /etc/apt/sources.list
	echo "deb http://archive.canonical.com/ubuntu $version partner" >> /etc/apt/sources.list
	echo "deb http://archive.canonical.com/ubuntu $version-security partner" >> /etc/apt/sources.list
	echo "deb http://archive.canonical.com/ubuntu $version-updates partner" >> /etc/apt/sources.list
	echo "deb http://archive.canonical.com/ubuntu $version-backports partner" >> /etc/apt/sources.list
	echo "deb http://archive.canonical.com/ubuntu $version-proposed partner" >> /etc/apt/sources.list
	echo "deb http://packages.medibuntu.org/ $version free non-free" >> /etc/apt/sources.list
	echo "deb http://ppa.launchpad.net/libreoffice/ppa/ubuntu $version main" >> /etc/apt/sources.list
	echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu $version main" >> /etc/apt/sources.list
	if [ $graphique = "xubuntu" ]
	then
		echo "deb http://ppa.launchpad.net/xubuntu-dev/xfce-4.10/ubuntu $version main" >> /etc/apt/sources.list
	fi

	apt-get update 2>&1 | tee -a /root/post.log

	apt-get -fy upgrade 2>&1 | tee -a /root/post.log
	apt-get -fy dist-upgrade 2>&1 | tee -a /root/post.log
	
	### réglage utilisateur
	echo "réglage utilisateur" >> /root/post.log
	usermod -a -G fuse ubuntu 2>&1 | tee -a /root/post.log
	usermod -G ubuntu,adm,audio,avahi,avahi-autoipd,backup,bin,bluetooth,cdrom,colord,crontab,daemon,dialout,dip,disk,fax,floppy,fuse,games,gnats,irc,kmem,libuuid,lightdm,list,lp,lpadmin,mail,man,messagebus,mlocate,netdev,news,operator,plugdev,proxy,pulse,pulse-access,sambashare,saned,sasl,scanner,shadow,src,ssh,ssl-cert,staff,sudo,sys,syslog,tape,tty,video,voice,kdm ubuntu 2>&1 | tee -a /root/post.log

	###copie du home
	cd /home/ubuntu
	if [ $graphique = "xubuntu" ]
	then
		echo "mise en place home" >> /root/post.log
		wget 192.168.2.1/home_xubuntu.tar.gz 2>&1 | tee -a /root/post.log
		unp home_xubuntu.tar.gz 2>&1 | tee -a /root/post.log
		chown -R ubuntu:ubuntu /home/ubuntu 2>&1 | tee -a /root/post.log
		rm home_xubuntu.tar.gz 2>&1 | tee -a /root/post.log
	fi
	if [ ! -d /home/ubuntu/.mozilla ]
	then
		echo "mise en place mozilla" >> /root/post.log
		wget 192.168.2.1/mozilla.tar.gz 2>&1 | tee -a /root/post.log
		unp mozilla.tar.gz 2>&1 | tee -a /root/post.log
		chown -R ubuntu:ubuntu /home/ubuntu 2>&1 | tee -a /root/post.log
		rm mozilla.tar.gz 2>&1 | tee -a /root/post.log
	fi
	touch /root/post_exec 2>&1 | tee -a /root/post.log
	rm /etc/nologin 2>&1 | tee -a /root/post.log
	reboot 2>&1 | tee -a /root/post.log
fi
exit 0
