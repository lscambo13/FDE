#!/system/engine/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2015 ###

B=/system/engine/busybox
SH=/system/engine/sh

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
   $B sleep 54
   $B rm -f /system/engine/prop/firstboot
   exit
else

$SH /system/engine/feradroid.sh