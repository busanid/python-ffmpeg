#/bin/bash
name=`openssl rand -hex 10`
directory=/data/streaming
streaming=/data/streaming/streaming.txt
rtmp=rtmp://157.245.197.168/live
#eventfile=*.mp4
if [ ! -f "$streaming" ]; then
	touch "$streaming"
fi

while file=$(inotifywait -r -e modify --format "%w%f" $directory) read -r eventfile; 
do
     EXT=${file##*.}
     if [ $EXT = "mp4" ]
then
     nohup ffmpeg -re -stream_loop -1 -i "$directory/$eventfile" -c copy -f flv $rtmp/$eventfile > ffmpeg_$eventfile.log 2>&1;
     echo "$rtmp/$eventfile" >> streaming.txt;
     fi
done

