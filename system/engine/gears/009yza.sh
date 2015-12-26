#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2016 ###

B=/system/engine/bin/busybox
LOG=/sdcard/Android/FDE.txt
TIME=$($B date | $B awk '{ print $4 }')

$B echo "[$TIME] 009 - ***VM gear***" >> $LOG
$B echo "" >> $LOG
$B echo -9 > /proc/$(pgrep rngd)/oom_adj
$B echo "" >> $LOG
$B echo "[$TIME] 009 - ***VM gear*** - OK" >> $LOG
sync;

