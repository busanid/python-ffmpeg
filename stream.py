import inotify.adapters
import os
import subprocess
import sys

notifier = inotify.adapters.Inotify()
notifier.add_watch('/data/streaming')

for event in notifier.event_gen():
    if event is not None:
        # Print event # Uncomment to see all events generated
        if 'IN_CREATE' in event[1]:
            INPUT_FILE_NAME = event[3]
            STREAM_NAME = event[3]
            #print("file '{0}' created in '{1}'".format(event[3], event[2])

            stream_url = f"rtmp://157.245.197.168/live/{STREAM_NAME}"

            with open ("url.txt", "a") as f:
                f.write(f"{stream_url}\n")

            try:
                # p = subprocess.Popen(f"ffmpeg -re -i {INPUT_FILE_NAME} -c copy -f flv rtmp://157.245.197.168/live/{STREAM_NAME}")
                p = subprocess.Popen(["ffmpeg -re -i {INPUT_FILE_NAME} -c copy -f flv {stream_url}"],
                                        shell=True,
                                        stdout=subprocess.PIPE,
                                        stderr=subprocess.STDOUT
                                        )
                
                while p.poll() is None:
                    while True:
                        output = p.stdout.readline().decode()
                        if output:
                            with open("ffmpeg.log", "a") as f:
                                f.write(f"{output}\n")                           
                        else:
                            break

            except Exception as e:
                print(e)
