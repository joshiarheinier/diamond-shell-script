#!/bin/bash

singlyric2() {
	while read lyric; do
                SIGN=$(echo "$lyric" | grep -o '[1-2]\$')
                if [ "$SIGN" == "2$" ]; then
                        echo "$lyric" | sed -e 's/[1-2]\$//g'
                        tail -n +2 lyrics-tmp.txt > lyrics-tmp && mv lyrics-tmp lyrics-tmp.txt
                else
                        kill -USR1 $SING1PID
                        break
                fi
		sleep 1
        done < lyrics-tmp.txt
	TMPCONTENT=$(cat lyrics-tmp.txt)
        if [ -z "$TMPCONTENT" ]; then
                rm lyrics-tmp.txt
		kill -SIGKILL $SING1PID
		exit 1
        fi
}

SING1PID=""
trap "singlyric2" USR2

while [ -z "$SING1PID" ]; do
	sleep 1
	SING1PID=`ps -e | grep singer1.sh | awk '{print $1}'`
done

while [ 1 -gt 0 ]; do
	sleep 1
	echo "..."
done
