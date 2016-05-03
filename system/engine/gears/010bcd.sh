#!/system/bin/sh
### FeraDroid Engine v0.20 | By FeraVolt. 2016 ###
B=/system/engine/bin/busybox
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] 010 - ***CPU gear***"
MAX=$($B cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq)
if [ -e /sys/module/msm_thermal/core_control/enabled ]; then
 $B echo "Disable MSM thermal core for now.."
 $B echo 0 > /sys/module/msm_thermal/core_control/enabled
fi;
if [ -e /sys/devices/platform/scxx30-dmcfreq.0/devfreq/scxx30-dmcfreq.0/ondemand/set_freq ]; then
 $B echo "Boosting ARK Benefit M2C.."
 $B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
 $B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
 $B chmod 644 /sys/devices/platform/scxx30-dmcfreq.0/devfreq/scxx30-dmcfreq.0/ondemand/set_downdifferential
 $B chmod 644 /sys/devices/platform/scxx30-dmcfreq.0/devfreq/scxx30-dmcfreq.0/ondemand/set_enable
 $B chmod 644 /sys/devices/platform/scxx30-dmcfreq.0/devfreq/scxx30-dmcfreq.0/ondemand/set_freq
 $B chmod 644 /sys/devices/platform/scxx30-dmcfreq.0/devfreq/scxx30-dmcfreq.0/ondemand/set_upthreshold
 $B echo "600000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
 $B echo "ondemand" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
 $B echo "533000" > /sys/devices/platform/scxx30-dmcfreq.0/devfreq/scxx30-dmcfreq.0/ondemand/set_freq
 $B echo "20" > /sys/devices/platform/scxx30-dmcfreq.0/devfreq/scxx30-dmcfreq.0/ondemand/set_downdifferential
 $B echo "1" > /sys/devices/platform/scxx30-dmcfreq.0/devfreq/scxx30-dmcfreq.0/ondemand/set_enable
 $B echo "72" > /sys/devices/platform/scxx30-dmcfreq.0/devfreq/scxx30-dmcfreq.0/ondemand/set_upthreshold
 TF=$($B cat /sys/devices/platform/scxx30-dmcfreq.0/devfreq/scxx30-dmcfreq.0/max_freq)
 $B echo $TF > /sys/devices/platform/scxx30-dmcfreq.0/devfreq/scxx30-dmcfreq.0/target_freq
fi;
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/ondemand/up_threshold ]; then
$B echo "CPU0 ondemand tuning.."
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/ondemand/up_threshold
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/ondemand/sampling_rate
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/ondemand/down_differential
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/ondemand/io_is_busy
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/ondemand/sampling_down_factor
$B echo "72" > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/up_threshold
$B echo "20" > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/down_differential
$B echo "10000" > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/sampling_rate
$B echo "1" > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/sampling_down_factor
 if [ -e /sys/devices/system/cpu/cpu0/cpufreq/ondemand/powersave_bias ]; then
  $B echo "Powersave bias - on"
  $B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/ondemand/powersave_bias
  if [ "$MAX" -ge "2000000" ]; then
   $B echo "180" > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/powersave_bias
  else
   $B echo "90" > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/powersave_bias
  fi;
 fi;
fi;
if [ -e /sys/devices/system/cpu/cpufreq/ondemand/up_threshold ]; then
$B echo "CPU ondemand tuning.."
$B chmod 644 /sys/devices/system/cpu/cpufreq/ondemand/up_threshold
$B chmod 644 /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
$B chmod 644 /sys/devices/system/cpu/cpufreq/ondemand/down_differential
$B chmod 644 /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy
$B chmod 644 /sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor
$B echo "72" > /sys/devices/system/cpu/cpufreq/ondemand/up_threshold
$B echo "20" > /sys/devices/system/cpu/cpufreq/ondemand/down_differential
$B echo "10000" > /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
$B echo "1" > /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy
$B echo "1" > /sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor
 if [ -e /sys/devices/system/cpu/cpufreq/ondemand/powersave_bias ]; then
  $B echo "Powersave bias - on"
  $B chmod 644 /sys/devices/system/cpu/cpufreq/ondemand/powersave_bias
  if [ "$MAX" -ge "2000000" ]; then
   $B echo "180" > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/powersave_bias
  else
   $B echo "90" > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/powersave_bias
  fi;
 fi;
