#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2015 ###

B=/system/engine/bin/busybox

if [ -e /system/engine/prop/firstboot ]; then
 $B mount -o remount,rw /system
 $B chmod 777 /system/engine
 $B chmod -R 777 /system/engine/*
 $B chmod -R 777 /system/engine/assets/*
 $B chmod -R 777 /system/engine/bin/*
 $B chmod -R 777 /system/engine/gears/*
 $B chmod -R 777 /system/engine/prop/*
 $B chmod 644 /system/build.prop
 $B chmod 777 /system/etc/sysctl.conf
 $B rm -Rf /data/dalvik-cache
 setprop ro.feralab.engine 19
 $B sleep 18
 $B mount -o remount,rw /system
 $B rm -f /system/engine/prop/firstboot
fi;
$B sleep 3
sync;

