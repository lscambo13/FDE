#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2016 ###

B=/system/engine/bin/busybox
LOG=/sdcard/Android/FDE.txt
TIME=$($B date | $B awk '{ print $4 }')

$B echo "[$TIME] 009 - ***CPU gear***" >> $LOG
$B echo "" >> $LOG
if [ -e /sys/devices/system/cpu/sched_mc_power_savings ]; then 
$B echo "Tuning Multi-core power-saving.." >> $LOG
$B echo "2" > /sys/devices/system/cpu/sched_mc_power_savings
fi;
$B echo "[$TIME] 009 - ***VM gear*** - OK" >> $LOG
sync;

