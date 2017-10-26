#!/bin/bash

singlyric1() {
	while read lyric; do
		SIGN=$(echo "$lyric" | grep -o '[1-2]\$')
		if [ "$SIGN" == "1$" ]; then
			echo "$lyric" | sed -e 's/[1-2]\$//g'
			tail -n +2 lyrics-tmp.txt > lyrics-tmp && mv lyrics-tmp lyrics-tmp.txt
		elif [ "$SIGN" == "" ]; then
			tail -n +2 lyrics-tmp.txt > lyrics-tmp && mv lyrics-tmp lyrics-tmp.txt
		else
			kill -USR2 $SING2PID
			break
		fi
		sleep 1
	done < lyrics-tmp.txt
	TMPCONTENT=$(cat lyrics-tmp.txt)
	if [ -z "$TMPCONTENT" ]; then
		rm lyrics-tmp.txt
		kill -SIGKILL $SING2PID
		exit 1
	fi
}

SING2PID=""
trap "singlyric1" USR1

while [ -z "$SING2PID" ]; do
	sleep 1
	SING2PID=`ps -e | grep singer2.sh | awk '{print $1}'`
done

#Create temporary file for lyric
cat lyrics.txt > lyrics-tmp.txt
singlyric1

while [ 1 -gt 0 ]; do
	sleep 1
	echo "..."
done

