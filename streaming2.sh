for i in /data/streaming/*.mp4;
  do name=`echo "$i" | cut -d'.' -f1`
  echo "$name"
  ffmpeg -re -i beruang_bernard.mp4 -acodec libmp3lame -ar 44100 -b:a 128k -pix_fmt yuv420p -profile:v baseline -s 426x240 -bufsize 6000k -vb 400k -maxrate 1500k -deinterlace -vcodec libx264 -preset veryfast -g 30 -r 30 -f flv -flvflags no_duration_filesize rtmp://157.245.197.168/live/${name}
