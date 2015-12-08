#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2015 ###

B=/system/engine/bin/busybox

if [ -e /system/engine/prop/firstboot ]; then
 mount -o remount,rw /system
 chmod 777 /system/engine
 chmod -R 777 /system/engine/*
 chmod -R 777 /system/engine/assets/*
 chmod -R 777 /system/engine/bin/*
 chmod -R 777 /system/engine/gears/*
 chmod -R 777 /system/engine/prop/*
 $B chmod 644 /system/build.prop
 $B rm -Rf /data/dalvik-cache
 $B setprop ro.feralab.engine 19
 $B sleep 1
 $B mount -o remount,rw /system
 $B rm -f /system/engine/prop/firstboot
 $B --install -s /system/xbin
fi;
sleep 1
sync;