fi;
if [ -e /sys/devices/system/cpu/cpufreq/sprdemand/up_threshold ]; then
 $B echo "CPU sprdemand tuning.."
 $B chmod 644 /sys/devices/system/cpu/cpufreq/sprdemand/up_threshold
 $B chmod 644 /sys/devices/system/cpu/cpufreq/sprdemand/sampling_rate
 $B chmod 644 /sys/devices/system/cpu/cpufreq/sprdemand/down_differential
 $B chmod 644 /sys/devices/system/cpu/cpufreq/sprdemand/io_is_busy
 $B chmod 644 /sys/devices/system/cpu/cpufreq/sprdemand/sampling_down_factor
 $B echo "72" > /sys/devices/system/cpu/cpufreq/sprdemand/up_threshold
 $B echo "20" > /sys/devices/system/cpu/cpufreq/sprdemand/down_differential
 $B echo "10000" > /sys/devices/system/cpu/cpufreq/sprdemand/sampling_rate
 $B echo "1" > /sys/devices/system/cpu/cpufreq/sprdemand/io_is_busy
 $B echo "0" > /sys/devices/system/cpu/cpufreq/sprdemand/powersave_bias
 $B echo "1" > /sys/devices/system/cpu/cpufreq/sprdemand/sampling_down_factor
fi;
if [ -e /system/engine/prop/ferakernel ]; then
 $B echo "Boosting Xperia X10.."
 $B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
 $B echo "576000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
fi;
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/smartassH3/sample_rate_jiffies ]; then
$B echo "CPU0 SmartassH3 tuning.."
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/smartassH3/debug_mask
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/smartassH3/ramp_up_step
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/smartassH3/ramp_down_step
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/smartassH3/max_cpu_load
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/smartassH3/min_cpu_load
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/smartassH3/up_rate_us
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/smartassH3/down_rate_us
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/smartassH3/sample_rate_jiffies
$B echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/smartassH3/debug_mask
$B echo "192000" > /sys/devices/system/cpu/cpu0/cpufreq/smartassH3/ramp_up_step
$B echo "192000" > /sys/devices/system/cpu/cpu0/cpufreq/smartassH3/ramp_down_step
$B echo "60" > /sys/devices/system/cpu/cpu0/cpufreq/smartassH3/max_cpu_load
$B echo "20" > /sys/devices/system/cpu/cpu0/cpufreq/smartassH3/min_cpu_load
$B echo "21000" > /sys/devices/system/cpu/cpu0/cpufreq/smartassH3/up_rate_us
$B echo "21000" > /sys/devices/system/cpu/cpu0/cpufreq/smartassH3/down_rate_us
$B echo "2" > /sys/devices/system/cpu/cpu0/cpufreq/smartassH3/sample_rate_jiffies
 if [ -e /system/engine/prop/ferakernel ]; then
  $B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/smartassH3/awake_ideal_freq
  $B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/smartassH3/sleep_ideal_freq
  $B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/smartassH3/sleep_wakeup_freq
  $B echo "768000" > /sys/devices/system/cpu/cpu0/cpufreq/smartassH3/sleep_wakeup_freq
  $B echo "998400" > /sys/devices/system/cpu/cpu0/cpufreq/smartassH3/awake_ideal_freq
  $B echo "576000" > /sys/devices/system/cpu/cpu0/cpufreq/smartassH3/sleep_ideal_freq
 fi;
 if [ -e /sys/devices/system/cpu/cpu0/cpufreq/smartassH3/boost_enabled ]; then
  $B echo "Boost-pulse - on"
  $B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/smartassH3/boost_pulse
  $B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/smartassH3/boost_enabled
  $B echo "1" > /sys/devices/system/cpu/cpu0/cpufreq/smartassH3/boost_enabled
  $B echo "3000000" > /sys/devices/system/cpu/cpu0/cpufreq/smartassH3/boost_pulse
 fi;
