echo "Initial directory = $PWD"

recursive_traverse() {
	while [ "$1" ]; do
		if [ -d "$1" ]; then
			echo "$1"
			recursive_traverse "$1"/*
		fi
		shift
	done
}

recursive_traverse ./* | sed -e "s/[^/]*\//| /g" -e "s/| \([^|]\)/+---\1/"
