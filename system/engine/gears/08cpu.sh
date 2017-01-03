#!/system/bin/sh
### FeraDroid Engine v0.22 | By FeraVolt. 2017 ###
B=/system/engine/bin/busybox
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] ***CPU gear***"
MAX=$($B cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq)
CORES=$($B grep -c 'processor' /proc/cpuinfo)
UP=70
DN=25
SF=2
RT=20000
if [ -e /sys/module/msm_thermal/core_control/enabled ]; then
 $B echo "Disable MSM thermal core for now.."
 $B echo 0 > /sys/module/msm_thermal/core_control/enabled
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
if [ -e /system/engine/prop/ferakernel ]; then
 $B echo "Boosting Xperia X10.."
 $B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
 $B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
 $B echo "384000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
 $B echo "1190400" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
fi;
if [ -e /sys/devices/system/cpu/cpufreq/ondemand/up_threshold ]; then
$B echo "CPU ondemand tuning.."
$B chmod 644 /sys/devices/system/cpu/cpufreq/ondemand/up_threshold
$B chmod 644 /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
$B chmod 644 /sys/devices/system/cpu/cpufreq/ondemand/down_differential
$B chmod 644 /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy
$B chmod 644 /sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor
$B echo "$UP" > /sys/devices/system/cpu/cpufreq/ondemand/up_threshold
$B echo "$DN" > /sys/devices/system/cpu/cpufreq/ondemand/down_differential
$B echo "$RT" > /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
$B echo "1" > /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy
$B echo "$SF" > /sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor
 if [ -e /sys/devices/system/cpu/cpufreq/ondemand/powersave_bias ]; then
  $B chmod 644 /sys/devices/system/cpu/cpufreq/ondemand/powersave_bias
  if [ "$MAX" -ge "1600000" ]; then
   $B echo "Powersave bias - on"
   $B echo "100" > /sys/devices/system/cpu/cpufreq/ondemand/powersave_bias
  else
   $B echo "Powersave bias - off"
   $B echo "0" > /sys/devices/system/cpu/cpufreq/ondemand/powersave_bias
  fi;
 fi;
fi;
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/ondemand/up_threshold ]; then
$B echo "CPU0 ondemand tuning.."
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/ondemand/up_threshold
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/ondemand/sampling_rate
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/ondemand/down_differential
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/ondemand/io_is_busy
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/ondemand/sampling_down_factor
$B echo "$UP" > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/up_threshold
$B echo "$DN" > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/down_differential
$B echo "$RT" > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/sampling_rate
$B echo "$SF" > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/sampling_down_factor
 if [ -e /sys/devices/system/cpu/cpu0/cpufreq/ondemand/powersave_bias ]; then
  $B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/ondemand/powersave_bias
  if [ "$MAX" -gt "1600000" ]; then
   $B echo "Powersave bias - on"
   $B echo "100" > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/powersave_bias
  else
   $B echo "Powersave bias - off"
   $B echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/powersave_bias
  fi;
 fi;
fi;
if [ -e /sys/devices/system/cpu/cpu4/cpufreq/ondemand/up_threshold ]; then
$B echo "CPU4 ondemand tuning.."
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/ondemand/up_threshold
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/ondemand/sampling_rate
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/ondemand/down_differential
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/ondemand/io_is_busy
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/ondemand/sampling_down_factor
$B echo "$UP" > /sys/devices/system/cpu/cpu4/cpufreq/ondemand/up_threshold
$B echo "$DN" > /sys/devices/system/cpu/cpu4/cpufreq/ondemand/down_differential
$B echo "$RT" > /sys/devices/system/cpu/cpu4/cpufreq/ondemand/sampling_rate
$B echo "$SF" > /sys/devices/system/cpu/cpu4/cpufreq/ondemand/sampling_down_factor
 if [ -e /sys/devices/system/cpu/cpu4/cpufreq/ondemand/powersave_bias ]; then
  $B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/ondemand/powersave_bias
  if [ "$MAX" -gt "1600000" ]; then
   $B echo "Powersave bias - on"
   $B echo "100" > /sys/devices/system/cpu/cpu4/cpufreq/ondemand/powersave_bias
  else
   $B echo "Powersave bias - off"
   $B echo "0" > /sys/devices/system/cpu/cpu4/cpufreq/ondemand/powersave_bias
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
 $B echo "$UP" > /sys/devices/system/cpu/cpufreq/sprdemand/up_threshold
 $B echo "$DN" > /sys/devices/system/cpu/cpufreq/sprdemand/down_differential
 $B echo "$RT" > /sys/devices/system/cpu/cpufreq/sprdemand/sampling_rate
 $B echo "1" > /sys/devices/system/cpu/cpufreq/sprdemand/io_is_busy
 $B echo "$SF" > /sys/devices/system/cpu/cpufreq/sprdemand/sampling_down_factor
 if [ -e /sys/devices/system/cpu/cpufreq/sprdemand/powersave_bias ]; then
  $B chmod 644 /sys/devices/system/cpu/cpufreq/sprdemand/powersave_bias
  if [ "$MAX" -gt "1600000" ]; then
   $B echo "Powersave bias - on"
   $B echo "100" > /sys/devices/system/cpu/cpufreq/sprdemand/powersave_bias
  else
   $B echo "Powersave bias - off"
   $B echo "0" > /sys/devices/system/cpu/cpufreq/sprdemand/powersave_bias
  fi;
 fi;
