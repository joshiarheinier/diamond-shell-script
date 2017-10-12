#!/bin/bash

printmenuline() {
	LINE=""
	for ((i=0; i<$1; i++)); do
		LINE="$LINE$2"
	done
	echo "$LINE"
}

printline() {
	echo "----------------------------------------------"
}

continueprompt() {
	printf "Press [Enter] key to continue..."
	read enter
}

mainmenu() {
	printmenuline 19 "="
	echo "     Main Menu"
	printmenuline 19 "="
	echo "1. Operating System info"
	echo "2. Hardware List"
	echo "3. Free and Used Memory"
	echo "4. Hardware Detail"
	echo "5. exit"
}

ossysteminfo(){
	USER=`uname`
	OS=`uname -sr`
	UPTIME=`uptime | sed -e "s/[^up]*up\ //g" -e "s/\ user.*//g"`
	IP=`netstat -n | grep ESTABLISHED | awk '{print $4}'`
	HOSTNAME=`hostname`
	printline
	echo "     System Status"
	printline
	echo "Username : $USER"
	echo "OS : $OS"
	echo "Uptime : $UPTIME"
	echo "IP : $IP"
	echo "Hostname : $HOSTNAME"
}

hardwarelist() {
	M=`uname -m`
	printline
	echo "     Hardware List"
	printline
	echo "Machine Hardware : $M"
	lshw -short 2> /dev/null
}

memorydetail() {
	printline
	echo "     MEMORY"
	printline
	printmenuline 16 "*"
	echo "     Memory"
	printmenuline 16 "*"
	free -m | grep Mem | awk '{print "Size : "$2" MB";print "Free "$4" MB"}'
	printmenuline 27 "*"
	echo "     Memory Statistics"
	printmenuline 27 "*"
	vmstat
	printmenuline 35 "*"
	echo "     Top 10 cpu eating process"
	printmenuline 35 "*"
	ps aux --sort=-pcpu | head -n 11 | sed -e "s/\ [^\ COMMAND]*$//g"
}

hardwaredetailmenu() {
	printmenuline 25 "="
	echo "     Hardware Detail"
	printmenuline 25 "="
	echo "1. CPU"
	echo "2. Block Devices"
	echo "3. Back"
}

cpudetail() {
	cat /proc/cpuinfo | grep -e "\(model\ name\|cache\ size\|MHz\)" | sed -e "s/model\ name[^\:]*\:/a/g" -e "s/cpu\ MHz[^\:]*\:/b/g" -e "s/cache\ size[^\:]*\:/c/g" | sort -u | sed -e "s/a\ /Model\ Name\ \:\ /g" -e "s/b\ /Frequency\ \:\ /g" -e "s/c\ /Cache\ \:\ /g"
}

blockdevdetail() {
	lsblk
}

while [ 1 -gt 0 ]; do
	mainmenu
	printf "Choose 1-5 : "
	read choice
	case "$choice" in
		1) ossysteminfo
		   continueprompt
		;;
		2) hardwarelist
		   continueprompt
		;;
		3) memorydetail
		   continueprompt
		;;
		4) while [ 1 -gt 0 ]; do
			hardwaredetailmenu
			printf "Choose 1-3 : "
			read dchoice
			case "$dchoice" in
				1) cpudetail
				   continueprompt
				;;
				2) blockdevdetail
				   continueprompt
				;;
				3) break
				;;
				*) echo "Invalid Input!" >&2
				;;
			esac
		   done
		;;
		5) echo "Bye Bye...."
		   break
		;;
		*) echo "Invalid Input!" >&2
	esac
done