fi;
if [ -e /sys/devices/system/cpu/cpufreq/smartassH3/sample_rate_jiffies ]; then
$B echo "CPU SmartassH3 tuning.."
$B chmod 644 /sys/devices/system/cpu/cpufreq/smartassH3/debug_mask
$B chmod 644 /sys/devices/system/cpu/cpufreq/smartassH3/ramp_up_step
$B chmod 644 /sys/devices/system/cpu/cpufreq/smartassH3/ramp_down_step
$B chmod 644 /sys/devices/system/cpu/cpufreq/smartassH3/max_cpu_load
$B chmod 644 /sys/devices/system/cpu/cpufreq/smartassH3/min_cpu_load
$B chmod 644 /sys/devices/system/cpu/cpufreq/smartassH3/up_rate_us
$B chmod 644 /sys/devices/system/cpu/cpufreq/smartassH3/down_rate_us
$B chmod 644 /sys/devices/system/cpu/cpufreq/smartassH3/sample_rate_jiffies
$B echo "0" > /sys/devices/system/cpu/cpufreq/smartassH3/debug_mask
$B echo "192000" > /sys/devices/system/cpu/cpufreq/smartassH3/ramp_up_step
$B echo "192000" > /sys/devices/system/cpu/cpufreq/smartassH3/ramp_down_step
$B echo "60" > /sys/devices/system/cpu/cpufreq/smartassH3/max_cpu_load
$B echo "20" > /sys/devices/system/cpu/cpufreq/smartassH3/min_cpu_load
$B echo "21000" > /sys/devices/system/cpu/cpufreq/smartassH3/up_rate_us
$B echo "21000" > /sys/devices/system/cpu/cpufreq/smartassH3/down_rate_us
$B echo "2" > /sys/devices/system/cpu/cpufreq/smartassH3/sample_rate_jiffies
 if [ -e /sys/devices/system/cpu/cpufreq/smartassH3/boost_enabled ]; then
  $B echo "Boost-pulse - on"
  $B chmod 644 /sys/devices/system/cpu/cpufreq/smartassH3/boost_pulse
  $B chmod 644 /sys/devices/system/cpu/cpufreq/smartassH3/boost_enabled
  $B echo "1" > /sys/devices/system/cpu/cpufreq/smartassH3/boost_enabled
  $B echo "3000000" > /sys/devices/system/cpu/cpufreq/smartassH3/boost_pulse
 fi;
