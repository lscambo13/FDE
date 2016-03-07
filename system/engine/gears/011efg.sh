#!/system/bin/sh
### FeraDroid Engine v0.20 | By FeraVolt. 2016 ###
B=/system/engine/bin/busybox
LOG=/sdcard/Android/FDE.txt
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] 011 - ***GPS gear***" >> $LOG
$B echo "[$TIME] 011 - ***GPS gear*** - OK" >> $LOG
sync;
