#!/system/bin/sh
### FeraDroid Engine v0.21 | By FeraVolt. 2016 ###
B=/system/engine/bin/busybox
LOG=/sdcard/Android/FDE.txt
sync;
if [ -e /sdcard/Android/sleeper_whitelist.txt ]; then
 $B mount -o remount,rw /system
 $B rm -f /system/engine/assets/sleeper_whitelist.txt
 $B cp /sdcard/Android/sleeper_whitelist.txt /system/engine/assets/sleeper_whitelist.txt
 $B mount -o remount,ro /system
fi;
W=$($B cat /system/engine/assets/sleeper_whitelist.txt | $B grep -v -E '#' | $B tail -n1)
ON=$($B cat /system/engine/assets/sleeper_whitelist.txt | $B grep -E 'sleeper=1')
B=$($B cat /system/engine/assets/sleeper_whitelist.txt | $B grep -E 'battery=' | $B sed -e "s|battery=|""|")
if [[ "sleeper=1" = "$ON" ]]; then
 $B echo "Sleeper daemon is active." >> $LOG
 while true; do
  if [[ "false" = "$(dumpsys power | $B grep -E "mScreenOn" | $B grep -o "false")" ]]; then
   sync;
   for i in $($B pgrep -l '' | $B grep -E "org.|app.|com.|net.|eu." | $B grep -v -i -E "$W" | $B awk '{print $1}'); do
     kill -9 "$i"
   done;
   if [ -e /proc/sys/vm/drop_caches ]; then
    sync;
    $B sleep 1
    $B echo 3 > /proc/sys/vm/drop_caches
    $B sleep 1
    sync;
   fi;
   if [ "$($B cat /sys/class/power_supply/battery/capacity)" -le "$B" ]; then
    svc wifi disable
    svc nfc disable
    svc data disable
    service call bluetooth_manager 8
    setprop ro.com.google.networklocation 0
    am broadcast -a android.intent.action.BATTERY_LOW
   fi;
   until [[ "true" = "$(dumpsys power | $B grep "mScreenOn" | $B grep -o "true")" ]]; do
    $B sleep 300
   done;
  else
   $B sleep 18
  fi;
 done;
else
 $B echo "Sleeper daemon is not active." >> $LOG
fi;