fi;
if [ -e /sys/devices/system/cpu/cpufreq/smartassV2/sample_rate_jiffies ]; then
$B echo "CPU SmartassV2 tuning.."
$B chmod 644 /sys/devices/system/cpu/cpufreq/smartassV2/debug_mask
$B chmod 644 /sys/devices/system/cpu/cpufreq/smartassV2/ramp_up_step
$B chmod 644 /sys/devices/system/cpu/cpufreq/smartassV2/ramp_down_step
$B chmod 644 /sys/devices/system/cpu/cpufreq/smartassV2/max_cpu_load
$B chmod 644 /sys/devices/system/cpu/cpufreq/smartassV2/min_cpu_load
$B chmod 644 /sys/devices/system/cpu/cpufreq/smartassV2/up_rate_us
$B chmod 644 /sys/devices/system/cpu/cpufreq/smartassV2/down_rate_us
$B chmod 644 /sys/devices/system/cpu/cpufreq/smartassV2/sample_rate_jiffies
$B echo "0" > /sys/devices/system/cpu/cpufreq/smartassV2/debug_mask
$B echo "192000" > /sys/devices/system/cpu/cpufreq/smartassV2/ramp_up_step
$B echo "192000" > /sys/devices/system/cpu/cpufreq/smartassV2/ramp_down_step
$B echo "60" > /sys/devices/system/cpu/cpufreq/smartassV2/max_cpu_load
$B echo "20" > /sys/devices/system/cpu/cpufreq/smartassV2/min_cpu_load
$B echo "21000" > /sys/devices/system/cpu/cpufreq/smartassV2/up_rate_us
$B echo "21000" > /sys/devices/system/cpu/cpufreq/smartassV2/down_rate_us
$B echo "2" > /sys/devices/system/cpu/cpufreq/smartassV2/sample_rate_jiffies
fi;
if [ -e /sys/devices/system/cpu/cpufreq/smartass/sample_rate_jiffies ]; then
$B echo "CPU Smartass tuning.."
$B chmod 644 /sys/devices/system/cpu/cpufreq/smartass/debug_mask
$B chmod 644 /sys/devices/system/cpu/cpufreq/smartass/ramp_up_step
$B chmod 644 /sys/devices/system/cpu/cpufreq/smartass/ramp_down_step
$B chmod 644 /sys/devices/system/cpu/cpufreq/smartass/max_cpu_load
$B chmod 644 /sys/devices/system/cpu/cpufreq/smartass/min_cpu_load
$B chmod 644 /sys/devices/system/cpu/cpufreq/smartass/up_rate_us
$B chmod 644 /sys/devices/system/cpu/cpufreq/smartass/down_rate_us
$B chmod 644 /sys/devices/system/cpu/cpufreq/smartass/sample_rate_jiffies
$B echo "0" > /sys/devices/system/cpu/cpufreq/smartass/debug_mask
$B echo "192000" > /sys/devices/system/cpu/cpufreq/smartass/ramp_up_step
$B echo "192000" > /sys/devices/system/cpu/cpufreq/smartass/ramp_down_step
$B echo "60" > /sys/devices/system/cpu/cpufreq/smartass/max_cpu_load
$B echo "20" > /sys/devices/system/cpu/cpufreq/smartass/min_cpu_load
$B echo "21000" > /sys/devices/system/cpu/cpufreq/smartass/up_rate_us
$B echo "21000" > /sys/devices/system/cpu/cpufreq/smartass/down_rate_us
$B echo "2" > /sys/devices/system/cpu/cpufreq/smartass/sample_rate_jiffies
fi;
if [ -e /sys/devices/system/cpu/cpufreq/interactive/min_sample_time ]; then
$B echo "CPU Interactive tuning.."
$B echo "72" > /sys/devices/system/cpu/cpufreq/interactive/go_highspeed_load
$B echo "85" > /sys/devices/system/cpu/cpufreq/interactive/go_maxspeed_load
$B echo "40000" > /sys/devices/system/cpu/cpufreq/interactive/min_sample_time
$B echo "30000" > /sys/devices/system/cpu/cpufreq/interactive/timer_rate
fi;
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time ]; then
$B echo "CPU0 Interactive tuning.."
$B echo "72" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_highspeed_load
$B echo "85" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_maxspeed_load
$B echo "1" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
$B echo "40000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
$B echo "30000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
fi;
if [ -e /sys/devices/system/cpu/cpufreq/interactivex/min_sample_time ]; then
$B echo "CPU InteractiveX tuning.."
$B echo "72" > /sys/devices/system/cpu/cpufreq/interactivex/go_highspeed_load
$B echo "85" > /sys/devices/system/cpu/cpufreq/interactivex/go_maxspeed_load
$B echo "1" > /sys/devices/system/cpu/cpufreq/interactive/io_is_busy
$B echo "30000" > /sys/devices/system/cpu/cpufreq/interactivex/min_sample_time
$B echo "30000" > /sys/devices/system/cpu/cpufreq/interactivex/timer_rate
fi;
if [ -e /sys/devices/system/cpu/cpufreq/pegasusq/up_threshold ]; then
$B echo "CPU Pegasusq tuning.."
$B echo "72" > /sys/devices/system/cpu/cpufreq/pegasusq/up_threshold
$B echo "20" > /sys/devices/system/cpu/cpufreq/pegasusq/down_differential
$B echo "3" > /sys/devices/system/cpu/cpufreq/pegasusq/sampling_down_factor
$B echo "1" > /sys/devices/system/cpu/cpufreq/pegasusq/io_is_busy
$B echo "10000" > /sys/devices/system/cpu/cpufreq/pegasusq/sampling_rate
$B echo "192" > /sys/devices/system/cpu/cpufreq/pegasusq/freq_step
fi;
if [ -e /sys/module/workqueue/parameters/power_efficient ]; then
 $B echo "Enabling power-save workqueues.."
 $B chmod 644 /sys/module/workqueue/parameters/power_efficient
 $B echo "1" > /sys/module/workqueue/parameters/power_efficient
fi;
if [ -e /sys/module/subsystem_restart/parameters/enable_ramdumps ]; then
 $B echo "Disabling RAM-dumps.."
 $B chmod 644 /sys/module/subsystem_restart/parameters/enable_ramdumps
 $B echo "0" > /sys/module/subsystem_restart/parameters/enable_ramdumps
