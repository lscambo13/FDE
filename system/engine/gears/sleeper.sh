#!/system/bin/sh
### FeraDroid Engine v1.1 | By FeraVolt. 2017 ###
B=/system/engine/bin/busybox;
SDK=$(getprop ro.build.version.sdk);
RAM=$($B free -m | $B awk '{ print $2 }' | $B sed -n 2p);
BG=$((RAM/100));
if [ -d /sdcard/Android/ ]; then
 LOG=/sdcard/Android/FDE_log.txt;
else
 LOG=/data/media/0/Android/FDE_log.txt;
fi;
if [ "$SDK" -le "19" ]; then
 FS=false;
 TR=true;
 GR="mScreenOn";
else
 FS=FF;
 TR=N;
 GR="state=O";
fi;
ON=$($B cat /system/engine/raw/FDE_config.txt | $B grep -e 'sleeper=1');
if [ "sleeper=1" = "$ON" ]; then
 $B echo "Sleeper daemon is active." >> $LOG;
 while true; do
  until [ "$FS" = "$(dumpsys power | $B grep $GR | $B grep -o "$FS")" ]; do
   $B sleep 90;
  done;
  if [ "$FS" = "$(dumpsys power | $B grep -E $GR | $B grep -o "$FS")" ]; then
   $B sleep 9;
   RAMfree=$($B free -m | $B awk '{ print $4 }' | $B sed -n 2p)
   if [ "$RAMfree" -le "32" ]; then
    sync;
    $B sleep 1;
    $B echo "3" > /proc/sys/vm/drop_caches;
    $B sleep 2;
	sync;
	$B sleep 1;
   fi;
   $B killall -9 com.google.android.gms.persistent;
   service call activity 51 i32 0;
   $B sleep 2;
   BA=$($B cat /system/engine/raw/FDE_config.txt | $B grep -e 'lowbatt=' | $B sed -e "s|lowbatt=|""|");
   DT=$($B cat /system/engine/raw/FDE_config.txt | $B grep -e 'internet_control=1');
   if [ "$($B cat /sys/class/power_supply/battery/capacity)" -le "$BA" ]; then
    if [ "internet_control=1" = "$DT" ]; then
	 svc data disable;
     svc wifi disable;
    fi;
    svc nfc disable;
    svc power stayon false;
    service call bluetooth_manager 8;
    settings put global bluetooth_on 0;
    setprop ro.com.google.networklocation 0;
    am broadcast -a android.intent.action.BATTERY_LOW;
   fi;
   service call activity 51 i32 "$BG";
   until [ "$TR" = "$(dumpsys power | $B grep $GR | $B grep -o "$TR")" ]; do
    $B sleep 360;
   done;
  fi;
 done;
else
 $B echo "Sleeper daemon is not active." >> $LOG;
fi;

