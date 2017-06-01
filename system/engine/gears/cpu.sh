#!/system/bin/sh
### FeraDroid Engine v1.1 | By FeraVolt. 2017 ###
B=/system/engine/bin/busybox;
SCORE=/system/engine/prop/score;
MADMAX=$($B cat /system/engine/raw/FDE_config.txt | $B grep -e 'mad_max=1');
MAX=$($B cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq);
MIN=$($B cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq);
CMAX=$($B cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq);
CMIN=$($B cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq);
CUR=$($B cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq);
CORES=$($B grep -c 'processor' /proc/cpuinfo);
$B echo "Current CPU freq: $((CUR/1000))Mhz";
if [ -e /sys/module/msm_thermal/core_control/enabled ]; then
 $B echo "Disabing MSM thermal core for now..";
 $B echo "0" > /sys/module/msm_thermal/core_control/enabled;
fi;
if [ -e /system/bin/mpdecision ]; then
 $B echo "Stop mpdecision for now..";
 stop mpdecision;
fi;
if [ -e /system/bin/thermald ]; then
 $B echo "Stop thermald.";
 stop thermald;
fi;
$B echo -n disable > /sys/devices/soc/soc:qcom,bcl/mode;
$B echo "1" >> $SCORE;
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq ]; then
 if [ "$CMIN" != "$MIN" ]; then
  $B echo "Underclocking your CPU to $((CMIN/1000))Mhz..";
  for a in 0 1 2 3 4 5 6 7; do
   $B chmod 644 /sys/devices/system/cpu/cpu$a/cpufreq/scaling_min_freq;
   $B echo "$CMIN" > /sys/devices/system/cpu/cpu$a/cpufreq/scaling_min_freq;
   $B echo "1" >> $SCORE;
  done;
 fi;
fi;
if [ "mad_max=1" = "$MADMAX" ]; then
 if [ -e /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq ]; then
  if [ "$CMAX" != "$MIN" ]; then
   $B echo "Mad CPU.";
   $B echo "Overclocking your CPU to $((CMAX/1000))Mhz..";
   for a in 0 1 2 3; do
    $B chmod 644 /sys/devices/system/cpu/cpu$a/cpufreq/scaling_max_freq;
    $B echo "$CMAX" > /sys/devices/system/cpu/cpu$a/cpufreq/scaling_max_freq;
    $B echo "1" >> $SCORE;
   done;
  fi;
 fi;
