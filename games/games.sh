#!/bin/sh
runsteamscript() {
    steamcmd +login "$USERNAME" "$PASSWORD" +runscript "$1"
}

runsteamscript "$PWD"/install-games.steamcmd
APPSDIR=~/.steam/steam/steamapps/common
GAMESDIR=~/games/
DOOMSDAY=$GAMESDIR/Doomsday

mkdir -p $GAMESDIR/{Doomsday,Hexen\ 2,Quake,Quake\ 2,Quake\ 3}

# TODO lowercase
cp -r $APPSDIR/DOOM\ 3\ BFG\ Edition/base/wads/*.WAD $DOOMSDAY/
cp -r $APPSDIR/Heretic\ Shadow\ of\ the\ Serpent\ Riders/base/*.WAD $DOOMSDAY/
cp -r $APPSDIR/Hexen/base/*.WAD $DOOMSDAY/
cp -r $APPSDIR/Hexen\ Deathkings\ of\ the\ Dark\ Citadel/base/*.WAD $DOOMSDAY/

cp -r $APPSDIR/Hexen\ 2/data1/* $GAMESDIR/Hexen\ 2/

cp -r $APPSDIR/Quake/{Id1,hipnotic,rogue} $GAMESDIR/Quake/
# TODO soundtrack

cp -r $APPSDIR/Quake\ 2/{baseq2,ctf,xatrix,rogue} $GAMESDIR/Quake\ 2/
cp -r $APPSDIR/Quake\ 3\ Arena/{baseq3,missionpack} $GAMESDIR/Quake\ 3/

# Cleanup
runsteamscript +login "$USERNAME" "$PASSWORD" +runscript "$PWD"/uninstall-games.steamcmd