fi;
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/sprdemand/up_threshold ]; then
 $B echo "CPU0 sprdemand tuning.."
 $B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/sprdemand/up_threshold
 $B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/sprdemand/sampling_rate
 $B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/sprdemand/down_differential
 $B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/sprdemand/io_is_busy
 $B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/sprdemand/sampling_down_factor
 $B echo "$UP" > /sys/devices/system/cpu/cpu0/cpufreq/sprdemand/up_threshold
 $B echo "$DN" > /sys/devices/system/cpu/cpu0/cpufreq/sprdemand/down_differential
 $B echo "$RT" > /sys/devices/system/cpu/cpu0/cpufreq/sprdemand/sampling_rate
 $B echo "1" > /sys/devices/system/cpu/cpu0/cpufreq/sprdemand/io_is_busy
 $B echo "$SF" > /sys/devices/system/cpu/cpu0/cpufreq/sprdemand/sampling_down_factor
 if [ -e /sys/devices/system/cpu/cpu0/cpufreq/sprdemand/powersave_bias ]; then
  $B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/sprdemand/powersave_bias
  if [ "$MAX" -gt "1600000" ]; then
   $B echo "Powersave bias - on"
   $B echo "100" > /sys/devices/system/cpu/cpu0/cpufreq/sprdemand/powersave_bias
  else
   $B echo "Powersave bias - off"
   $B echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/sprdemand/powersave_bias
  fi;
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
$B echo "$UP" > /sys/devices/system/cpu/cpufreq/smartassH3/max_cpu_load
$B echo "$DN" > /sys/devices/system/cpu/cpufreq/smartassH3/min_cpu_load
$B echo "$RT" > /sys/devices/system/cpu/cpufreq/smartassH3/up_rate_us
$B echo "$RT" > /sys/devices/system/cpu/cpufreq/smartassH3/down_rate_us
$B echo "$SF" > /sys/devices/system/cpu/cpufreq/smartassH3/sample_rate_jiffies
 if [ -e /sys/devices/system/cpu/cpufreq/smartassH3/boost_enabled ]; then
  $B echo "Boost-pulse - on"
  $B chmod 644 /sys/devices/system/cpu/cpufreq/smartassH3/boost_pulse
  $B chmod 644 /sys/devices/system/cpu/cpufreq/smartassH3/boost_enabled
  $B echo "1" > /sys/devices/system/cpu/cpufreq/smartassH3/boost_enabled
  $B echo "3000000" > /sys/devices/system/cpu/cpufreq/smartassH3/boost_pulse
 fi;
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
$B echo "$UP" > /sys/devices/system/cpu/cpu0/cpufreq/smartassH3/max_cpu_load
$B echo "$DN" > /sys/devices/system/cpu/cpu0/cpufreq/smartassH3/min_cpu_load
$B echo "$RT" > /sys/devices/system/cpu/cpu0/cpufreq/smartassH3/up_rate_us
$B echo "$RT" > /sys/devices/system/cpu/cpu0/cpufreq/smartassH3/down_rate_us
$B echo "$SF" > /sys/devices/system/cpu/cpu0/cpufreq/smartassH3/sample_rate_jiffies
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
if [ -e /sys/devices/system/cpu/cpu4/cpufreq/smartassH3/sample_rate_jiffies ]; then
$B echo "CPU4 SmartassH3 tuning.."
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/smartassH3/debug_mask
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/smartassH3/ramp_up_step
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/smartassH3/ramp_down_step
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/smartassH3/max_cpu_load
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/smartassH3/min_cpu_load
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/smartassH3/up_rate_us
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/smartassH3/down_rate_us
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/smartassH3/sample_rate_jiffies
$B echo "0" > /sys/devices/system/cpu/cpu4/cpufreq/smartassH3/debug_mask
$B echo "192000" > /sys/devices/system/cpu/cpu4/cpufreq/smartassH3/ramp_up_step
$B echo "192000" > /sys/devices/system/cpu/cpu4/cpufreq/smartassH3/ramp_down_step
$B echo "$UP" > /sys/devices/system/cpu/cpu4/cpufreq/smartassH3/max_cpu_load
$B echo "$DN" > /sys/devices/system/cpu/cpu4/cpufreq/smartassH3/min_cpu_load
$B echo "$RT" > /sys/devices/system/cpu/cpu4/cpufreq/smartassH3/up_rate_us
$B echo "$RT" > /sys/devices/system/cpu/cpu4/cpufreq/smartassH3/down_rate_us
$B echo "$SF" > /sys/devices/system/cpu/cpu4/cpufreq/smartassH3/sample_rate_jiffies
 if [ -e /sys/devices/system/cpu/cpu4/cpufreq/smartassH3/boost_enabled ]; then
  $B echo "Boost-pulse - on"
  $B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/smartassH3/boost_pulse
  $B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/smartassH3/boost_enabled
  $B echo "1" > /sys/devices/system/cpu/cpu4/cpufreq/smartassH3/boost_enabled
  $B echo "3000000" > /sys/devices/system/cpu/cpu4/cpufreq/smartassH3/boost_pulse
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
$B echo "$UP" > /sys/devices/system/cpu/cpufreq/smartassV2/max_cpu_load
$B echo "$DN" > /sys/devices/system/cpu/cpufreq/smartassV2/min_cpu_load
$B echo "$RT" > /sys/devices/system/cpu/cpufreq/smartassV2/up_rate_us
$B echo "$RT" > /sys/devices/system/cpu/cpufreq/smartassV2/down_rate_us
$B echo "$SF" > /sys/devices/system/cpu/cpufreq/smartassV2/sample_rate_jiffies
fi;
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/smartassV2/sample_rate_jiffies ]; then
$B echo "CPU0 SmartassV2 tuning.."
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/smartassV2/debug_mask
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/smartassV2/ramp_up_step
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/smartassV2/ramp_down_step
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/smartassV2/max_cpu_load
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/smartassV2/min_cpu_load
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/smartassV2/up_rate_us
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/smartassV2/down_rate_us
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/smartassV2/sample_rate_jiffies
$B echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/smartassV2/debug_mask
$B echo "192000" > /sys/devices/system/cpu/cpu0/cpufreq/smartassV2/ramp_up_step
$B echo "192000" > /sys/devices/system/cpu/cpu0/cpufreq/smartassV2/ramp_down_step
$B echo "$UP" > /sys/devices/system/cpu/cpu0/cpufreq/smartassV2/max_cpu_load
$B echo "$DN" > /sys/devices/system/cpu/cpu0/cpufreq/smartassV2/min_cpu_load
$B echo "$RT" > /sys/devices/system/cpu/cpu0/cpufreq/smartassV2/up_rate_us
$B echo "$RT" > /sys/devices/system/cpu/cpu0/cpufreq/smartassV2/down_rate_us
$B echo "$SF" > /sys/devices/system/cpu/cpu0/cpufreq/smartassV2/sample_rate_jiffies
fi;
if [ -e /sys/devices/system/cpu/cpu4/cpufreq/smartassV2/sample_rate_jiffies ]; then
$B echo "CPU4 SmartassV2 tuning.."
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/smartassV2/debug_mask
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/smartassV2/ramp_up_step
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/smartassV2/ramp_down_step
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/smartassV2/max_cpu_load
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/smartassV2/min_cpu_load
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/smartassV2/up_rate_us
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/smartassV2/down_rate_us
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/smartassV2/sample_rate_jiffies
$B echo "0" > /sys/devices/system/cpu/cpu4/cpufreq/smartassV2/debug_mask
$B echo "192000" > /sys/devices/system/cpu/cpu4/cpufreq/smartassV2/ramp_up_step
$B echo "192000" > /sys/devices/system/cpu/cpu4/cpufreq/smartassV2/ramp_down_step
$B echo "$UP" > /sys/devices/system/cpu/cpu4/cpufreq/smartassV2/max_cpu_load
$B echo "$DN" > /sys/devices/system/cpu/cpu4/cpufreq/smartassV2/min_cpu_load
$B echo "$RT" > /sys/devices/system/cpu/cpu4/cpufreq/smartassV2/up_rate_us
$B echo "$RT" > /sys/devices/system/cpu/cpu4/cpufreq/smartassV2/down_rate_us
$B echo "$SF" > /sys/devices/system/cpu/cpu4/cpufreq/smartassV2/sample_rate_jiffies
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
$B echo "$UP" > /sys/devices/system/cpu/cpufreq/smartass/max_cpu_load
$B echo "$DN" > /sys/devices/system/cpu/cpufreq/smartass/min_cpu_load
$B echo "$RT" > /sys/devices/system/cpu/cpufreq/smartass/up_rate_us
$B echo "$RT" > /sys/devices/system/cpu/cpufreq/smartass/down_rate_us
$B echo "$SF" > /sys/devices/system/cpu/cpufreq/smartass/sample_rate_jiffies
fi;
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/smartass/sample_rate_jiffies ]; then
$B echo "CPU0 Smartass tuning.."
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/smartass/debug_mask
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/smartass/ramp_up_step
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/smartass/ramp_down_step
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/smartass/max_cpu_load
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/smartass/min_cpu_load
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/smartass/up_rate_us
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/smartass/down_rate_us
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/smartass/sample_rate_jiffies
$B echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/smartass/debug_mask
$B echo "192000" > /sys/devices/system/cpu/cpu0/cpufreq/smartass/ramp_up_step
$B echo "192000" > /sys/devices/system/cpu/cpu0/cpufreq/smartass/ramp_down_step
$B echo "$UP" > /sys/devices/system/cpu/cpu0/cpufreq/smartass/max_cpu_load
$B echo "$DN" > /sys/devices/system/cpu/cpu0/cpufreq/smartass/min_cpu_load
$B echo "$RT" > /sys/devices/system/cpu/cpu0/cpufreq/smartass/up_rate_us
$B echo "$RT" > /sys/devices/system/cpu/cpu0/cpufreq/smartass/down_rate_us
$B echo "$SF" > /sys/devices/system/cpu/cpu0/cpufreq/smartass/sample_rate_jiffies
fi;
if [ -e /sys/devices/system/cpu/cpu4/cpufreq/smartass/sample_rate_jiffies ]; then
$B echo "CPU4 Smartass tuning.."
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/smartass/debug_mask
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/smartass/ramp_up_step
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/smartass/ramp_down_step
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/smartass/max_cpu_load
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/smartass/min_cpu_load
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/smartass/up_rate_us
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/smartass/down_rate_us
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/smartass/sample_rate_jiffies
$B echo "0" > /sys/devices/system/cpu/cpu4/cpufreq/smartass/debug_mask
$B echo "192000" > /sys/devices/system/cpu/cpu4/cpufreq/smartass/ramp_up_step
$B echo "192000" > /sys/devices/system/cpu/cpu4/cpufreq/smartass/ramp_down_step
$B echo "$UP" > /sys/devices/system/cpu/cpu4/cpufreq/smartass/max_cpu_load
$B echo "$DN" > /sys/devices/system/cpu/cpu4/cpufreq/smartass/min_cpu_load
$B echo "$RT" > /sys/devices/system/cpu/cpu4/cpufreq/smartass/up_rate_us
$B echo "$RT" > /sys/devices/system/cpu/cpu4/cpufreq/smartass/down_rate_us
$B echo "$SF" > /sys/devices/system/cpu/cpu4/cpufreq/smartass/sample_rate_jiffies
fi;
if [ -e /sys/devices/system/cpu/cpufreq/interactive/min_sample_time ]; then
$B echo "CPU Interactive tuning.."
$B chmod 644 /sys/devices/system/cpu/cpufreq/interactive/go_highspeed_load
$B chmod 644 /sys/devices/system/cpu/cpufreq/interactive/go_maxspeed_load
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time ]; then
$B echo "CPU0 Interactive tuning.."
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_highspeed_load
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
$B echo "$UP" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_highspeed_load
$B echo "1" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
fi;
if [ -e /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time ]; then
$B echo "CPU4 Interactive tuning.."
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_highspeed_load
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
$B echo "$UP" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_highspeed_load
$B echo "1" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
fi;
if [ -e /sys/devices/system/cpu/cpufreq/interactivex/min_sample_time ]; then
$B echo "CPU InteractiveX tuning.."
$B chmod 644 /sys/devices/system/cpu/cpufreq/interactivex/go_highspeed_load
$B chmod 644 /sys/devices/system/cpu/cpufreq/interactivex/io_is_busy
$B echo "$UP" > /sys/devices/system/cpu/cpufreq/interactivex/go_highspeed_load
$B echo "1" > /sys/devices/system/cpu/cpufreq/interactivex/io_is_busy
fi;
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/interactivex/min_sample_time ]; then
$B echo "CPU0 InteractiveX tuning.."
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactivex/go_highspeed_load
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactivex/io_is_busy
$B echo "$UP" > /sys/devices/system/cpu/cpu0/cpufreq/interactivex/go_highspeed_load
$B echo "1" > /sys/devices/system/cpu/cpu0/cpufreq/interactivex/io_is_busy
fi;
if [ -e /sys/devices/system/cpu/cpu4/cpufreq/interactivex/min_sample_time ]; then
$B echo "CPU4 InteractiveX tuning.."
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactivex/go_highspeed_load
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactivex/io_is_busy
$B echo "$UP" > /sys/devices/system/cpu/cpu4/cpufreq/interactivex/go_highspeed_load
$B echo "1" > /sys/devices/system/cpu/cpu4/cpufreq/interactivex/io_is_busy
fi;
if [ -e /sys/devices/system/cpu/cpufreq/pegasusq/up_threshold ]; then
$B echo "CPU Pegasusq tuning.."
$B chmod 644 /sys/devices/system/cpu/cpufreq/pegasusq/up_threshold
$B chmod 644 /sys/devices/system/cpu/cpufreq/pegasusq/down_differential
$B chmod 644 /sys/devices/system/cpu/cpufreq/pegasusq/sampling_down_factor
$B chmod 644 /sys/devices/system/cpu/cpufreq/pegasusq/io_is_busy
$B chmod 644 /sys/devices/system/cpu/cpufreq/pegasusq/sampling_rate
$B chmod 644 /sys/devices/system/cpu/cpufreq/pegasusq/freq_step
$B echo "$UP" > /sys/devices/system/cpu/cpufreq/pegasusq/up_threshold
$B echo "$DN" > /sys/devices/system/cpu/cpufreq/pegasusq/down_differential
$B echo "$SF" > /sys/devices/system/cpu/cpufreq/pegasusq/sampling_down_factor
$B echo "1" > /sys/devices/system/cpu/cpufreq/pegasusq/io_is_busy
$B echo "$RT" > /sys/devices/system/cpu/cpufreq/pegasusq/sampling_rate
$B echo "100" > /sys/devices/system/cpu/cpufreq/pegasusq/freq_step
fi;
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/pegasusq/up_threshold ]; then
$B echo "CPU0 Pegasusq tuning.."
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/pegasusq/up_threshold
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/pegasusq/down_differential
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/pegasusq/sampling_down_factor
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/pegasusq/io_is_busy
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/pegasusq/sampling_rate
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/pegasusq/freq_step
$B echo "$UP" > /sys/devices/system/cpu/cpu0/cpufreq/pegasusq/up_threshold
$B echo "$DN" > /sys/devices/system/cpu/cpu0/cpufreq/pegasusq/down_differential
$B echo "$SF" > /sys/devices/system/cpu/cpu0/cpufreq/pegasusq/sampling_down_factor
$B echo "1" > /sys/devices/system/cpu/cpu0/cpufreq/pegasusq/io_is_busy
$B echo "$RT" > /sys/devices/system/cpu/cpu0/cpufreq/pegasusq/sampling_rate
$B echo "100" > /sys/devices/system/cpu/cpu0/cpufreq/pegasusq/freq_step
fi;
if [ -e /sys/devices/system/cpu/cpu4/cpufreq/pegasusq/up_threshold ]; then
$B echo "CPU4 Pegasusq tuning.."
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/pegasusq/up_threshold
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/pegasusq/down_differential
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/pegasusq/io_is_busy
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/pegasusq/sampling_rate
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/pegasusq/freq_step
$B echo "$UP" > /sys/devices/system/cpu/cpu4/cpufreq/pegasusq/up_threshold
$B echo "$DN" > /sys/devices/system/cpu/cpu4/cpufreq/pegasusq/down_differential
$B echo "1" > /sys/devices/system/cpu/cpu4/cpufreq/pegasusq/io_is_busy
$B echo "$RT" > /sys/devices/system/cpu/cpu4/cpufreq/pegasusq/sampling_rate
$B echo "100" > /sys/devices/system/cpu/cpu4/cpufreq/pegasusq/freq_step
fi;
if [ -e /sys/devices/system/cpu/cpufreq/lulzactive/up_sample_time ]; then
$B echo "CPU Lulzactive tuning.."
$B chmod 644 /sys/devices/system/cpu/cpufreq/lulzactive/inc_cpu_load
$B echo "$UP" > /sys/devices/system/cpu/cpufreq/lulzactive/inc_cpu_load
fi;
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/lulzactive/up_sample_time ]; then
$B echo "CPU0 Lulzactive tuning.."
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/lulzactive/inc_cpu_load
$B echo "$UP" > /sys/devices/system/cpu/cpu0/cpufreq/lulzactive/inc_cpu_load
fi;
if [ -e /sys/devices/system/cpu/cpu4/cpufreq/lulzactive/up_sample_time ]; then
$B echo "CPU4 Lulzactive tuning.."
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/lulzactive/inc_cpu_load
$B echo "$UP" > /sys/devices/system/cpu/cpu4/cpufreq/lulzactive/inc_cpu_load
fi;
if [ -e /sys/devices/system/cpu/cpufreq/conservative/up_threshold ]; then
$B echo "CPU Conservative tuning.."
$B chmod 644 /sys/devices/system/cpu/cpufreq/conservative/up_threshold
$B chmod 644 /sys/devices/system/cpu/cpufreq/conservative/sampling_rate
$B chmod 644 /sys/devices/system/cpu/cpufreq/conservative/down_threshold
$B chmod 644 /sys/devices/system/cpu/cpufreq/conservative/freq_step
$B echo "$UP" > /sys/devices/system/cpu/cpufreq/conservative/up_threshold
$B echo "$RT" > /sys/devices/system/cpu/cpufreq/conservative/sampling_rate
$B echo "$DN" > /sys/devices/system/cpu/cpufreq/conservative/down_threshold
$B echo "25" > /sys/devices/system/cpu/cpufreq/conservative/freq_step
fi;
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/conservative/up_threshold ]; then
$B echo "CPU0 Conservative tuning.."
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/conservative/up_threshold
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/conservative/sampling_rate
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/conservative/down_threshold
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/conservative/freq_step
$B echo "$UP" > /sys/devices/system/cpu/cpu0/cpufreq/conservative/up_threshold
$B echo "$RT" > /sys/devices/system/cpu/cpu0/cpufreq/conservative/sampling_rate
$B echo "$DN" > /sys/devices/system/cpu/cpu0/cpufreq/conservative/down_threshold
$B echo "25" > /sys/devices/system/cpu/cpu0/cpufreq/conservative/freq_step
fi;
if [ -e /sys/devices/system/cpu/cpu4/cpufreq/conservative/up_threshold ]; then
$B echo "CPU4 Conservative tuning.."
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/conservative/up_threshold
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/conservative/sampling_rate
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/conservative/down_threshold
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/conservative/freq_step
$B echo "$UP" > /sys/devices/system/cpu/cpu4/cpufreq/conservative/up_threshold
$B echo "$RT" > /sys/devices/system/cpu/cpu4/cpufreq/conservative/sampling_rate
$B echo "$DN" > /sys/devices/system/cpu/cpu4/cpufreq/conservative/down_threshold
$B echo "25" > /sys/devices/system/cpu/cpu4/cpufreq/conservative/freq_step
fi;
if [ -e /sys/devices/system/cpu/cpufreq/intellidemand/up_threshold ]; then
$B echo "CPU Intellidemand tuning.."
$B chmod 644 /sys/devices/system/cpu/cpufreq/intellidemand/up_threshold
$B chmod 644 /sys/devices/system/cpu/cpufreq/intellidemand/down_differential
$B echo "$UP" > /sys/devices/system/cpu/cpufreq/intellidemand/up_threshold
$B echo "$DN" > /sys/devices/system/cpu/cpufreq/intellidemand/down_differential
fi;
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/intellidemand/up_threshold ]; then
$B echo "CPU0 Intellidemand tuning.."
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/intellidemand/up_threshold
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/intellidemand/down_differential
$B echo "$UP" > /sys/devices/system/cpu/cpu0/cpufreq/intellidemand/up_threshold
$B echo "$DN" > /sys/devices/system/cpu/cpu0/cpufreq/intellidemand/down_differential
fi;
if [ -e /sys/devices/system/cpu/cpu4/cpufreq/intellidemand/up_threshold ]; then
$B echo "CPU4 Intellidemand tuning.."
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/intellidemand/up_threshold
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/intellidemand/down_differential
$B echo "$UP" > /sys/devices/system/cpu/cpu4/cpufreq/intellidemand/up_threshold
$B echo "$DN" > /sys/devices/system/cpu/cpu4/cpufreq/intellidemand/down_differential
fi;
if [ -e /sys/devices/system/cpu/cpufreq/neox/up_threshold ]; then
$B echo "CPU Neox tuning.."
$B chmod 644 /sys/devices/system/cpu/cpufreq/neox/up_threshold
$B chmod 644 /sys/devices/system/cpu/cpufreq/neox/down_differential
$B chmod 644 /sys/devices/system/cpu/cpufreq/neox/freq_step
$B echo "$UP" > /sys/devices/system/cpu/cpufreq/neox/up_threshold
$B echo "$DN" > /sys/devices/system/cpu/cpufreq/neox/down_differential
$B echo "100" > /sys/devices/system/cpu/cpufreq/neox/freq_step
fi;
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/neox/up_threshold ]; then
$B echo "CPU0 Neox tuning.."
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/neox/up_threshold
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/neox/down_differential
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/neox/freq_step
$B echo "$UP" > /sys/devices/system/cpu/cpu0/cpufreq/neox/up_threshold
$B echo "$DN" > /sys/devices/system/cpu/cpu0/cpufreq/neox/down_differential
$B echo "100" > /sys/devices/system/cpu/cpu0/cpufreq/neox/freq_step
fi;
if [ -e /sys/devices/system/cpu/cpu4/cpufreq/neox/up_threshold ]; then
$B echo "CPU4 Neox tuning.."
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/neox/up_threshold
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/neox/down_differential
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/neox/freq_step
$B echo "$UP" > /sys/devices/system/cpu/cpu4/cpufreq/neox/up_threshold
$B echo "$DN" > /sys/devices/system/cpu/cpu4/cpufreq/neox/down_differential
$B echo "100" > /sys/devices/system/cpu/cpu4/cpufreq/neox/freq_step
fi;
if [ -e /sys/devices/system/cpu/cpufreq/hyper/up_threshold ]; then
$B echo "CPU Hyper tuning.."
$B chmod 644 /sys/devices/system/cpu/cpufreq/hyper/up_threshold
$B echo "$UP" > /sys/devices/system/cpu/cpufreq/hyper/up_threshold
fi;
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/hyper/up_threshold ]; then
$B echo "CPU0 Hyper tuning.."
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/hyper/up_threshold
$B echo "$UP" > /sys/devices/system/cpu/cpu0/cpufreq/hyper/up_threshold
fi;
if [ -e /sys/devices/system/cpu/cpu4/cpufreq/hyper/up_threshold ]; then
$B echo "CPU4 Hyper tuning.."
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/hyper/up_threshold
$B echo "$UP" > /sys/devices/system/cpu/cpu4/cpufreq/hyper/up_threshold
fi;
if [ -e /sys/devices/system/cpu/cpufreq/hotplug/up_threshold ]; then
$B echo "CPU Hotplug tuning.."
$B chmod 644 /sys/devices/system/cpu/cpufreq/hotplug/up_threshold
$B chmod 644 /sys/devices/system/cpu/cpufreq/hotplug/down_threshold
$B chmod 644 /sys/devices/system/cpu/cpufreq/hotplug/io_is_busy
$B chmod 644 /sys/devices/system/cpu/cpufreq/hotplug/sampling_rate
$B echo "$UP" > /sys/devices/system/cpu/cpufreq/hotplug/up_threshold
$B echo "$DN" > /sys/devices/system/cpu/cpufreq/hotplug/down_threshold
$B echo "1" > /sys/devices/system/cpu/cpufreq/hotplug/io_is_busy
$B echo "$RT" > /sys/devices/system/cpu/cpufreq/hotplug/sampling_rate
fi;
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/hotplug/up_threshold ]; then
$B echo "CPU0 Hotplug tuning.."
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/hotplug/up_threshold
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/hotplug/down_threshold
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/hotplug/io_is_busy
$B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/hotplug/sampling_rate
$B echo "$UP" > /sys/devices/system/cpu/cpu0/cpufreq/hotplug/up_threshold
$B echo "$DN" > /sys/devices/system/cpu/cpu0/cpufreq/hotplug/down_threshold
$B echo "1" > /sys/devices/system/cpu/cpu0/cpufreq/hotplug/io_is_busy
$B echo "$RT" > /sys/devices/system/cpu/cpu0/cpufreq/hotplug/sampling_rate
fi;
if [ -e /sys/devices/system/cpu/cpu4/cpufreq/hotplug/up_threshold ]; then
$B echo "CPU4 Hotplug tuning.."
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/hotplug/up_threshold
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/hotplug/down_threshold
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/hotplug/io_is_busy
$B chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/hotplug/sampling_rate
$B echo "$UP" > /sys/devices/system/cpu/cpu4/cpufreq/hotplug/up_threshold
$B echo "$DN" > /sys/devices/system/cpu/cpu4/cpufreq/hotplug/down_threshold
$B echo "1" > /sys/devices/system/cpu/cpu4/cpufreq/hotplug/io_is_busy
$B echo "$RT" > /sys/devices/system/cpu/cpu4/cpufreq/hotplug/sampling_rate
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
if [ -e /sys/module/cpuidle/parameters/enable_mask ]; then
 $B echo "Enabling AFTR + LPA.."
 $B chmod 644 /sys/module/cpuidle/parameters/enable_mask
 $B echo "3" > /sys/module/cpuidle/parameters/enable_mask
