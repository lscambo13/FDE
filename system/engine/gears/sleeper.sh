#!/system/bin/sh
### FeraDroid Engine v0.21 | By FeraVolt. 2016 ###
B=/system/engine/bin/busybox
LOG=/sdcard/Android/FDE.txt
if [ -e /sys/power/wait_for_fb_sleep ]; then
 A=$(cat /sys/power/wait_for_fb_sleep)
 B=sleeping
 C=awake
elif [ -e /sys/class/graphics/fb0/show_blank_event ]; then
 A=$(cat /sys/class/graphics/fb0/show_blank_event)
 B=panel_power_on = 0
 C=panel_power_on = 1
fi;
$B cp /sdcard/Android/sleeper_whitelist.txt /system/engine/assets/sleeper_whitelist.txt
sync;
$B mount -o remount,ro /system
W=$($B cat /system/engine/assets/sleeper_whitelist.txt | grep -v -e '#' | tail -n1)
ON=$($B cat /system/engine/assets/sleeper_whitelist.txt | grep -e 'sleeper=1')
if [[ "sleeper=1" = "$ON" ]]; then
 $B echo "Sleeper daemon is active." > $LOG
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
   for i in $($B pgrep -l '' | $B grep -E 'org.|app.|com.|android.|net.|eu.' | grep -v -i -e $W  | $B awk '{print $1}'); do
     kill -9 "$i"
   done;
   $B sleep 27
   until [[ "$A" = "$C" ]]; do
    $B sleep 9
   done;
  fi;
 done;
else
 $B echo "Sleeper daemon is not active." > $LOG
fi;
