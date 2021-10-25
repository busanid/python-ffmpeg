#/bin/bash
name=`openssl rand -hex 10`
directory=/data/streaming/
streaming=/data/streaming/*.mp4
rtmp=rtmp://157.245.197.168/live/$name
inotifywait -e close_write "$directory" |
while read -r filename eventlist eventfile
  do
  #ffmpeg -re -i "$streami/$eventfile" -acodec libmp3lame -ar 44100 -b:a 128k -pix_fmt yuv420p -profile:v baseline -s 426x240 -bufsize 6000k -vb 400k -maxrate 1500k -deinterlace -vcodec libx264 -preset veryfast -g 30 -r 30 -f flv -flvflags no_duration_filesize $name
  ffmpeg -re -stream_loop -1 -i "$streaming/$eventfile" -c copy -f flv $rtmp
done
