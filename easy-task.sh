REM=$(( $1 % 2 ))
if [ "$REM" -eq 0 ]; then
	echo "input can't be even"
	exit 1
fi
CHAR_VARYING_FLAG=0
REM2=$(( ($1 - 1)%4 ))
if [ "$REM2" -eq 0 ]; then
	CHAR_VARYING_FLAG=1
fi
REVERSE_FLAG=0
REVERSE_NUM=$(( ($1+1)/2 ))
IN_SPACE=""
OUT_SPACE=""
OUT_SPACE_COUNT=$(( ($1 - 1)/2 ))
IN_SPACE_COUNT=0
for (( num=1; num <= $1; num++ ))
do
	#create the space
	for (( i=1; i <= $IN_SPACE_COUNT; i++ ))
	do
		IN_SPACE=$IN_SPACE" "
	done
	for (( j=1; j <= $OUT_SPACE_COUNT; j++ ))
	do
		OUT_SPACE=$OUT_SPACE" "
	done
	#put the 'x' or 'o' character
	if [ "$num" -eq 1 -o "$num" -eq "$1" ]; then
		OUT_SPACE=$OUT_SPACE"x"
	elif [ "$num" -eq "$REVERSE_NUM" ]; then
		OUT_SPACE=$OUT_SPACE"x"
		IN_SPACE=$IN_SPACE"x"
	elif [ "$CHAR_VARYING_FLAG" -eq 0 -o $(( $num % 2 )) -eq 0 ]; then
		OUT_SPACE=$OUT_SPACE"o"
		IN_SPACE=$IN_SPACE"o"
	elif [ $(( $num % 2 )) -eq 1 ]; then
		OUT_SPACE=$OUT_SPACE"x"
		IN_SPACE=$IN_SPACE"x"
	fi
	#print out the diamond part
	echo "$OUT_SPACE$IN_SPACE"
	OUT_SPACE=""
	IN_SPACE=""
	if [ "$num" -eq "$REVERSE_NUM" ]; then
		REVERSE_FLAG=1
	fi
	if [ "$REVERSE_FLAG" -eq 1 ]; then
		OUT_SPACE_COUNT=$(( $OUT_SPACE_COUNT + 1 ))
		if [ "$IN_SPACE_COUNT" -eq 0 ]; then
			IN_SPACE_COUNT=$(( $IN_SPACE_COUNT - 1 ))
		else
			IN_SPACE_COUNT=$(( $IN_SPACE_COUNT - 2 ))
		fi
	else
		OUT_SPACE_COUNT=$(( $OUT_SPACE_COUNT - 1 ))
		if [ "$IN_SPACE_COUNT" -eq 0 ]; then
			IN_SPACE_COUNT=$(( $IN_SPACE_COUNT + 1 ))
		else
			IN_SPACE_COUNT=$(( $IN_SPACE_COUNT + 2 ))
		fi
	fi

done
