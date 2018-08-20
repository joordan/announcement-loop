#!/bin/bash
FILES="/home/pi/DTCAnnouncements/mp3/*"
short=5
long=38
end=420
pause=$short
count=1
files=`ls -l mp3 | wc -l`
echo last startup on `date` >> /home/pi/DTCAnnouncements/log.txt

while true; do
        for f in $FILES; do

                        time=`date +%H%M`

                        if [ "$time" -gt 1700 ]; then
                                echo last termination on `date` > /home/pi/DTCAnnouncements/log.txt
                                exit
                        else

                                omxplayer $f
                                count=$((count+1))
                                if [ $count -eq $files ]; then
                                        sleep 60
                                        omxplayer /home/pi/jinglev2.wav
                                        count=1
                                        sleep $end
                                        pause=$long
                                fi
                                sleep $pause
                                if [ $pause -eq $short ]; then
                                        pause=$long
                                else
                                        pause=$short
                                fi
                        fi
        done
done
