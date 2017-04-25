#!/system/bin/sh
### FeraDroid Engine v0.27 | By FeraVolt. 2017 ###
B=/system/engine/bin/busybox;
TIME=$($B date | $B awk '{ print $4 }');
$B echo "[$TIME] ***Ad-blocker gear***";
$B echo "Updating hosts..";
$B mount -o remount,rw /system;
if [ -e /sbin/sysrw ]; then
 /sbin/sysrw;
fi;
$B sleep 0.5;
$B touch /system/engine/assets/hosts;
$B chmod 777 /system/engine/assets/hosts;
$B sleep 0.5;
$B wget -O /system/engine/assets/hosts "http://forum.xda-developers.com/devdb/project/dl/?id=19057&task=get";
$B sleep 3;
$B rm -f /system/etc/hosts;
SZ=$($B du -k "/system/engine/assets/hosts" | $B cut -f1);
if [ "$SZ" -lt "100" ]; then
 $B echo "Turn on internet to update ad-block list.";
 $B touch /system/etc/hosts;
 {
  $B echo "127.0.0.1       localhost"
  $B echo "::1             ip6-localhost"
  $B echo " "
 } >> /system/etc/hosts;
else
 $B echo "Ad-block list updated.";
 $B cp /system/engine/assets/hosts /system/etc/hosts;
fi;
$B chmod 755 /system/etc/hosts;
$B echo "Done.";
TIME=$($B date | $B awk '{ print $4 }');
$B echo "[$TIME] ***Ad-blocker gear*** - OK";
sync;
