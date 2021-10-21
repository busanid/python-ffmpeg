import inotify.adapters
import os

notifier = inotify.adapters.Inotify()
notifier.add_watch('/data/streaming')

for event in notifier.event_gen():
    if event is not None:
        # Print event # Uncomment to see all events generated
        if 'IN_CREATE' in event[1]:
            INPUT_FILE_NAME = event[3]
            STREAM_NAME = event[3]
            #print("file '{0}' created in '{1}'".format(event[3], event[2])
            os.system(f"ffmpeg -re -i {INPUT_FILE_NAME} -c copy -f flv rtmp://157.245.197.168/live/{STREAM_NAME}")
