#!/bin/bash

#setup some defaults
RATE=20
BITRATE=3500
WIDTH=1920
HEIGHT=1080
RUNLEN=0
#since it's so painful
# we default timestamps to off
TIMESTAMP=0
RENAME=0

MENCODER=`which mencoder`

usage() {
cat << EOF
usage: $0 options

OPTIONS:
   -r      Rate in frames per second (${RATE})
   -w      Width (${WIDTH})
   -i      Height (${HEIGHT})
   -b      Bitrate of Video (${BITRATE})
   -l      # of seconds to encode (default = all)
   -t	   Add timestamp (need 2x disk space)
   -o      rename files based on timestamp in exif
   -v      Verbose
EOF
}


while getopts “r:w:h:b:l:to” OPTION
do
     case $OPTION in
         r)
             RATE=$OPTARG
             ;;
         w)
             WIDTH=$OPTARG
             ;;
         h)
             HEIGHT=$OPTARG
             ;;
         b)
             BITRATE=$OPTARG
             ;;
         l)
		     echo "SETTING RUNLEN TO ${OPTARG}"
             RUNLEN=$OPTARG
             ;;
		 t)
		 	 TIMESTAMP=1
			 ;;
		 o)
		 	 RENAME=1
			 ;;
         ?)
             usage
             exit
             ;;
     esac
done

usage

echo ""

NUM_FILES=`ls -1|wc -l`
TIME_PER_FRAME=`echo "scale=3; 1000/${RATE}" | bc`
MOVIE_LENGTH=`echo "scale=2; ${NUM_FILES}/${RATE}" |bc`

#lets see if they want to rename based on exif timestamp
if [ $RENAME -eq 1 ]
then
  /home/waboring/bin/imgtsrename.sh
fi


# this is painful
# couldn't find a way to do this on the fly
# using some mencoder hooks. all attempts failed.
if [ $TIMESTAMP -eq 1 ]
then 
   echo "Creating new images with timestamp"
   CURNUM=1
   SKIPPED=0

   #timestamp images directory
   tsdir="ts"

   if [ ! -d $tsdir ] 
     then 
       mkdir ${tsdir}
   fi

   echo "Processing (n of total):(skipped) <FILE>"
   for file in *.JPG ; do
	tmpname="${tsdir}/${file}"
	if [ ! -e $tmpname ]
	  then
	  echo -ne "Processing (${CURNUM} of ${NUM_FILES}):(${SKIPPED}) ${file}"\\r
        convert "$file" -quality 90 \
          -font /gentoo/usr/share/fonts/corefonts/arial.ttf \
          -pointsize 40 -gravity southeast \
	      -fill black -strokewidth 4 -annotate 0 %[exif:DateTimeOriginal] \
	      -fill white -strokewidth 1 -annotate 0 %[exif:DateTimeOriginal] \
	      ${tmpname}
	  else 
	   SKIPPED=$((SKIPPED + 1))
     fi
     CURNUM=$((CURNUM + 1))
   done

   echo ""
   echo "Complete"
   ls -1 ${tsdir}/*>files.txt
else 
  ls -1 *.jpg>files.txt
fi




RUNLENOPT=""
if [ $RUNLEN -ne 0 ]
then
  RUNLENOPT=" -endpos $RUNLEN"
  FILENAME="timelapse_${WIDTH}x${HEIGHT}_${RATE}fps_${RUNLEN}s.avi"
else 
  FILENAME="timelapse_${WIDTH}x${HEIGHT}_${RATE}fps.avi"
fi

echo "Creating ${FILENAME} from $NUM_FILES images. Movie Length = ${MOVIE_LENGTH}s"
echo "Time per image = ${TIME_PER_FRAME}ms"

#CMD="/usr/bin/mencoder -nosound -ovc lavc -lavcopts vcodec=mpeg4:vbitrate=${BITRATE}:threads=2 \
#-vf scale=${WIDTH}:${HEIGHT} -o ${FILENAME} -mf type=jpeg:fps=$RATE $RUNLENOPT mf://@files.txt"

#this works on the PS3
#CMD="nice -n 11 ${MENCODER} -nosound -ovc xvid -xvidencopts bitrate=${BITRATE}:chroma_opt:vhq=4:bvhq=1:quant_type=mpeg \
#-vf pp=de,scale=${WIDTH}:${HEIGHT} -o ${FILENAME} -mf type=jpeg:fps=${RATE} ${RUNLENOPT} mf://@files.txt"

#VCODEC_OPTS="vcodec=mpeg4:mbd=2:trell:v4mv:last_pred=3:predia=2:dia=2:vmax_b_frames=2:vb_strategy=1:precmp=2:cmp=2:subcmp=2:preme=2 -o mpv_flags=+cbp_rd+mv0,quantizer_noise_shaping=2"
VCODEC_OPTS="vcodec=mpeg2video:vrc_buf_size=1835:vrc_maxrate=9800:vbitrate=5000:keyint=15:vstrict=0"
#VCODEC_OPTS="vcodec=mpeg4:mbd=2:trell:v4mv:last_pred=2:dia=-1:vmax_b_frames=2:vb_strategy=1:cmp=3:subcmp=3:precmp=0:vqcomp=0.6:turbo"

CMD="nice -n 11 ${MENCODER} -nosound -ovc lavc -lavcopts ${VCODEC_OPTS} -vf scale=${WIDTH}:${HEIGHT} \
-o ${FILENAME} -mf type=jpeg:fps=${RATE} ${RUNLENOPT} mf://@files.txt"


echo $CMD
sleep 2;

exec ${CMD}
