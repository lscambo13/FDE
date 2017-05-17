#!/system/bin/sh
### FeraDroid Engine v1.1 | By FeraVolt. 2017 ###
B=/system/engine/bin/busybox;
SCORE=/system/engine/prop/score;
dumpsys battery;
if [ -e /sys/kernel/fast_charge/force_fast_charge ]; then
 $B echo "Fast charge support detected. Activating...";
 $B echo "1" > /sys/kernel/fast_charge/force_fast_charge;
 $B echo "1" >> $SCORE;
fi;
if [ -e /sys/devices/platform/sec-battery/power_supply/battery/charge_current_override ]; then
 $B echo "Fast charge support detected. Activating...";
 $B echo "1500" > /sys/devices/platform/sec-battery/power_supply/battery/charge_current_override;
 $B echo "1500" > /sys/devices/platform/i2c-gpio.15/i2c-15/15-0034/power_supply/sec-charger/charge_current_override;
 $B echo "1" >> $SCORE;
fi;
if [ -e /sys/module/lpm_levels/parameters/sleep_disabled ]; then
 $B echo "LowPower mode support detected. Activating...";
 $B echo "0" > /sys/module/lpm_levels/parameters/sleep_disabled;
 $B echo "1" >> $SCORE;
fi;
if [ -e /sys/module/pm2/modes/cpu0/power_collapse/suspend_enabled ]; then
 $B echo "LowPower mode support detected. Activating...";
 $B echo "1" > /sys/module/pm2/modes/cpu0/standalone_power_collapse/idle_enabled;
 $B echo "1" > /sys/module/pm2/modes/cpu1/standalone_power_collapse/idle_enabled;
 $B echo "1" > /sys/module/pm2/modes/cpu0/standalone_power_collapse/suspend_enabled;
 $B echo "1" > /sys/module/pm2/modes/cpu1/standalone_power_collapse/suspend_enabled;
 $B echo "1" > /sys/module/pm2/modes/cpu0/power_collapse/suspend_enabled;
 $B echo "1" > /sys/module/pm2/modes/cpu0/power_collapse/idle_enabled;
 $B echo "1" >> $SCORE;
fi;
if [ -e /sys/module/pm2/parameters/idle_sleep_mode ]; then
 $B echo "LowPower mode support detected. Activating...";
 $B echo "1" > /sys/module/pm2/parameters/idle_sleep_mode;
 $B echo "1" >> $SCORE;
fi;
if [ -e /sys/module/msm_performance/parameters/touchboost ]; then
 $B echo "Disabling touchboost...";
 $B chmod 644 /sys/module/msm_performance/parameters/touchboost;
 $B echo "0" > /sys/module/msm_performance/parameters/touchboost;
 $B echo "1" >> $SCORE;
fi;
if [ -e /sys/module/cpu_boost/parameters/boost_ms ]; then
 $B echo "Disabling input-boost...";
 $B chmod 644 /sys/module/cpu_boost/parameters/boost_ms;
 $B chmod 644 /sys/module/cpu_boost/parameters/input_boost_ms;
 $B echo "0" > /sys/module/cpu_boost/parameters/boost_ms;
 $B echo "0" > /sys/module/cpu_boost/parameters/input_boost_ms;
 $B echo "1" >> $SCORE;
fi;
if [ -e /sys/class/lcd/panel/power_reduce ]; then
 $B echo "LCD power-reduce support detected. Activating...";
 $B echo "1" > /sys/class/lcd/panel/power_reduce;
 $B echo "1" >> $SCORE;
fi;
if [ -e /sys/power/cpufreq_min_limit ]; then
 $B echo "Allow CPU underclock...";
 $B echo "0" > /sys/power/cpufreq_min_limit;
 $B chmod 444 /sys/power/cpufreq_min_limit;
 $B echo "1" >> $SCORE;
fi;
if [ -e /sys/class/timed_output/vibrator/vtg_level ]; then
 $B echo "Vibrator undervolting...";
 $B echo "1369" > /sys/class/timed_output/vibrator/vtg_level;
 $B echo "1" >> $SCORE;
fi;
if [ -e /sys/module/cpuidle_scx35/parameters/cpuidle_debug ]; then
 $B echo "Spreadtrum CPU idle tune-up...";
 $B echo "0" > /sys/module/cpuidle_scx35/parameters/cpuidle_debug;
 $B echo "1" > /sys/module/cpuidle_scx35/parameters/idle_deep_en;
 $B echo "0" > /sys/module/cpuidle_scx35/parameters/light_sleep_en;
 $B echo "1" >> $SCORE;
fi;
$B echo "Tuning Android power-saving...";
setprop power.saving.mode 1;
setprop persist.radio.ramdump 0;
setprop pm.sleep_mode 1;
setprop ro.ril.disable.power.collapse 0;
setprop ro.semc.enable.fast_dormancy false;
setprop ro.ril.fast.dormancy.rule 0;
setprop ro.ril.fast.dormancy 0;
setprop ro.config.hw_power_saving 1;
setprop dev.pm.dyn_samplingrate 1;
setprop persist.radio.add_power_save 1;
setprop ro.com.google.networklocation 0;
$B echo "1" >> $SCORE;
