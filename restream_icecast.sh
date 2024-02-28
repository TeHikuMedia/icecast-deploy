


STATIONS=(
    "Kahungunu" 
    "KiaOra" 
    "MFM" 
    # "NgatiHine" 
    "Raukawa" 
    "Atiawa" 
    "TeUpoko" 
    "Tumeke" 
    "Tuwharetoa" 
    "Waatea"
    "NgatiPorou"
    )

    #http://apple.irirangi.net:8000/D_Nga_Iwi.aac

for STATION_NAME in ${STATIONS[@]}; do
  
    # ffmpeg \
    #     -re \
    #     -i http://icast1.streamcom.net/$STATION_NAME \
    #     -nostdin -loglevel panic \
    #     -c:a libfdk_aac -profile:a aac_he -b:a 64k \
    #     -content_type 'audio/aac' -vn -f adts \
    #     icecast://source:Wh4k4ruruh4u!1991@icecast.iwi.radio:8000/$STATION_NAME 2> /dev/null &

    echo "[program:$STATION_NAME]"
    echo "autorestart=true"
    echo "autostart=true"
    echo "startretries=99999"
#     echo "command=/bin/ffmpeg \
# -re \
# -i http://icast1.streamcom.net/$STATION_NAME \
# -c:a libfdk_aac -profile:a aac_he -b:a 64k \
# -content_type 'audio/aac' -vn -f adts \
# 'icecast://source:Wh4k4ruruh4u!1991@icecast.iwi.radio:8000/$STATION_NAME'"
        
    echo "command=/bin/ffmpeg \
-re \
-i http://icast1.streamcom.net/$STATION_NAME \
-c:a aac -b:a 64k \
-nostdin -loglevel warning \
-content_type 'audio/aac' -vn -f adts \
'icecast://source:Wh4k4ruruh4u!1991@icecast.iwi.radio:8000/$STATION_NAME'"
        
        echo "# http://icecast.iwi.radio:8000/$STATION_NAME"

        echo "\n"
    done;



for STATION_NAME in ${STATIONS[@]}; do
    echo $STATION_NAME
    ffprobe -loglevel warning -i http://icecast.iwi.radio:8000/$STATION_NAME
done;

STATIONS=(
    "Kahungunu" 
    "KiaOraFM" 
    "ManiapotoFM" 
    # "NgatiHineFM" 
    "RaukawaFM" 
    "TeAtiawatoa" 
    "TeUpokoFM" 
    "TumekeFM" 
    "TuwharetoaFM" 
    "Waatea"
    "NgatiPorou"
    )

for STATION_NAME in ${STATIONS[@]}; do
    echo $STATION_NAME
    ffprobe -loglevel warning -i https://wowza.iwi.radio/icecast-to-hls/ngrp:$STATION_NAME.stream/playlist.m3u8
    echo https://wowza.iwi.radio/icecast-to-hls/ngrp:$STATION_NAME.stream/playlist.m3u8
done;