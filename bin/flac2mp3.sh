#!/bin/bash

# flac2mp3 (by Krzysztof Czajkowski - http://czajkowski.edu.pl)
# Version: 1.2 (08 Jul 2010) 
# Licence: public domain
# Small tool to convert your loved FLAC files to mp3
# Requires (in gentoo): media-libs/flac
#		        media-sound/id3
#		        media-sound/lame

one=$@

if [[ $one == "--all" || $one == "all" ]]; then
 for a in *.flac 
  do
  
  OUTF=`echo "$a" | sed s/\.flac$/.mp3/g`

  ARTIST=`metaflac "$a" --show-tag=ARTIST | sed s/.*=//g`
  TITLE=`metaflac "$a" --show-tag=TITLE | sed s/.*=//g`
  ALBUM=`metaflac "$a" --show-tag=ALBUM | sed s/.*=//g`
  TRACKNUMBER=`metaflac "$a" --show-tag=TRACKNUMBER | sed s/.*=//g`
  DATE=`metaflac "$a" --show-tag=DATE | sed s/.*=//g`

  flac -c -d "$a" | lame -m j -q 0 --vbr-new -V 0 -s 44.1 --preset standard - "$OUTF"
  id3 -t "$TITLE" -T "${TRACKNUMBER:-0}" -a "$ARTIST" -A "$ALBUM" -y "$DATE" "$OUTF"
  
  done
  
  mkdir "$ARTIST - $ALBUM (lossy)"
  mv *.mp3 "$ARTIST - $ALBUM (lossy)"
  #mkdir converted
  #mv *.mp3 converted

else
 
 if [[ $one == "--help" || $one == "-h" || $one == "" ]]; then
  echo -e "Usage: \n 
  To convert all files in directory use: flac2mp3 --all, 
  to convert only one file use: flac2mp3 file.flac."
 
 else

  OUTF=`echo "$one" | sed s/\.flac$/.mp3/g`
  
  ARTIST=`metaflac "$one" --show-tag=ARTIST | sed s/.*=//g`
  TITLE=`metaflac "$one" --show-tag=TITLE | sed s/.*=//g`
  ALBUM=`metaflac "$one" --show-tag=ALBUM | sed s/.*=//g`
  TRACKNUMBER=`metaflac "$one" --show-tag=TRACKNUMBER | sed s/.*=//g`
  DATE=`metaflac "$one" --show-tag=DATE | sed s/.*=//g`

  flac -c -d "$one" | lame -m j -q 0 --vbr-new -V 0 -s 44.1 --preset standard - "$OUTF"
  id3 -t "$TITLE" -T "${TRACKNUMBER:-0}" -a "$ARTIST" -A "$ALBUM" -y "$DATE" "$OUTF"
  
  [ -e "$ARTIST - $ALBUM (lossy)" ] || mkdir "$ARTIST - $ALBUM (lossy)"
  mv *.mp3 "$ARTIST - $ALBUM (lossy)"
  #mkdir converted
  #mv *.mp3 converted

 fi
fi

