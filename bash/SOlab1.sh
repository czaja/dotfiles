#!/bin/bash
zrodlo=$1
cel=$2

if [ -d $cel ]; then
   echo "Katalog zrodlowy istnieje"
else
   echo "Nie ma katalogu zrodlowego... Tworze..."
   mkdir -p $cel
fi

function searchanddestroy
{
   zrodlos=$1
   cels=$2
   for i in $zrodlos/*; do
      if [ -d $i ] || [ -L $i ]; then
         searchanddestroy $i $cels
      elif [ -f $i ] || [ -L $i ]; then
         cp $i $cel
      fi
   done
}

searchanddestroy $zrodlo $cel
