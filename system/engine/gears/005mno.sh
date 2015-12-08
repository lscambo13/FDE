#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2015 ###

B=/system/engine/bin/busybox

if [ -e /system/etc/sysctl.conf ]; then
 $B chmod 777 /system/etc/sysctl.conf
 $B sysctl -p
 $B sleep 3
else
 $B touch /system/etc/sysctl.conf
 $B chmod 777 /system/etc/sysctl.conf
fi;
$B sync;

