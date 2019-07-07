#!/usr/bin/env bash

#
# tami - tam shell init script file
# handy bash/shell init scripts for quick reference
#
# cat<<'EOF' - use single quote to avoid variable substitution
# cat<<-     - to ignore leading tabs
#

HLINE="-----------------------------------------------------------------------"

PS1="\[\e[1;32m\]\u\[\e[m\]@\[\e[1;31m\]\h\[\e[m\]:\[\e[1;33m\]\w\[\e[m\]:\[\e[1;36m\](exit=$?)\[\e[m\]\n\[\e[2;32m\]$\[\e[m\] "


function javae() {
	host=$1
	if [ -z $host ]; then
		cat ~/Library/Application\ Support/Oracle/Java/Deployment/security/exception.sites
		return
	fi
	grep $host ~/Library/Application\ Support/Oracle/Java/Deployment/security/exception.sites
	if [ $? -ne 0 ]; then
		echo $host >> ~/Library/Application\ Support/Oracle/Java/Deployment/security/exception.sites
	fi
}

function h_tami() {
	cat<<-EOF
		TAMI functions

		1. javae [host]

		${HLINE}
		#MAC# javae - add java security exception to access applet web application
		${HLINE}
		type javae
		Ex:
		javae host <- to add a host
		javae      <- to list
	EOF
}
function h_dtrace() {
	cat<<-EOF
		dtrace -F -n 'pid6120:a.out::entry/tid == 6978/{}'
		dtrace -Z -F -n 'fbt::port_show*:entry/execname == "nvOSd"/{}'
		dtrace -F -n 'pid6120:a.out:nvOS_count_command:entry/tid == 6978/{ustack();}'

		dtrace -n 'syscall:::entry {@[probefunc]=count();}'
		dtrace -n 'syscall::ioctl:entry {@[execname]=count();}'
		dtrace -n 'syscall::ioctl:entry /execname =="nvOSd"/ {@[ustack()]=count();}'
		/opt/DTT/Bin/iotop
		/opt/DTT/Bin/iosnoop -Deg
	EOF
}


alias hgc="hg clone ssh://pnsrc@pn/nvOS"
alias hgd="hg clone ssh://pnsrc@pn/design_docs"
alias hgr="hg qrefresh"
alias hgq="hg qseries -v"
alias hgo="hg out -vp"
alias hgi="hg qimport -P"

function h_hg() {
	cat<<-EOF
		alias hgc="hg clone ssh://pnsrc@pn/nvOS"
		alias hgd="hg clone ssh://pnsrc@pn/design_docs"
		alias hgr="hg qrefresh"
		alias hgq="hg qseries -v"
		alias hgo="hg out -vp"
		alias hgi="hg qimport -P"
	EOF
}

function h_tcpdump() {
	cat<<-EOF
		https://danielmiessler.com/study/tcpdump/

		tcpdump -i eth0
		tcpdump -ttttnnvvS
		tcpdump host 1.2.3.4
		tcpdump -nnvXSs 0 -c1 icmp
		tcpdump src 2.3.4.5
		tcpdump dst 3.4.5.6
		tcpdump net 1.2.3.0/24
		tcpdump port 3389
		tcpdump src port 1025
		tcpdump icmp
		tcpdump ip6
		tcpdump portrange 21-23
		tcpdump less 32
		tcpdump greater 64
		tcpdump <= 128

		tcpdump port 80 -w capture_file
		tcpdump -r capture_file

		tcpdump -nnvvS src 10.5.2.3 and dst port 3389
		tcpdump -nvX src net 192.168.0.0/16 and dst net 10.0.0.0/8 or 172.16.0.0/16
		tcpdump dst 192.168.0.2 and src net and not icmp
		tcpdump -vv src mars and not dst port 22
		tcpdump 'src 10.0.2.4 and (dst port 3389 or 22)'

		tcpdump 'tcp[tcpflags] == tcp-syn'
		tcpdump 'ip[8] < 10' :- PACKETS WITH A TTL LESS THAN 10
	EOF
}
function h_gdb(){
	cat<<-EOF
		set pagination off
		set print pretty on
		set print thread-events off | How can I disable new thread/thread exited messages in gdb?

		make aware static function
		${HLINE}
		+CFLAGS         += -fno-inline-small-functions <- make aware static function

		Print/Run something when break point is hit
		${HLINE}
		break foo if x>0
		commands
		silent
		printf "x is %d\n",x
		cont
		end

		Save and load break points
		${HLINE}
		save breakpoints /tmp/bp.txt
		source /tmp/bp.txt
	EOF
}

function h_proc() {
	cat<<-EOF
		ps
		top
		htop
	EOF
}

function h_cpu() {
	cat<<-EOF
		htop
		cat /proc/cpuinfo
		lscpu
	EOF
}

function h_memory() {
	cat<<-EOF
		free -h
		cat /proc/meminfo
	EOF
}

function h_disk() {
	cat<<-EOF
		df -h
		parted -l
		lsblk
		cat /etc/fstab
		lshw -c storage
		lshw -c volume

		btrfs
		-------
		btrfs fi <- Enter
		btrfs fi show
		btrfs filesystem usage /
	EOF
}

function h_hw() {
	cat<<EOF
lshw -h
	lshw -businfo
	lshw -xml | grep class | awk -F"class=" '{print $2}' | awk '{print $1}' | sort | uniq
		"bridge"
		"bus"
		"communication"
		"disk"
		"display"
		"input"
		"memory"
		"network"
		"processor"
		"storage"
		"system"
		"volume"
	lshw -c memory

dmidecode -t < Enter
	bios
	system
	baseboard
	chassis
	processor
	memory
	cache
	connector
	slot

apt-get update; apt-get install hwloc
lstopo
lstopo --output-format txt
EOF
}

function h_dpkg() {
	cat<<-EOF
		dpkg -l
	EOF
}

function h_ssh() {
	cat<<-EOF
		ssh-add -k
		ssh-add -L
	EOF
}

# EOL
