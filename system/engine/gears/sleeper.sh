#!/system/bin/sh
### FeraDroid Engine v0.21 | By FeraVolt. 2016 ###
B=/system/engine/bin/busybox
LOG=/sdcard/Android/FDE_log.txt
sync;
W=$($B cat /system/engine/assets/FDE_config.txt | $B grep -v -e '#' | $B tail -n1)
ON=$($B cat /system/engine/assets/FDE_config.txt | $B grep -e 'sleeper=1')
if [ "sleeper=1" = "$ON" ]; then
 $B echo "Sleeper daemon is active." >> $LOG
 while true; do
  PID=$($B pgrep -l '' | $B grep -E "org.|app.|com.|net.|eu." | $B grep -v -i -E "41|74|WorkQueue|app_process|krfcommd|GIRQ|remote|system|phone|alarm|android|broadcom|mms|sms|launcher|home|trebuchet|$W" | $B awk '{print $1}')
  if [ "false" = "$(dumpsys power | $B grep -E "mScreenOn" | $B grep -o "false")" ]; then
   sync;
   for i in $PID; do
     kill -STOP "$i"
   done;
   if [ -e /proc/sys/vm/drop_caches ]; then
    sync;
    $B sleep 1
    $B echo 3 > /proc/sys/vm/drop_caches
    $B sleep 1
    sync;
   fi;
   BA=$($B cat /system/engine/assets/FDE_config.txt | $B grep -e 'battery=' | $B sed -e "s|battery=|""|")
   if [ "$($B cat /sys/class/power_supply/battery/capacity)" -le "$BA" ]; then
    svc wifi disable
    svc nfc disable
    svc data disable
    service call bluetooth_manager 8
    setprop ro.com.google.networklocation 0
    am broadcast -a android.intent.action.BATTERY_LOW
   fi;
   until [ "true" = "$(dumpsys power | $B grep "mScreenOn" | $B grep -o "true")" ]; do
    $B sleep 3
   done;
  elif [ "true" = "$(dumpsys power | $B grep -E "mScreenOn" | $B grep -o "true")" ]; then
   for i in $PID; do
     kill -CONT "$i"
   done;
   H=$($B pgrep -l '' | $B grep -E "launcher" | $B awk '{print $1}')
   S=$($B pgrep -l '' | $B grep -E "systemui" | $B awk '{print $1}')
   U=$($B pgrep -l '' | $B grep -E "surfaceflinger" | $B awk '{print $1}')
   L=$($B pgrep -l '' | $B grep -E "home" | $B awk '{print $1}')
   P=$($B pgrep -l '' | $B grep -E "phone" | $B awk '{print $1}')
   D=$($B pgrep -l '' | $B grep -E "dialer" | $B awk '{print $1}')
   S=$($B pgrep -l '' | $B grep -E "swap" | $B awk '{print $1}')
   E=$($B pgrep -l '' | $B grep -E "server" | $B awk '{print $1}')
   T=$($B pgrep -l '' | $B grep -E "trebuchet" | $B awk '{print $1}')
   M=$($B pgrep -l '' | $B grep -E "service" | $B awk '{print $1}')
   $B echo "Change priority for $H $S $U $L $P"
   renice [-10] "$H"
   renice [-9] "$S"
   renice [-8] "$U"
   renice [-10] "$L"
   renice [-10] "$P"
   renice 0 "$S"
   renice [-1] "$E"
   renice [-10] "$T"
   renice [-10] "$D"
   renice 6 "$D"
   until [ "false" = "$(dumpsys power | $B grep "mScreenOn" | $B grep -o "false")" ]; do
    $B sleep 18
   done;
  fi;
 done;
else
 $B echo "Sleeper daemon is not active." >> $LOG
fi;
