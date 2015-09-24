#!/bin/bash
source /config

wget http://www.unrealircd.com/downloads/Unreal$VERSION.tar.gz
tar -zxvf Unreal$VERSION.tar.gz
cd Unreal$VERSION
./Config
make
cp /unreal.conf ./unrealircd.conf
echo $MOTD > ircd.motd
echo $RULES > ircd.rules
./unreal start
wget http://sourceforge.net/projects/anope/files/anope-stable/Anope%20$ANOPE_VERSION/anope-$ANOPE_VERSION-source.tar.gz/download
# wget http://sourceforge.net/projects/anope/files/anope-stable/Anope%201.8.8/anope-1.8.8.tar.gz/download
tar -zxvf anope-$ANOPE_VERSION.tar.gz
cd anope-$ANOPE_VERSION
./Config
make
make install
cp example.conf services.conf
#Make a edit for unrealircd linking
#Run Anope:
#./services
