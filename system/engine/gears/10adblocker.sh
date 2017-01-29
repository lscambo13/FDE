#!/system/bin/sh
### FeraDroid Engine v0.23 | By FeraVolt. 2017 ###
B=/system/engine/bin/busybox
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] ***Ad-blocker gear***"
NO=$($B cat /system/engine/assets/FDE_config.txt | $B grep -e 'adblock=0')
if [ "adblock=0" = "$NO" ]; then
 $B echo "Ad-blocker is OFF.."
else 
 $B echo "Updating hosts.." 
 $B mount -o remount,rw /system
 if [ -e /sbin/sysrw ]; then
  /sbin/sysrw
 fi;
 $B touch /system/engine/assets/hosts
 $B chmod 777 /system/engine/assets/hosts
 $B sleep 1
 $B wget -O /system/engine/assets/hosts "http://forum.xda-developers.com/devdb/project/dl/?id=19057&task=get"
 $B sleep 3
 $B rm -f /system/etc/hosts
 $B cp /system/engine/assets/hosts /system/etc/hosts
 $B chmod 755 /system/etc/hosts
 $B echo "Done."
fi;
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] ***Ad-blocker gear*** - OK"
sync;
