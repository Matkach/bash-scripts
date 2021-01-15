#!/bin/bash

ans="$(ps -A|grep \ lightdm$)"
res=$?
if [ "$res" == "0" ]
then
 echo "x (lightdm) is already running"
else
 echo "x will be started:"
 echo "sudo service lightdm start"
 sudo service lightdm start
fi
