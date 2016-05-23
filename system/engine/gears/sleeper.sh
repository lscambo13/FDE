#!/system/bin/sh
### FeraDroid Engine v0.21 | By FeraVolt. 2016 ###
B=/system/engine/bin/busybox
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] Sleeper daemon"
if [ -e /sys/power/wait_for_fb_sleep ]; then
 A=$(cat /sys/power/wait_for_fb_sleep)
 B=sleeping
 C=awake
elif [ -e /sys/class/graphics/fb0/show_blank_event ]; then
 A=$(cat /sys/class/graphics/fb0/show_blank_event)
 B=panel_power_on = 0
 C=panel_power_on = 1
fi;
$B mount -o remount,rw /system
$B chmod 777 /system/engine/assets/whitelist.txt
if [ -e /system/engine/prop/firstboot ]; then
 $B cp /system/engine/assets/whitelist.txt /sdcard/whitelist.txt
fi;
$B cp /sdcard/whitelist.txt /system/engine/assets/whitelist.txt
sync;
W=$($B cat /system/engine/assets/whitelist.txt | grep -v -e '#' | tail -n1)
ON=$($B cat /system/engine/assets/whitelist.txt | grep -e 'sleeper=1')
if [[ "sleeper=1" = "$ON" ]]; then
 while true; do
  if [[ "$A" = "$B" ]]; then
   sync;
   sleep 9
   if [ -e /proc/sys/vm/drop_caches ]; then
    $B sleep 1
    $B echo 3 > /proc/sys/vm/drop_caches
    $B sleep 1
    sync;
   fi;
   for i in $($B pgrep -l '' | $B grep -E 'org.|app.|com.|android.' | grep -v -i -e $W  | $B awk '{print $1}'); do
     kill -9 "$i"
   done;
   $B sleep 27
   until [[ "$A" = "$C" ]]; do
    $B sleep 9
   done;
  fi;
 done;
else
 $B echo "Sleeper daemon is not active."
fi;
