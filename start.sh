#!/bin/bash

mkdir /var/run/sshd

/etc/init.d/xdm restart
/usr/sbin/sshd

##export DISPLAY=:0

usermod -u $PUID atom
groupmod -g $PGID atom

tail -f /var/log/*.log
