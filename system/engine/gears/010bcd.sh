#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2016 ###

B=/system/engine/bin/busybox
LOG=/sdcard/Android/FDE.txt
TIME=$($B date | $B awk '{ print $4 }')

$B echo "[$TIME] 010 - ***CPU gear***" >> $LOG
$B echo "" >> $LOG
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/ondemand/up_threshold ]; then
$B echo "CPU0 ondemand tuning.." >> $LOG
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/ondemand/up_threshold
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/ondemand/up_threshold
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/ondemand/down_differential
$B echo "85" > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/up_threshold
$B echo "10" > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/down_differential
$B echo "100000" > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/sampling_rate
 if [ -e /sys/devices/system/cpu/cpu0/cpufreq/ondemand/powersave_bias ]; then
  $B echo "Powersave bias - on" >> $LOG
  $B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/ondemand/powersave_bias
  $B echo "1" > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/powersave_bias
 fi;
fi;
if [ -e /sys/devices/system/cpu/cpu1/cpufreq/ondemand/up_threshold ]; then
$B echo "CPU1 ondemand tuning.." >> $LOG
$B chmod 644 /sys/devices/system/cpu/cpu1/cpufreq/ondemand/up_threshold
$B chmod 644 /sys/devices/system/cpu/cpu1/cpufreq/ondemand/up_threshold
$B chmod 644 /sys/devices/system/cpu/cpu1/cpufreq/ondemand/down_differential
$B echo "85" > /sys/devices/system/cpu/cpu1/cpufreq/ondemand/up_threshold
$B echo "10" > /sys/devices/system/cpu/cpu1/cpufreq/ondemand/down_differential
$B echo "100000" > /sys/devices/system/cpu/cpu1/cpufreq/ondemand/sampling_rate
 if [ -e /sys/devices/system/cpu/cpu1/cpufreq/ondemand/powersave_bias ]; then
  $B echo "Powersave bias - on" >> $LOG
  $B chmod 644 /sys/devices/system/cpu/cpu1/cpufreq/ondemand/powersave_bias
  $B echo "1" > /sys/devices/system/cpu/cpu1/cpufreq/ondemand/powersave_bias
 fi;
fi;
if [ -e /sys/devices/system/cpu/cpufreq/ondemand/up_threshold ]; then
$B echo "CPU ondemand tuning.." >> $LOG
$B chmod 644 /sys/devices/system/cpu/cpufreq/ondemand/up_threshold
$B chmod 644 /sys/devices/system/cpu/cpufreq/ondemand/up_threshold
$B chmod 644 /sys/devices/system/cpu/cpufreq/ondemand/down_differential
$B echo "85" > /sys/devices/system/cpu/cpufreq/ondemand/up_threshold
$B echo "10" > /sys/devices/system/cpu/cpufreq/ondemand/down_differential
$B echo "100000" > /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
 if [ -e /sys/devices/system/cpu/cpufreq/ondemand/powersave_bias ]; then
  $B echo "Powersave bias - on" >> $LOG
  $B chmod 644 /sys/devices/system/cpu/cpufreq/ondemand/powersave_bias
  $B echo "1" > /sys/devices/system/cpu/cpufreq/ondemand/powersave_bias
 fi;
fi;
if [ -e /sys/devices/system/cpu/cpufreq/sprdemand/up_threshold ]; then
$B echo "CPU sprdemand tuning.." >> $LOG
$B chmod 644 /sys/devices/system/cpu/cpufreq/ondemand/up_threshold
$B chmod 644 /sys/devices/system/cpu/cpufreq/ondemand/up_threshold
$B chmod 644 /sys/devices/system/cpu/cpufreq/ondemand/down_differential
$B echo "85" > /sys/devices/system/cpu/cpufreq/sprdemand/up_threshold
$B echo "10" > /sys/devices/system/cpu/cpufreq/sprdemand/down_differential
$B echo "100000" > /sys/devices/system/cpu/cpufreq/sprdemand/sampling_rate
 if [ -e /sys/devices/system/cpu/cpufreq/sprdemand/powersave_bias ]; then
  $B echo "Powersave bias - on" >> $LOG
  $B chmod 644 /sys/devices/system/cpu/cpufreq/ondemand/powersave_bias
  $B echo "1" > /sys/devices/system/cpu/cpufreq/sprdemand/powersave_bias
 fi;
fi;
if [ -e /system/engine/prop/ferakernel ]; then
$B echo "Boosting X10.." >> $LOG
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
$B echo "576000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
fi;
if [ -e /sys/module/workqueue/parameters/power_efficient ]; then
$B echo "Enabling power-save workqueues.." >> $LOG
$B chmod 644 /sys/module/workqueue/parameters/power_efficient
$B echo "1" > /sys/module/workqueue/parameters/power_efficient
fi;
if [ -e /sys/module/subsystem_restart/parameters/enable_ramdumps ]; then
$B echo "Disabling RAMdumps.." >> $LOG
$B chmod 644 /sys/module/subsystem_restart/parameters/enable_ramdumps
$B echo "0" > /sys/module/subsystem_restart/parameters/enable_ramdumps
fi;
if [ -e /sys/devices/system/cpu/sched_mc_power_savings ]; then 
$B echo "Enabling Multi-core power-saving.." >> $LOG
$B chmod 644 /sys/devices/system/cpu/sched_mc_power_savings
$B echo "2" > /sys/devices/system/cpu/sched_mc_power_savings
fi;
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/vdd_levels ]; then
$B chown root system /sys/devices/system/cpu/cpu0/cpufreq/vdd_levels
$B chmod 664 /sys/devices/system/cpu/cpu0/cpufreq/vdd_levels
fi;
$B echo "[$TIME] 010 - ***CPU gear*** - OK" >> $LOG
sync;

