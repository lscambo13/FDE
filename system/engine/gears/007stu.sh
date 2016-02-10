#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2016 ###
B=/system/engine/bin/busybox
A=$(cat /sys/class/power_supply/battery/capacity)
LOG=/sdcard/Android/FDE.txt
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
if [ -e /sys/devices/platform/sec-battery/power_supply/battery/charge_current_override ]; then
 $B echo "(2)Fast charge support detected. Activating.." >> $LOG
 $B echo "1200" > /sys/devices/platform/sec-battery/power_supply/battery/charge_current_override
 $B echo "1200" > /sys/devices/platform/i2c-gpio.15/i2c-15/15-0034/power_supply/sec-charger/charge_current_override
fi;
if [ -e /sys/module/lpm_levels/parameters/sleep_disabled ]; then
 $B echo "LowPower mode support detected. Activating.." >> $LOG
 $B echo "0" > /sys/module/lpm_levels/parameters/sleep_disabled
fi;
if [ -e /sys/class/lcd/panel/power_reduce ]; then
 $B echo "LCD power reduce detected. Activating.." >> $LOG
 $B echo "1" > /sys/class/lcd/panel/power_reduce
fi;
$B echo "Tuning Android power-saving.." >> $LOG
setprop power.saving.mode 1
setprop ro.vold.umsdirtyratio 20
setprop pm.sleep_mode 1
setprop ro.ril.disable.power.collapse 0
setprop ro.config.hw_power_saving 1
setprop dev.pm.dyn_samplingrate 1
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] 007 - ***Battery gear*** - OK" >> $LOG
sync;
