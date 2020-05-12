#!/bin/bash

mkdir /var/run/sshd

/etc/init.d/xdm restart
/usr/sbin/sshd

##export DISPLAY=:0

tail -f /var/log/Xorg.0.log
