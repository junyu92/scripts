#!/bin/bash

usage() { echo "Usage: $0 [-d <dictionary>] [-t <new_name>]" 1>&2; exit 1; }

while getopts ":d:t:" o; do
    case "${o}" in
        d)
            DIC_POSITION=${OPTARG}
            ;;
        t)
            TARGET_NAME=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${DIC_POSITION}" ] || [ -z "${TARGET_NAME}" ]; then
    usage
fi

count=1
find ${DIC_POSITION} -type f | grep -v 'DS_Store$' | while read LINE; do
	file=$LINE
	ext=${file##*.}
	src="${file}"
	tar="$(dirname "${file}")/${TARGET_NAME}_$count.$ext"
	mv "$src" "$tar"
	let "count++";
done
