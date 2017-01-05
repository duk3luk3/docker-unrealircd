#!/bin/bash
source /home/unreal/config
## Install UnrealIRCD
wget https://www.unrealircd.org/unrealircd4/unrealircd-4.0.1.tar.gz
tar -zxvf unrealircd-$UNREAL_VERSION.tar.gz
cd unrealircd-$UNREAL_VERSION
./Config
make
make install
cp /home/unreal/unreal.conf /home/unreal/unrealircd/unrealircd.conf
echo $MOTD > ircd.motd
echo $RULES > ircd.rules
