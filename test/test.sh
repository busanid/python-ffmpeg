#!/bin/sh

MONITORDIR="/data/streaming/test"
inotifywait -m -r -e create --format '%w%f' "${MONITORDIR}" | while read NEWFILE
do
        echo "This is the body " | echo "File ${NEWFILE} has been created" >> test.txt
done
