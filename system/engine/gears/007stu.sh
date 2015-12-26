#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2016 ###

B=/system/engine/bin/busybox
A=$(cat /sys/class/power_supply/battery/capacity)
LOG=/sdcard/Android/FDE.txt
TIME=$($B date | $B awk '{ print $4 }')

$B echo "[$TIME] 007 - ***Battery gear***" >> $LOG
$B echo "" >> $LOG
if [ "$A" = "100" ] ; then
 $B echo " Re-calibrating battery.." >> $LOG
 $B mount -o remount,rw /data
 $B rm -f /data/system/batterystats.bin
fi;
if [ -e /sys/devices/system/cpu/sched_mc_power_savings ]; then 
$B echo " Tuning Kernel power-saving.." >> $LOG
$B echo "2" > /sys/devices/system/cpu/sched_mc_power_savings
fi;
$B echo " Tuning Android power-saving.." >> $LOG
setprop ro.mot.eri.losalert.delay 1000
setprop power.saving.mode 1
setprop ro.vold.umsdirtyratio 20
setprop persist.sys.purgeable_assets 1
setprop pm.sleep_mode 1
setprop ro.ril.disable.power.collapse 0
$B echo "" >> $LOG
$B echo "[$TIME] 007 - ***Battery gear*** - OK" >> $LOG
sync;

