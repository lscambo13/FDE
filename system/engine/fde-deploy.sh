#!/system/engine/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2015 ###

B=/system/engine/bin/busybox

if [ -e /system/engine/prop/firstboot ];
then
   $B mount -o remount,rw /system
   $B chmod 777 /system/engine
   $B chmod 777 /system/engine
   $B chmod -R 777 /system/engine/*
   $B chmod -R 777 /system/engine/assets/*
   $B chmod -R 777 /system/engine/bin/*
   $B chmod -R 777 /system/engine/gears/*
   $B chmod -R 777 /system/engine/prop/*
   $B chmod 644 /system/build.prop
   $B chmod 777 /system/etc/sysctl.conf
   setprop ro.feralab.engine 19
   $B sleep 54
   $B rm -f /system/engine/prop/firstboot
   exit
else
if

$B sh /system/engine/feradroid.sh
fi