fi;
if [ -e /sys/devices/system/cpu/sched_mc_power_savings ]; then 
 $B echo "Enabling Multi-core power-saving.."
 $B chmod 644 /sys/devices/system/cpu/sched_mc_power_savings
 $B echo "2" > /sys/devices/system/cpu/sched_mc_power_savings
fi;
if [ -e /system/etc/thermald.conf ]; then 
 $B mount -o remount,rw /system
 $B echo "Thermal control tune-up.."
 $B rm -f /system/etc/thermald.conf
 $B rm -f /system/etc/thermald-8974.conf
 $B rm -f /system/etc/thermal-engine.conf
 $B rm -f /system/etc/thermal-engine-8974.conf
 $B cp -f /system/engine/assets/thermald.conf /system/etc/thermald.conf
 $B cp -f /system/engine/assets/thermald.conf /system/etc/thermald-8974.conf
 $B cp -f /system/engine/assets/thermal-engine.conf /system/etc/thermal-engine.conf
 $B cp -f /system/engine/assets/thermal-engine.conf /system/etc/thermal-engine-8974.conf
 $B chmod 644 /system/etc/thermald.conf
 $B chmod 644 /system/etc/thermald-8974.conf
 $B chmod 644 /system/etc/thermal-engine.conf
 $B chmod 644 /system/etc/thermal-engine-8974.conf
fi;
if [ -e /dev/cpuctl/cpu.shares ]; then
 $B echo "62" > /dev/cpuctl/bg_non_interactive/cpu.shares
 $B echo "700000" > /dev/cpuctl/bg_non_interactive/cpu.rt_runtime_us
 $B echo "1000000" > /dev/cpuctl/bg_non_interactive/cpu.rt_period_us
 $B echo "1024" > /dev/cpuctl/cpu.shares
 $B echo "800000" > /dev/cpuctl/cpu.rt_runtime_us
 $B echo "1000000" > /dev/cpuctl/cpu.rt_period_us
 CR=/dev/cpuctl
 $B mkdir $CR/native
 $B echo 150000 > $CR/native/cpu.rt_runtime_us
 for i in $(cat $CR/tasks); do
  $B echo "${i}" > $CR/native/tasks
 done;
 $B echo "CGroups tuned.."
fi;
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/vdd_levels ]; then
 $B chown root system /sys/devices/system/cpu/cpu0/cpufreq/vdd_levels
 $B chmod 664 /sys/devices/system/cpu/cpu0/cpufreq/vdd_levels
 if [ -e /init.es209ra.rc ]; then
  $B echo "X10 CPU vdd.."
  $B echo '245760 950' > /sys/devices/system/cpu/cpu0/cpufreq/vdd_levels
  $B echo '384000 950' > /sys/devices/system/cpu/cpu0/cpufreq/vdd_levels
  $B echo '576000 1000' > /sys/devices/system/cpu/cpu0/cpufreq/vdd_levels
  $B echo '768000 1100' > /sys/devices/system/cpu/cpu0/cpufreq/vdd_levels
  $B echo '998400 1250' > /sys/devices/system/cpu/cpu0/cpufreq/vdd_levels
  $B echo '1036800 1275' > /sys/devices/system/cpu/cpu0/cpufreq/vdd_levels
  $B echo '1075200 1300' > /sys/devices/system/cpu/cpu0/cpufreq/vdd_levels
  $B echo '1113600 1325' > /sys/devices/system/cpu/cpu0/cpufreq/vdd_levels
  $B echo '1152000 1325' > /sys/devices/system/cpu/cpu0/cpufreq/vdd_levels
  $B echo '1190400 1350' > /sys/devices/system/cpu/cpu0/cpufreq/vdd_levels
  $B echo '1228800 1375' > /sys/devices/system/cpu/cpu0/cpufreq/vdd_levels
  $B echo '1267200 1425' > /sys/devices/system/cpu/cpu0/cpufreq/vdd_levels
  $B echo '1305600 1425' > /sys/devices/system/cpu/cpu0/cpufreq/vdd_levels
 fi;
fi;
if [ -e /sys/module/msm_thermal/core_control/enabled ]; then
 $B echo "Enable MSM thermal core now.."
 $B echo 1 > /sys/module/msm_thermal/core_control/enabled
fi;
$B echo "[$TIME] 010 - ***CPU gear*** - OK"
sync;
