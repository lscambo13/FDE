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
 chmod 644 /system/build.prop
 rm -Rf /data/dalvik-cache
 setprop ro.feralab.engine 19
 sleep 1
 mount -o remount,rw /system
 rm -f /system/engine/prop/firstboot
 $B --install -s /system/xbin
fi;
sleep 1
sync;