fi;
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/busfreq_static ]; then
 $B echo "Disabling static bus-freq.."
 $B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/busfreq_static
 $B echo "disabled" > /sys/devices/system/cpu/cpu0/cpufreq/busfreq_static
fi;
if [ -e /sys/devices/system/cpu/sched_mc_power_savings ]; then
 $B echo "Enabling Multi-core power-saving.."
 $B chmod 644 /sys/devices/system/cpu/sched_mc_power_savings
 $B echo "2" > /sys/devices/system/cpu/sched_mc_power_savings
fi;
if [ -e /proc/sys/abi/swp ]; then
 $B echo "SWP active.."
 $B echo "1" > /proc/sys/abi/swp
fi;
if [ -e /sys/devices/virtual/sec/sec_slow/io_is_busy ]; then
 $B echo "I/O is bz.."
 $B echo "1" > /sys/devices/virtual/sec/sec_slow/io_is_busy
fi;
if [ "$CORES" -le "3" ]; then
 if [ -e /sys/module/pm_hotplug/parameters/loadh ]; then
  $B echo "Tuning Dual-Core behavior.."
  $B echo "$UP" > /sys/module/pm_hotplug/parameters/loadh
  $B echo "$DN" > /sys/module/pm_hotplug/parameters/loadl
  $B echo "80" > /sys/module/pm_hotplug/parameters/loadh_scroff
  $B echo "35" > /sys/module/pm_hotplug/parameters/loadl_scroff
 fi;
 if [ -e /sys/devices/virtual/misc/second_core/hotplug_on ]; then 
  $B echo "Activating dynamic hot-plug.."
  $B echo "on" > /sys/devices/virtual/misc/second_core/hotplug_on
 fi;
 if [ -e /sys/devices/system/cpu/cpu0/cpufreq/smooth_target ]; then
  $B echo "Activating CPU smooth-target.." 
  $B echo "2" > /sys/devices/system/cpu/cpu0/cpufreq/smooth_target
  $B echo "2" > /sys/devices/system/cpu/cpu0/cpufreq/smooth_offset
  $B echo "2" > /sys/devices/system/cpu/cpu0/cpufreq/smooth_step
 fi;
fi;
if [ -e /dev/cpuctl/cpu.shares ]; then
 $B echo "62" > /dev/cpuctl/bg_non_interactive/cpu.shares
 CR=/dev/cpuctl
 $B mkdir $CR/native
 $B echo 150000 > $CR/native/cpu.rt_runtime_us
 for i in $(cat $CR/tasks); do
  $B echo "${i}" > $CR/native/tasks
 done;
 $B echo "CGroups tuned.."
fi;
if [ -e /sys/module/msm_thermal/core_control/enabled ]; then
 $B echo "Enable MSM thermal core now.."
 $B echo 1 > /sys/module/msm_thermal/core_control/enabled
fi;
$B echo "[$TIME] ***CPU gear*** - OK"
sync;
