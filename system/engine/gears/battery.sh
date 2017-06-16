#!/system/bin/sh
### FeraDroid Engine v1.1 | By FeraVolt. 2017 ###
B=/system/engine/bin/busybox;
SCORE=/system/engine/prop/score;
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
for i in $($B ls /sys/class/scsi_disk/); do
 $B cat /sys/class/scsi_disk/"$i"/write_protect 2>/dev/null | $B grep 1 >/dev/null
 $B echo "Better DeepSleep.";
 if [ $? -eq 0 ]; then
  $B echo "temporary none" > /sys/class/scsi_disk/"$i"/cache_type;
 fi;
done;
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
if [ "$SDK" -ge "23" ]; then
 $B echo "Aggressive Doze tune-up...";
 settings put global device_idle_constants light_after_inactive_to=30000;
 settings put global device_idle_constants light_pre_idle_to=30000;
 settings put global device_idle_constants light_idle_to=30000;
 settings put global device_idle_constants light_idle_factor=2.0;
 settings put global device_idle_constants light_max_idle_to=60000;
 settings put global device_idle_constants light_idle_maintenance_min_budget=30000;
 settings put global device_idle_constants light_idle_maintenance_max_budget=60000;
 settings put global device_idle_constants min_light_maintenance_time=5000;
 settings put global device_idle_constants min_deep_maintenance_time=10000;
 settings put global device_idle_constants inactive_to=60000;
 settings put global device_idle_constants sensing_to=0;
 settings put global device_idle_constants locating_to=5000;
 settings put global device_idle_constants location_accuracy=20.0;
 settings put global device_idle_constants motion_inactive_to=5000;
 settings put global device_idle_constants idle_after_inactive_to=0;
 settings put global device_idle_constants idle_pending_to=30000;
 settings put global device_idle_constants max_idle_pending_to=60000;
 settings put global device_idle_constants idle_pending_factor=2.0;
 settings put global device_idle_constants idle_to=3600000;
 settings put global device_idle_constants max_idle_to=21600000;
 settings put global device_idle_constants idle_factor=2.0;
 settings put global device_idle_constants min_time_to_alarm=3600000;
 settings put global device_idle_constants max_temp_app_whitelist_duration=20000;
 settings put global device_idle_constants mms_temp_app_whitelist_duration=20000;
 settings put global device_idle_constants sms_temp_app_whitelist_duration=20000;
 settings put global device_idle_constants notification_whitelist_duration=20000;
 $B echo "26" >> $SCORE;
fi;