fi;
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/vdd_levels ]; then
 $B chown root system /sys/devices/system/cpu/cpu0/cpufreq/vdd_levels;
 $B chmod 664 /sys/devices/system/cpu/cpu0/cpufreq/vdd_levels;
 if [ -e /init.es209ra.rc ]; then
  $B echo "X10 CPU vdd..";
  $B echo "245760 950" > /sys/devices/system/cpu/cpu0/cpufreq/vdd_levels;
  $B echo "384000 950" > /sys/devices/system/cpu/cpu0/cpufreq/vdd_levels;
  $B echo "576000 1000" > /sys/devices/system/cpu/cpu0/cpufreq/vdd_levels;
  $B echo "768000 1100" > /sys/devices/system/cpu/cpu0/cpufreq/vdd_levels;
  $B echo "998400 1250" > /sys/devices/system/cpu/cpu0/cpufreq/vdd_levels;
  $B echo "1036800 1275" > /sys/devices/system/cpu/cpu0/cpufreq/vdd_levels;
  $B echo "1075200 1300" > /sys/devices/system/cpu/cpu0/cpufreq/vdd_levels;
  $B echo "1113600 1325" > /sys/devices/system/cpu/cpu0/cpufreq/vdd_levels;
  $B echo "1152000 1325" > /sys/devices/system/cpu/cpu0/cpufreq/vdd_levels;
  $B echo "1190400 1350" > /sys/devices/system/cpu/cpu0/cpufreq/vdd_levels;
  $B echo "1228800 1375" > /sys/devices/system/cpu/cpu0/cpufreq/vdd_levels;
  $B echo "1267200 1425" > /sys/devices/system/cpu/cpu0/cpufreq/vdd_levels;
  $B echo "1305600 1425" > /sys/devices/system/cpu/cpu0/cpufreq/vdd_levels;
  $B echo "Boosting Xperia X10..";
  $B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/*;
  $B echo "384000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq;
  $B echo "1190400" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq;
  $B echo "7" >> $SCORE;
 fi;
fi;
if [ -e /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy ]; then
 $B echo "CPU ondemand tuning..";
 $B chmod 644 /sys/devices/system/cpu/cpufreq/ondemand/*;
 $B echo "10000" > /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate;
 $B echo "1" > /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy;
 $B echo "3" > /sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor;
 $B echo "3" >> $SCORE;
 if [ -e /sys/devices/system/cpu/cpufreq/ondemand/powersave_bias ]; then
  $B echo "0" > /sys/devices/system/cpu/cpufreq/ondemand/powersave_bias;
  $B echo "1" >> $SCORE;
 fi;
fi;
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/ondemand/io_is_busy ]; then
 $B echo "CPU LITTLE cluster ondemand tuning..";
 for fg in 0 1 2 3; do
  $B chmod 644 /sys/devices/system/cpu/cpu$fg/cpufreq/ondemand/*;
  $B echo "10000" > /sys/devices/system/cpu/cpu$fg/cpufreq/ondemand/sampling_rate;
  $B echo "3" > /sys/devices/system/cpu/cpu$fg/cpufreq/ondemand/sampling_down_factor;
  $B echo "1" > /sys/devices/system/cpu/cpu$fg/cpufreq/ondemand/io_is_busy;
  $B echo "1" >> $SCORE;
  if [ -e /sys/devices/system/cpu/cpu0/cpufreq/ondemand/powersave_bias ]; then
   if [ "$MAX" -gt "2000000" ]; then
    $B echo "100" > /sys/devices/system/cpu/cpu$fg/cpufreq/ondemand/powersave_bias;
   else
    $B echo "0" > /sys/devices/system/cpu/cpu$fg/cpufreq/ondemand/powersave_bias;
   fi;
   $B echo "1" >> $SCORE;
  fi;
 done;
fi;
if [ -e /sys/devices/system/cpu/cpu4/cpufreq/ondemand/io_is_busy ]; then
 $B echo "CPU BIG cluster ondemand tuning..";
 for c in 4 5 6 7; do
  $B chmod 644 /sys/devices/system/cpu/cpu$c/cpufreq/ondemand/*;
  $B echo "10000" > /sys/devices/system/cpu/cpu$c/cpufreq/ondemand/sampling_rate;
  $B echo "3" > /sys/devices/system/cpu/cpu$c/cpufreq/ondemand/sampling_down_factor;
  $B echo "1" > /sys/devices/system/cpu/cpu$c/cpufreq/ondemand/io_is_busy;
  $B echo "1" >> $SCORE;
  if [ -e /sys/devices/system/cpu/cpu4/cpufreq/ondemand/powersave_bias ]; then
   if [ "$MAX" -gt "2000000" ]; then
    $B echo "100" > /sys/devices/system/cpu/cpu$c/cpufreq/ondemand/powersave_bias;
   else
    $B echo "0" > /sys/devices/system/cpu/cpu$c/cpufreq/ondemand/powersave_bias;
   fi;
   $B echo "1" >> $SCORE;
  fi;
 done;
fi;
if [ -e /sys/devices/system/cpu/cpufreq/ondemandx/io_is_busy ]; then
 $B echo "CPU ondemandx tuning..";
 $B chmod 644 /sys/devices/system/cpu/cpufreq/ondemandx/*;
 $B echo "10000" > /sys/devices/system/cpu/cpufreq/ondemandx/sampling_rate;
 $B echo "1" > /sys/devices/system/cpu/cpufreq/ondemandx/io_is_busy;
 $B echo "3" > /sys/devices/system/cpu/cpufreq/ondemandx/sampling_down_factor;
 $B echo "3" >> $SCORE;
 if [ -e /sys/devices/system/cpu/cpufreq/ondemandx/powersave_bias ]; then
  $B echo "0" > /sys/devices/system/cpu/cpufreq/ondemandx/powersave_bias;
  $B echo "1" >> $SCORE;
 fi;
fi;
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/ondemandx/io_is_busy ]; then
 $B echo "CPU LITTLE cluster ondemandx tuning..";
 for d in 0 1 2 3; do
  $B chmod 644 /sys/devices/system/cpu/cpu$d/cpufreq/ondemandx/*;
  $B echo "10000" > /sys/devices/system/cpu/cpu$d/cpufreq/ondemandx/sampling_rate;
  $B echo "3" > /sys/devices/system/cpu/cpu$d/cpufreq/ondemandx/sampling_down_factor;
  $B echo "1" > /sys/devices/system/cpu/cpu$d/cpufreq/ondemandx/io_is_busy;
  $B echo "1" >> $SCORE;
  if [ -e /sys/devices/system/cpu/cpu0/cpufreq/ondemandx/powersave_bias ]; then
   if [ "$MAX" -gt "2000000" ]; then
    $B echo "100" > /sys/devices/system/cpu/cpu$d/cpufreq/ondemandx/powersave_bias;
   else
    $B echo "0" > /sys/devices/system/cpu/cpu$d/cpufreq/ondemandx/powersave_bias;
   fi;
   $B echo "1" >> $SCORE;
  fi;
 done;
fi;
if [ -e /sys/devices/system/cpu/cpu4/cpufreq/ondemandx/io_is_busy ]; then
 $B echo "CPU BIG cluster ondemandx tuning..";
 for e in 4 5 6 7; do
  $B chmod 644 /sys/devices/system/cpu/cpu$e/cpufreq/ondemandx/*;
  $B echo "10000" > /sys/devices/system/cpu/cpu$e/cpufreq/ondemandx/sampling_rate;
  $B echo "3" > /sys/devices/system/cpu/cpu$e/cpufreq/ondemandx/sampling_down_factor;
  $B echo "1" > /sys/devices/system/cpu/cpu$e/cpufreq/ondemandx/io_is_busy;
  $B echo "1" >> $SCORE;
  if [ -e /sys/devices/system/cpu/cpu4/cpufreq/ondemandx/powersave_bias ]; then
   if [ "$MAX" -gt "2000000" ]; then
    $B echo "100" > /sys/devices/system/cpu/cpu$e/cpufreq/ondemandx/powersave_bias;
   else
    $B echo "0" > /sys/devices/system/cpu/cpu$e/cpufreq/ondemandx/powersave_bias;
   fi;
   $B echo "1" >> $SCORE;
  fi;
 done;
fi;
if [ -e /sys/devices/system/cpu/cpufreq/sprdemand/io_is_busy ]; then
 $B echo "CPU sprdemand tuning..";
 $B chmod 644 /sys/devices/system/cpu/cpufreq/sprdemand/*;
 $B echo "10000" > /sys/devices/system/cpu/cpufreq/sprdemand/sampling_rate;
 $B echo "1" > /sys/devices/system/cpu/cpufreq/sprdemand/io_is_busy;
 $B echo "3" > /sys/devices/system/cpu/cpufreq/sprdemand/sampling_down_factor;
 $B echo "3" >> $SCORE;
 if [ -e /sys/devices/system/cpu/cpufreq/sprdemand/powersave_bias ]; then
  $B echo "0" > /sys/devices/system/cpu/cpufreq/sprdemand/powersave_bias;
  $B echo "1" >> $SCORE;
 fi;
fi;
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/sprdemand/io_is_busy ]; then
 $B echo "CPU LITTLE cluster sprdemand tuning..";
 for f in 0 1 2 3; do
  $B chmod 644 /sys/devices/system/cpu/cpu$f/cpufreq/sprdemand/*;
  $B echo "10000" > /sys/devices/system/cpu/cpu$f/cpufreq/sprdemand/sampling_rate;
  $B echo "3" > /sys/devices/system/cpu/cpu$f/cpufreq/sprdemand/sampling_down_factor;
  $B echo "1" > /sys/devices/system/cpu/cpu$f/cpufreq/sprdemand/io_is_busy;
  $B echo "3" >> $SCORE;
  if [ -e /sys/devices/system/cpu/cpu0/cpufreq/sprdemand/powersave_bias ]; then
   $B echo "0" > /sys/devices/system/cpu/cpu$f/cpufreq/sprdemand/powersave_bias;
   $B echo "1" >> $SCORE;
  fi;
 done;
fi;
if [ -e /sys/devices/system/cpu/cpufreq/smartass/up_rate_us ]; then
 $B echo "CPU smartass tuning..";
 $B chmod 644 /sys/devices/system/cpu/cpufreq/smartass/*;
 $B echo "0" > /sys/devices/system/cpu/cpufreq/smartass/debug_mask;
 $B echo "192000" > /sys/devices/system/cpu/cpufreq/smartass/ramp_up_step;
 $B echo "192000" > /sys/devices/system/cpu/cpufreq/smartass/ramp_down_step;
 $B echo "10000" > /sys/devices/system/cpu/cpufreq/smartass/up_rate_us;
 $B echo "10000" > /sys/devices/system/cpu/cpufreq/smartass/down_rate_us;
 $B echo "2" > /sys/devices/system/cpu/cpufreq/smartass/sample_rate_jiffies;
 $B echo "5" >> $SCORE;
fi;
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/smartass/up_rate_us ]; then
 $B echo "CPU LITTLE cluster smartass tuning..";
 for g in 0 1 2 3; do
  $B chmod 644 /sys/devices/system/cpu/cpu$g/cpufreq/smartass/*;
  $B echo "0" > /sys/devices/system/cpu/cpu$g/cpufreq/smartass/debug_mask;
  $B echo "192000" > /sys/devices/system/cpu/cpu$g/cpufreq/smartass/ramp_up_step;
  $B echo "192000" > /sys/devices/system/cpu/cpu$g/cpufreq/smartass/ramp_down_step;
  $B echo "10000" > /sys/devices/system/cpu/cpu$g/cpufreq/smartass/up_rate_us;
  $B echo "10000" > /sys/devices/system/cpu/cpu$g/cpufreq/smartass/down_rate_us;
  $B echo "2" > /sys/devices/system/cpu/cpu$g/cpufreq/smartass/sample_rate_jiffies;
  $B echo "5" >> $SCORE;
 done;
fi;
if [ -e /sys/devices/system/cpu/cpu4/cpufreq/smartass/up_rate_us ]; then
 $B echo "CPU BIG cluster smartass tuning..";
 for h in 4 5 6 7; do
  $B chmod 644 /sys/devices/system/cpu/cpu$h/cpufreq/smartass/*;
  $B echo "0" > /sys/devices/system/cpu/cpu$h/cpufreq/smartass/debug_mask;
  $B echo "192000" > /sys/devices/system/cpu/cpu$h/cpufreq/smartass/ramp_up_step;
  $B echo "192000" > /sys/devices/system/cpu/cpu$h/cpufreq/smartass/ramp_down_step;
  $B echo "10000" > /sys/devices/system/cpu/cpu$h/cpufreq/smartass/up_rate_us;
  $B echo "10000" > /sys/devices/system/cpu/cpu$h/cpufreq/smartass/down_rate_us;
  $B echo "2" > /sys/devices/system/cpu/cpu$h/cpufreq/smartass/sample_rate_jiffies;
  $B echo "5" >> $SCORE;
 done;
fi;
if [ -e /sys/devices/system/cpu/cpufreq/smartassV2/up_rate_us ]; then
 $B echo "CPU smartassV2 tuning..";
 $B chmod 644 /sys/devices/system/cpu/cpufreq/smartassV2/*;
 $B echo "0" > /sys/devices/system/cpu/cpufreq/smartassV2/debug_mask;
 $B echo "192000" > /sys/devices/system/cpu/cpufreq/smartassV2/ramp_up_step;
 $B echo "192000" > /sys/devices/system/cpu/cpufreq/smartassV2/ramp_down_step;
 $B echo "10000" > /sys/devices/system/cpu/cpufreq/smartassV2/up_rate_us;
 $B echo "10000" > /sys/devices/system/cpu/cpufreq/smartassV2/down_rate_us;
 $B echo "2" > /sys/devices/system/cpu/cpufreq/smartassV2/sample_rate_jiffies;
 $B echo "5" >> $SCORE;
fi;
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/smartassV2/up_rate_us ]; then
 $B echo "CPU LITTLE cluster smartassV2 tuning..";
 for j in 0 1 2 3; do
  $B chmod 644 /sys/devices/system/cpu/cpu$j/cpufreq/smartassV2/*;
  $B echo "0" > /sys/devices/system/cpu/cpu$j/cpufreq/smartassV2/debug_mask;
  $B echo "192000" > /sys/devices/system/cpu/cpu$j/cpufreq/smartassV2/ramp_up_step;
  $B echo "192000" > /sys/devices/system/cpu/cpu$j/cpufreq/smartassV2/ramp_down_step;
  $B echo "10000" > /sys/devices/system/cpu/cpu$j/cpufreq/smartassV2/up_rate_us;
  $B echo "10000" > /sys/devices/system/cpu/cpu$j/cpufreq/smartassV2/down_rate_us;
  $B echo "2" > /sys/devices/system/cpu/cpu$j/cpufreq/smartassV2/sample_rate_jiffies;
  $B echo "5" >> $SCORE;
 done;
fi;
if [ -e /sys/devices/system/cpu/cpu4/cpufreq/smartassV2/up_rate_us ]; then
 $B echo "CPU BIG cluster smartassV2 tuning..";
 for k in 4 5 6 7; do
  $B chmod 644 /sys/devices/system/cpu/cpu$k/cpufreq/smartassV2/*;
  $B echo "0" > /sys/devices/system/cpu/cpu$k/cpufreq/smartassV2/debug_mask;
  $B echo "192000" > /sys/devices/system/cpu/cpu$k/cpufreq/smartassV2/ramp_up_step;
  $B echo "192000" > /sys/devices/system/cpu/cpu$k/cpufreq/smartassV2/ramp_down_step;
  $B echo "10000" > /sys/devices/system/cpu/cpu$k/cpufreq/smartassV2/up_rate_us;
  $B echo "10000" > /sys/devices/system/cpu/cpu$k/cpufreq/smartassV2/down_rate_us;
  $B echo "2" > /sys/devices/system/cpu/cpu$k/cpufreq/smartassV2/sample_rate_jiffies;
  $B echo "5" >> $SCORE;
 done;
fi;
if [ -e /sys/devices/system/cpu/cpufreq/smartassH3/up_rate_us ]; then
 $B echo "CPU smartassH3 tuning..";
 $B chmod 644 /sys/devices/system/cpu/cpufreq/smartassH3/*;
 $B echo "0" > /sys/devices/system/cpu/cpufreq/smartassH3/debug_mask;
 $B echo "192000" > /sys/devices/system/cpu/cpufreq/smartassH3/ramp_up_step;
 $B echo "192000" > /sys/devices/system/cpu/cpufreq/smartassH3/ramp_down_step;
 $B echo "10000" > /sys/devices/system/cpu/cpufreq/smartassH3/up_rate_us;
 $B echo "10000" > /sys/devices/system/cpu/cpufreq/smartassH3/down_rate_us;
 $B echo "69" > /sys/devices/system/cpu/cpufreq/smartassH3/max_cpu_load;
 $B echo "18" > /sys/devices/system/cpu/cpufreq/smartassH3/min_cpu_load;
 $B echo "2" > /sys/devices/system/cpu/cpufreq/smartassH3/sample_rate_jiffies;
 $B echo "0" > /sys/devices/system/cpu/cpufreq/smartassH3/boost_enabled;
 $B echo "7" >> $SCORE;
fi;
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/smartassH3/up_rate_us ]; then
 $B echo "CPU LITTLE cluster smartassH3 tuning..";
 if [ -e /system/engine/prop/ferakernel ]; then
  $B echo "Smart X10 CPU..";
  $B echo "768000" > /sys/devices/system/cpu/cpu0/cpufreq/smartassH3/sleep_wakeup_freq;
  $B echo "998400" > /sys/devices/system/cpu/cpu0/cpufreq/smartassH3/awake_ideal_freq;
  $B echo "576000" > /sys/devices/system/cpu/cpu0/cpufreq/smartassH3/sleep_ideal_freq;
  $B echo "3" >> $SCORE;
 fi;
 for l in 0 1 2 3; do
  $B chmod 644 /sys/devices/system/cpu/cpu$l/cpufreq/smartassH3/*;
  $B echo "0" > /sys/devices/system/cpu/cpu$l/cpufreq/smartassH3/debug_mask;
  $B echo "192000" > /sys/devices/system/cpu/cpu$l/cpufreq/smartassH3/ramp_up_step;
  $B echo "192000" > /sys/devices/system/cpu/cpu$l/cpufreq/smartassH3/ramp_down_step;
  $B echo "10000" > /sys/devices/system/cpu/cpu$l/cpufreq/smartassH3/up_rate_us;
  $B echo "10000" > /sys/devices/system/cpu/cpu$l/cpufreq/smartassH3/down_rate_us;
  $B echo "69" > /sys/devices/system/cpu/cpu$l/cpufreq/smartassH3/max_cpu_load;
  $B echo "18" > /sys/devices/system/cpu/cpu$l/cpufreq/smartassH3/min_cpu_load;
  $B echo "2" > /sys/devices/system/cpu/cpu$l/cpufreq/smartassH3/sample_rate_jiffies;
  $B echo "7" >> $SCORE;
  if [ -e /sys/devices/system/cpu/cpu0/cpufreq/smartassH3/boost_enabled ]; then
   $B echo "1" > /sys/devices/system/cpu/cpu$l/cpufreq/smartassH3/boost_enabled;
   $B echo "3000000" > /sys/devices/system/cpu/cpu$l/cpufreq/smartassH3/boost_pulse;
   $B echo "1" >> $SCORE;
  fi;
 done;
fi;
if [ -e /sys/devices/system/cpu/cpu4/cpufreq/smartassH3/up_rate_us ]; then
 $B echo "CPU BIG cluster smartassH3 tuning..";
 for m in 4 5 6 7; do
  $B chmod 644 /sys/devices/system/cpu/cpu$m/cpufreq/smartassH3/*;
  $B echo "0" > /sys/devices/system/cpu/cpu$m/cpufreq/smartassH3/debug_mask;
  $B echo "192000" > /sys/devices/system/cpu/cpu$m/cpufreq/smartassH3/ramp_up_step;
  $B echo "192000" > /sys/devices/system/cpu/cpu$m/cpufreq/smartassH3/ramp_down_step;
  $B echo "10000" > /sys/devices/system/cpu/cpu$m/cpufreq/smartassH3/up_rate_us;
  $B echo "10000" > /sys/devices/system/cpu/cpu$m/cpufreq/smartassH3/down_rate_us;
  $B echo "69" > /sys/devices/system/cpu/cpu$m/cpufreq/smartassH3/max_cpu_load;
  $B echo "18" > /sys/devices/system/cpu/cpu$m/cpufreq/smartassH3/min_cpu_load;
  $B echo "2" > /sys/devices/system/cpu/cpu$m/cpufreq/smartassH3/sample_rate_jiffies;
  $B echo "7" >> $SCORE;
  if [ -e /sys/devices/system/cpu/cpu4/cpufreq/smartassH3/boost_enabled ]; then
   $B echo "1" > /sys/devices/system/cpu/cpu$m/cpufreq/smartassH3/boost_enabled;
   $B echo "3000000" > /sys/devices/system/cpu/cpu$m/cpufreq/smartassH3/boost_pulse;
   $B echo "1" >> $SCORE;
  fi;
 done;
fi;
if [ -e /sys/devices/system/cpu/cpufreq/interactive/min_sample_time ]; then
 $B echo "CPU interactive tuning..";
 $B chmod 644 /sys/devices/system/cpu/cpufreq/interactive/*;
 $B echo "1" > /sys/devices/system/cpu/cpufreq/interactive/io_is_busy;
 $B echo "1" > /sys/devices/system/cpu/cpufreq/interactive/use_shed_load;
 $B echo "1" > /sys/devices/system/cpu/cpufreq/interactive/use_migration_notif;
 $B echo "70000" > /sys/devices/system/cpu/cpufreq/interactive/min_sample_time;
 $B echo "25000" > /sys/devices/system/cpu/cpufreq/interactive/timer_rate;
 $B echo "5" >> $SCORE;
fi;
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time ]; then
 $B echo "CPU LITTLE cluster interactive tuning..";
 for o in 0 1 2 3; do
  $B chmod 644 /sys/devices/system/cpu/cpu$o/cpufreq/interactive/*;
  $B echo "1" > /sys/devices/system/cpu/cpu$o/cpufreq/interactive/io_is_busy;
  $B echo "1" > /sys/devices/system/cpu/cpu$o/cpufreq/interactive/use_shed_load;
  $B echo "1" > /sys/devices/system/cpu/cpu$o/cpufreq/interactive/use_migration_notif;
  $B echo "70000" > /sys/devices/system/cpu/cpu$o/cpufreq/interactive/min_sample_time;
  $B echo "25000" > /sys/devices/system/cpu/cpu$o/cpufreq/interactive/timer_rate;
  $B echo "5" >> $SCORE;
 done;
fi;
if [ -e /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time ]; then
 $B echo "CPU BIG cluster interactive tuning..";
 for p in 4 5 6 7; do
  $B chmod 644 /sys/devices/system/cpu/cpu$p/cpufreq/interactive/*;
  $B echo "1" > /sys/devices/system/cpu/cpu$p/cpufreq/interactive/io_is_busy;
  $B echo "1" > /sys/devices/system/cpu/cpu$p/cpufreq/interactive/use_shed_load;
  $B echo "1" > /sys/devices/system/cpu/cpu$p/cpufreq/interactive/use_migration_notif;
  $B echo "60000" > /sys/devices/system/cpu/cpu$p/cpufreq/interactive/min_sample_time;
  $B echo "15000" > /sys/devices/system/cpu/cpu$p/cpufreq/interactive/timer_rate;
  $B echo "5" >> $SCORE;
 done;
fi;
if [ -e /sys/devices/system/cpu/cpufreq/interactivex/min_sample_time ]; then
 $B echo "CPU interactivex tuning..";
 $B chmod 644 /sys/devices/system/cpu/cpufreq/interactivex/*;
 $B echo "1" > /sys/devices/system/cpu/cpufreq/interactivex/io_is_busy;
 $B echo "1" > /sys/devices/system/cpu/cpufreq/interactivex/use_shed_load;
 $B echo "1" > /sys/devices/system/cpu/cpufreq/interactivex/use_migration_notif;
 $B echo "70000" > /sys/devices/system/cpu/cpufreq/interactivex/min_sample_time;
 $B echo "25000" > /sys/devices/system/cpu/cpufreq/interactivex/timer_rate;
 $B echo "5" >> $SCORE;
fi;
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/interactivex/min_sample_time ]; then
 $B echo "CPU LITTLE cluster interactivex tuning..";
 for q in 0 1 2 3; do
  $B chmod 644 /sys/devices/system/cpu/cpu$q/cpufreq/interactivex/*;
  $B echo "1" > /sys/devices/system/cpu/cpu$q/cpufreq/interactivex/io_is_busy;
  $B echo "1" > /sys/devices/system/cpu/cpu$q/cpufreq/interactivex/use_shed_load;
  $B echo "1" > /sys/devices/system/cpu/cpu$q/cpufreq/interactivex/use_migration_notif;
  $B echo "70000" > /sys/devices/system/cpu/cpu$q/cpufreq/interactivex/min_sample_time;
  $B echo "25000" > /sys/devices/system/cpu/cpu$q/cpufreq/interactivex/timer_rate;
  $B echo "5" >> $SCORE;
 done;
fi;
if [ -e /sys/devices/system/cpu/cpu4/cpufreq/interactivex/min_sample_time ]; then
 $B echo "CPU BIG cluster interactivex tuning..";
 for r in 4 5 6 7; do
  $B chmod 644 /sys/devices/system/cpu/cpu$r/cpufreq/interactivex/*;
  $B echo "1" > /sys/devices/system/cpu/cpu$r/cpufreq/interactivex/io_is_busy;
  $B echo "1" > /sys/devices/system/cpu/cpu$r/cpufreq/interactivex/use_shed_load;
  $B echo "1" > /sys/devices/system/cpu/cpu$r/cpufreq/interactivex/use_migration_notif;
  $B echo "60000" > /sys/devices/system/cpu/cpu$r/cpufreq/interactivex/min_sample_time;
  $B echo "15000" > /sys/devices/system/cpu/cpu$r/cpufreq/interactivex/timer_rate;
  $B echo "5" >> $SCORE;
 done;
fi;
if [ -e /sys/devices/system/cpu/cpufreq/pegasusq/io_is_busy ]; then
 $B echo "CPU pegasusq tuning..";
 $B chmod 644 /sys/devices/system/cpu/cpufreq/pegasusq/*;
 $B echo "1" > /sys/devices/system/cpu/cpufreq/pegasusq/io_is_busy;
 $B echo "6" > /sys/devices/system/cpu/cpufreq/pegasusq/sampling_down_factor;
 $B echo "10000" > /sys/devices/system/cpu/cpufreq/pegasusq/sampling_rate;
 $B echo "3" >> $SCORE;
fi;
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/pegasusq/io_is_busy ]; then
 $B echo "CPU LITTLE cluster pegasusq tuning..";
 for s in 0 1 2 3; do
  $B chmod 644 /sys/devices/system/cpu/cpu$s/cpufreq/pegasusq/*;
  $B echo "1" > /sys/devices/system/cpu/cpu$s/cpufreq/pegasusq/io_is_busy;
  $B echo "6" > /sys/devices/system/cpu/cpu$s/cpufreq/pegasusq/sampling_down_factor;
  $B echo "10000" > /sys/devices/system/cpu/cpu$s/cpufreq/pegasusq/sampling_rate;
  $B echo "3" >> $SCORE;
 done;
fi;
if [ -e /sys/devices/system/cpu/cpu4/cpufreq/pegasusq/io_is_busy ]; then
 $B echo "CPU BIG cluster pegasusq tuning..";
 for t in 4 5 6 7; do
  $B chmod 644 /sys/devices/system/cpu/cpu$t/cpufreq/pegasusq/*;
  $B echo "1" > /sys/devices/system/cpu/cpu$t/cpufreq/pegasusq/io_is_busy;
  $B echo "6" > /sys/devices/system/cpu/cpu$t/cpufreq/pegasusq/sampling_down_factor;
  $B echo "10000" > /sys/devices/system/cpu/cpu$t/cpufreq/pegasusq/sampling_rate;
  $B echo "3" >> $SCORE;
 done;
fi;
if [ -e /sys/devices/system/cpu/cpufreq/lulzactive/inc_cpu_load ]; then
 $B echo "CPU lulzactive tuning..";
 $B chmod 644 /sys/devices/system/cpu/cpufreq/lulzactive/*;
 $B echo "85" > /sys/devices/system/cpu/cpufreq/lulzactive/inc_cpu_load;
 $B echo "1" >> $SCORE;
fi;
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/lulzactive/inc_cpu_load ]; then
 $B echo "CPU LITTLE cluster lulzactive tuning..";
 for u in 0 1 2 3; do
  $B chmod 644 /sys/devices/system/cpu/cpu$u/cpufreq/lulzactive/*;
  $B echo "85" > /sys/devices/system/cpu/cpu$u/cpufreq/lulzactive/inc_cpu_load;
  $B echo "1" >> $SCORE;
 done;
fi;
if [ -e /sys/devices/system/cpu/cpu4/cpufreq/lulzactive/inc_cpu_load ]; then
 $B echo "CPU BIG cluster lulzactive tuning..";
 for v in 4 5 6 7; do
  $B chmod 644 /sys/devices/system/cpu/cpu$v/cpufreq/lulzactive/*;
  $B echo "85" > /sys/devices/system/cpu/cpu$v/cpufreq/lulzactive/inc_cpu_load;
  $B echo "1" >> $SCORE;
 done;
fi;
if [ -e /sys/devices/system/cpu/cpufreq/conservative/sampling_rate ]; then
 $B echo "CPU conservative tuning..";
 $B chmod 644 /sys/devices/system/cpu/cpufreq/conservative/*;
 $B echo "10000" > /sys/devices/system/cpu/cpufreq/conservative/sampling_rate;
 $B echo "25" > /sys/devices/system/cpu/cpufreq/conservative/freq_step;
 $B echo "2" >> $SCORE;
fi;
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/conservative/sampling_rate ]; then
 $B echo "CPU LITTLE cluster conservative tuning..";
 for w in 0 1 2 3; do
  $B chmod 644 /sys/devices/system/cpu/cpu$w/cpufreq/conservative/*;
  $B echo "10000" > /sys/devices/system/cpu/cpu$w/cpufreq/conservative/sampling_rate;
  $B echo "25" > /sys/devices/system/cpu/cpu$w/cpufreq/conservative/freq_step;
  $B echo "2" >> $SCORE;
 done;
fi;
if [ -e /sys/devices/system/cpu/cpu4/cpufreq/conservative/sampling_rate ]; then
 $B echo "CPU BIG cluster conservative tuning..";
 for x in 4 5 6 7; do
  $B chmod 644 /sys/devices/system/cpu/cpu$x/cpufreq/conservative/*;
  $B echo "10000" > /sys/devices/system/cpu/cpu$x/cpufreq/conservative/sampling_rate;
  $B echo "25" > /sys/devices/system/cpu/cpu$x/cpufreq/conservative/freq_step;
  $B echo "2" >> $SCORE;
 done;
fi;
if [ -e /sys/devices/system/cpu/cpufreq/intellidemand/sampling_rate ]; then
 $B echo "CPU intellidemand tuning..";
 $B chmod 644 /sys/devices/system/cpu/cpufreq/intellidemand/*;
 $B echo "10000" > /sys/devices/system/cpu/cpufreq/intellidemand/sampling_rate;
 $B echo "1" >> $SCORE;
fi;
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/intellidemand/sampling_rate ]; then
 $B echo "CPU LITTLE cluster intellidemand tuning..";
 for y in 0 1 2 3; do
  $B chmod 644 /sys/devices/system/cpu/cpu$y/cpufreq/intellidemand/*;
  $B echo "10000" > /sys/devices/system/cpu/cpu$y/cpufreq/intellidemand/sampling_rate;
  $B echo "1" >> $SCORE;
 done;
fi;
if [ -e /sys/devices/system/cpu/cpu4/cpufreq/intellidemand/sampling_rate ]; then
 $B echo "CPU BIG cluster intellidemand tuning..";
 for z in 4 5 6 7; do
  $B chmod 644 /sys/devices/system/cpu/cpu$z/cpufreq/intellidemand/*;
  $B echo "10000" > /sys/devices/system/cpu/cpu$z/cpufreq/intellidemand/sampling_rate;
  $B echo "1" >> $SCORE;
 done;
fi;
if [ -e /sys/devices/system/cpu/cpufreq/neox/freq_step ]; then
 $B echo "CPU neox tuning..";
 $B chmod 644 /sys/devices/system/cpu/cpufreq/neox/*;
 $B echo "100" > /sys/devices/system/cpu/cpufreq/neox/freq_step;
 $B echo "1" >> $SCORE;
fi;
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/neox/freq_step ]; then
 $B echo "CPU LITTLE cluster neox tuning..";
 for ab in 0 1 2 3; do
  $B chmod 644 /sys/devices/system/cpu/cpu$ab/cpufreq/neox/*;
  $B echo "100" > /sys/devices/system/cpu/cpu$ab/cpufreq/neox/freq_step;
  $B echo "1" >> $SCORE;
 done;
fi;
if [ -e /sys/devices/system/cpu/cpu4/cpufreq/neox/freq_step ]; then
 $B echo "CPU BIG cluster neox tuning..";
 for bc in 4 5 6 7; do
  $B chmod 644 /sys/devices/system/cpu/cpu$bc/cpufreq/neox/*;
  $B echo "100" > /sys/devices/system/cpu/cpu$bc/cpufreq/neox/freq_step;
  $B echo "1" >> $SCORE;
 done;
fi;
if [ -e /sys/devices/system/cpu/cpufreq/hotplug/io_is_busy ]; then
 $B echo "CPU hotplug tuning..";
 $B chmod 644 /sys/devices/system/cpu/cpufreq/hotplug/*;
 $B echo "1" > /sys/devices/system/cpu/cpufreq/hotplug/io_is_busy;
 $B echo "10000" > /sys/devices/system/cpu/cpufreq/hotplug/sampling_rate;
 $B echo "2" >> $SCORE;
fi;
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/hotplug/io_is_busy ]; then
 $B echo "CPU LITTLE cluster hotplug tuning..";
 for de in 0 1 2 3; do
  $B chmod 644 /sys/devices/system/cpu/cpu$de/cpufreq/hotplug/*;
  $B echo "1" > /sys/devices/system/cpu/cpu$de/cpufreq/hotplug/io_is_busy;
  $B echo "10000" > /sys/devices/system/cpu/cpu$de/cpufreq/hotplug/sampling_rate;
  $B echo "2" >> $SCORE;
 done;
fi;
if [ -e /sys/devices/system/cpu/cpu4/cpufreq/hotplug/io_is_busy ]; then
 $B echo "CPU BIG cluster hotplug tuning..";
 for ef in 4 5 6 7; do
  $B chmod 644 /sys/devices/system/cpu/cpu$ef/cpufreq/hotplug/*;
  $B echo "1" > /sys/devices/system/cpu/cpu$ef/cpufreq/hotplug/io_is_busy;
  $B echo "10000" > /sys/devices/system/cpu/cpu$ef/cpufreq/hotplug/sampling_rate;
  $B echo "2" >> $SCORE;
 done;
fi;
if [ -e /sys/module/workqueue/parameters/power_efficient ]; then
 $B echo "Enabling power-save workqueues..";
 $B chmod 644 /sys/module/workqueue/parameters/power_efficient;
 $B echo "1" > /sys/module/workqueue/parameters/power_efficient;
 $B echo "Y" > /sys/module/workqueue/parameters/power_efficient;
 $B echo "1" >> $SCORE;
fi;
if [ -e /sys/module/subsystem_restart/parameters/enable_ramdumps ]; then
 $B echo "Disabling RAM-dumps..";
 $B chmod 644 /sys/module/subsystem_restart/parameters/enable_ramdumps;
 $B echo "0" > /sys/module/subsystem_restart/parameters/enable_ramdumps;
 $B echo "1" >> $SCORE;
fi;
if [ -e /sys/module/cpuidle/parameters/enable_mask ]; then
 $B echo "Enabling AFTR + LPA..";
 $B chmod 644 /sys/module/cpuidle/parameters/enable_mask;
 $B echo "3" > /sys/module/cpuidle/parameters/enable_mask;
 $B echo "1" >> $SCORE;
fi;
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/busfreq_static ]; then
 $B echo "Disabling static bus-freq..";
 $B chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/busfreq_static;
 $B echo "disabled" > /sys/devices/system/cpu/cpu0/cpufreq/busfreq_static;
 $B echo "1" >> $SCORE;
fi;
if [ -e /sys/devices/system/cpu/sched_mc_power_savings ]; then
 $B echo "Enabling Multi-core power-saving..";
 $B chmod 644 /sys/devices/system/cpu/sched_mc_power_savings;
 $B echo "2" > /sys/devices/system/cpu/sched_mc_power_savings;
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/abi/swp ]; then
 $B echo "Activating ARM8 SWP..";
 $B echo "1" > /proc/sys/abi/swp;
 $B echo "1" >> $SCORE;
fi;
if [ "$CORES" -le "4" ]; then
 if [ -e /sys/module/pm_hotplug/parameters/loadh ]; then
  $B echo "Tuning Dual-Core behavior..";
  $B echo "85" > /sys/module/pm_hotplug/parameters/loadh;
  $B echo "18" > /sys/module/pm_hotplug/parameters/loadl;
  $B echo "1" >> $SCORE;
 fi;
 if [ -e /sys/devices/virtual/misc/second_core/hotplug_on ]; then
  $B echo "Activating dynamic hot-plug..";
  $B echo "on" > /sys/devices/virtual/misc/second_core/hotplug_on;
  $B echo "1" >> $SCORE;
 fi;
 if [ -e /sys/devices/system/cpu/cpu0/cpufreq/smooth_target ]; then
  $B echo "Activating CPU smooth-target..";
  $B echo "2" > /sys/devices/system/cpu/cpu0/cpufreq/smooth_target;
  $B echo "2" > /sys/devices/system/cpu/cpu0/cpufreq/smooth_offset;
  $B echo "2" > /sys/devices/system/cpu/cpu0/cpufreq/smooth_step;
  $B echo "1" >> $SCORE;
 fi;
fi;
if [ -e /sys/module/msm_thermal/core_control/enabled ]; then
 $B echo "BIG-LITTLE scheduling tune-up..";
 $B echo "36" > /sys/devices/system/cpu/cpu4/core_ctl/busy_down_thres;
 $B echo "72" > /sys/devices/system/cpu/cpu4/core_ctl/busy_up_thres;
 $B echo "0" > /sys/devices/system/cpu/cpu4/core_ctl/offline_delay_ms;
 $B echo "1" >> $SCORE;
fi;
if [ -e /dev/cpuctl/bg_non_interactive/cpu.shares ]; then
 $B echo "192" > /dev/cpuctl/bg_non_interactive/cpu.shares
 $B echo "CPU backgound tune-up..";
 $B echo "1" >> $SCORE;
fi;
if [ -e /sys/module/msm_thermal/core_control/enabled ]; then
 $B echo "Enabling MSM thermal core & tuning it..";
 $B echo "1" > /sys/module/msm_thermal/core_control/enabled;
 $B echo "N" > /sys/module/msm_thermal/parameters/enabled;
fi;
if [ -e /system/bin/mpdecision ]; then
 $B echo "Start mpdecision now..";
 start mpdecision;
fi;
sync;
$B sleep 1;
