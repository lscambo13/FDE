#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2016 ###

B=/system/engine/bin/busybox
A=$(cat /sys/class/power_supply/battery/capacity)
if [ -e /system/engine/prop/firstboot ]; then
 LOG=/sdcard/Android/FDE.txt
else
 LOG=/dev/null
fi;
TIME=$($B date | $B awk '{ print $4 }')

$B echo "[$TIME] 007 - ***Battery gear***" >> $LOG
if [ "$A" -eq "100" ] ; then
 $B echo "Re-calibrating battery.." >> $LOG
 $B mount -o remount,rw /data
 $B rm -f /data/system/batterystats.bin
fi;
if [ -e /sys/kernel/fast_charge/force_fast_charge ]; then
 $B echo "Fast charge support detected. Activating.." >> $LOG
 $B echo "1" > /sys/kernel/fast_charge/force_fast_charge
fi;
if [ -e /sys/module/lpm_levels/parameters/sleep_disabled ]; then
 $B echo "LP mode support detected. Activating.." >> $LOG
 $B echo "0" > /sys/module/lpm_levels/parameters/sleep_disabled
fi;
if [ -e /sys/class/lcd/panel/power_reduce ]; then
 $B echo "LCD power reduce detected. Activating.." >> $LOG
 $B echo "1" > /sys/class/lcd/panel/power_reduce
fi;
$B echo "Tuning Android power-saving.." >> $LOG
setprop ro.mot.eri.losalert.delay 1000
setprop power.saving.mode 1
setprop ro.vold.umsdirtyratio 20
setprop persist.sys.purgeable_assets 1
setprop pm.sleep_mode 1
setprop ro.ril.disable.power.collapse 0
setprop persist.radio.add_power_save 1
setprop ro.config.hw_power_saving 1
setprop ro.config.hw_power_saving true
setprop persist.radio.add_power_save 1
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] 007 - ***Battery gear*** - OK" >> $LOG
sync;

