#!/bin/sh

mkdir -p ~/Emulation/{PS1,NES,SNES}

#ia download ...
PSXGAMES=hoffbmx

wget -O $PSXGAMES.chd https://cors.archive.org/cors/psx_$PSXGAMES/playstationdisc.chd

# MAME arcade only: wget https://cors.archive.org/cors/arcade_sf2hf/sf2hf.zip