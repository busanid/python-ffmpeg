#/bin/bash
directory=/data/streaming
streaming=/data/streaming/streaming.txt
rtmp=rtmp://157.245.197.168/live

if [ ! -f "$streaming" ]; then
	touch "$streaming"
fi

inotifywait -m -e modify "$directory" |
while read -r eventlist action eventfile; do
  if [[ $eventfile =~ .*mp4 ]]; then
  nohup ffmpeg -re -stream_loop -1 -i "$directory/$eventfile" -c copy -f flv $rtmp/$eventfile > ffmpeg_$eventfile.log 2>&1;
  echo "$rtmp/$eventfile" >> streaming.txt;
  fi
done

