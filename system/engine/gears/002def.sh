#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2015 ###

B=/system/engine/bin/busybox

$B echo "***Ad-blocking gear***"
if [ -e /system/engine/prop/nohost ]; then
 $B mount -o remount,rw /system
 $B rm -f /system/etc/hosts
 $B cp /system/engine/assets/hosts /system/etc/hosts
 $B rm -f /system/engine/prop/nohost
 $B chmod 755 /system/etc/hosts
 $B sleep 1
fi;
$B echo "***Check***"
$B sleep 1
sync;

