#/bin/bash
name=`openssl rand -hex 10`
directory=/data/streaming
streaming=/data/streaming/streaming.txt
rtmp=rtmp://157.245.197.168/live/$name

if [ ! -f "$streaming" ]; then
	touch "$streaming"
fi

inotifywait -e close_write "$directory" |
while read -r filename eventlist eventfile
  do
  nohup ffmpeg -re -stream_loop -1 -i "$directory/$eventfile" -c copy -f flv $rtmp > ffmpeg1.log 2>&1
  echo $rtmp >> streaming.txt
done &

inotifywait -e close_write "$directory" |
	while read -r filename eventlist eventfile
	do
	nohup ffmpeg -re -stream_loop -1 -i "$directory/$eventfile" -c copy -f flv $rtmp > ffmpeg2.log 2>&1
	echo $rtmp >> streaming.txt
done &

wait
