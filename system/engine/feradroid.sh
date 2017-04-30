#!/system/bin/sh
### FeraDroid Engine v1.1 | By FeraVolt. 2017 ###
B=/system/engine/bin/busybox;
RAM=$($B free -m | $B awk '{ print $2 }' | $B sed -n 2p);
ROM=$(getprop ro.build.display.id);
SDK=$(getprop ro.build.version.sdk);
SF=$($B df -Ph /system | $B grep -v ^Filesystem | $B awk '{print $4}');
MAX=$($B cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq);
BIGMAX=$($B cat /sys/devices/system/cpu/cpu5/cpufreq/scaling_max_freq);
MIN=$($B cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq);
CUR=$($B cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq);
CORES=$($B grep -c 'processor' /proc/cpuinfo);
AXI=$($B cat /sys/power/cpufreq_max_axi_freq);
GPU=$(dumpsys SurfaceFlinger | $B grep "GLES:" | sed -e "s=GLES: ==");
ARCH=$($B grep -Eo "ro.product.cpu.abi(2)?=.+" /system/build.prop 2>/dev/null | $B grep -Eo "[^=]*$" | head -n1);
LOG=/sdcard/Android/FDE_log.txt;
BG=$((RAM/100));
if [ "$CORES" = "0" ]; then
 CORES=1;
fi;
setprop persist.added_boot_bgservices "$CORES";
setprop ro.config.max_starting_bg "$((CORES +1))";
setprop ro.sys.fw.bg_apps_limit "$BG";
$B sleep 81;
svc power stayon true;
setprop ro.feralab.engine 1.1;
$B rm -f $LOG;
$B touch $LOG;
if [ -e $LOG ]; then
 CONFIG=/sdcard/Android/FDE_config.txt;
else
 LOG=/data/media/0/Android/FDE_log.txt;
 CONFIG=/data/media/0/Android/FDE_config.txt;
fi;
$B rm -f $LOG;
$B touch $LOG;
$B chown 0:0 $LOG;
$B chown 0:0 $CONFIG;
$B chmod 666 $LOG;
$B chmod 666 $CONFIG;
if [ -e /engine.sh ]; then
 $B echo "50" > /sys/class/timed_output/vibrator/enable;
 $B echo "255" > /sys/class/leds/lv5219lg:rgb1:blue/brightness;
 $B echo "255" > /sys/class/leds/lv5219lg:rgb1:red/brightness;
 $B echo "255" > /sys/class/leds/lv5219lg:rgb1:green/brightness;
 $B sleep 0.3;
 $B echo "0" > /sys/class/leds/lv5219lg:rgb1:blue/brightness;
 $B echo "0" > /sys/class/leds/lv5219lg:rgb1:red/brightness;
 $B echo "0" > /sys/class/leds/lv5219lg:rgb1:green/brightness;
else
 $B echo "50" > /sys/devices/virtual/timed_output/vibrator/enable;
 am start -a android.intent.action.MAIN -e message "FDE v1.1 - firing up..." -n com.rja.utility/.ShowToast;
fi;
{
 $B echo "### FeraLab ###"
 $B echo "   "
 $B echo ">> FeraDroid Engine v1.1"
 $B echo ">> Firing up..."
 $B echo ">> Device: $(getprop ro.product.brand) $(getprop ro.product.model)"
 $B echo ">> Architecture: $ARCH"
 if [ -e /sys/devices/system/cpu/cpu5/cpufreq/scaling_max_freq ]; then
  $B echo ">> Max CPU freq: $((BIGMAX/1000))Mhz"
 else
  $B echo ">> Max CPU freq: $((MAX/1000))Mhz"
 fi;
 $B echo ">> Min CPU freq: $((MIN/1000))Mhz"
 $B echo ">> Current CPU freq: $((CUR/1000))Mhz"
 $B echo ">> CPU Cores online: $CORES"
 if [ -e /sys/power/cpufreq_max_axi_freq ]; then
  $B chmod 664 /sys/power/cpufreq_max_axi_freq
  $B echo ">> CPU max AXI freq: $AXI MHz"
 fi;
 $B echo ">> GPU: $GPU"
 $B echo ">> RAM: $RAM MB"
 $B echo ">> Kernel version: $KERNEL"
 $B echo ">> ROM version: $ROM"
 $B echo ">> Android version: $(getprop ro.build.version.release)"
 $B echo ">> SDK: $SDK"
 $B echo ">> SElinux state: $(getenforce)"
 $B echo ">> /system free space: $SF"
} >> $LOG;
service call activity 51 i32 0;
$B sleep 1;
$B echo ">> Mounting partitions RW.." >> $LOG;
$B mount -o remount,rw /data;
$B mount -o remount,rw /system;
$B mount -t debugfs debugfs /sys/kernel/debug;
$B mount -t debugfs none /sys/kernel/debug;
if [ -e /sbin/sysrw ]; then
 $B echo ">> Remapped partition layout detected." >> $LOG;
 /sbin/sysrw;
fi;
sync;
$B sleep 1;
$B echo ">> Correcting permissions.." >> $LOG;
$B chmod 644 /system/build.prop;
$B chmod -R 777 /cache/*;
$B chmod -R 777 /system/engine/*;
$B chmod 777 /system/engine/gears/*;
$B chmod 777 /system/engine/prop/*;
$B chmod 777 /system/engine/raw/*;
$B rm -f /system/etc/sysctl.conf;
$B touch /system/etc/sysctl.conf;
$B chmod 777 /system/etc/sysctl.conf;
if [ -e /system/engine/prop/firstboot ]; then
 $B echo ">> First boot after deploy" >> $LOG;
 $B rm -f /data/local/bootanimation.zip;
 $B rm -f $CONFIG;
 $B cp /system/engine/assets/FDE_config.txt $CONFIG;
fi;
if [ -e $CONFIG ]; then
 $B echo ">> Loading FDE_config..." >> $LOG;
 $B rm -f /system/engine/assets/FDE_config.txt;
 $B cp $CONFIG /system/engine/assets/FDE_config.txt;
fi;
if [ -e /sys/fs/selinux/enforce ]; then
 $B echo ">> Setting SElinux permissive..." >> $LOG;
 $B chmod 666 /sys/fs/selinux/enforce;
 setenforce 0;
 $B echo "0" > /sys/fs/selinux/enforce;
 $B chmod 444 /sys/fs/selinux/enforce;
fi;
if [ -e /system/engine/gears/dummy.sh ]; then
 DUMMY=$($B cat /system/engine/assets/FDE_config.txt | $B grep -e 'dummy=1');
 if [ "dummy=1" = "$DUMMY" ]; then
  $B echo "[$TIME] Running Dummy gear.." >> $LOG;
  /system/engine/gears/dummy.sh | $B tee -a $LOG;
 fi;
fi;
sync;
$B sleep 1;
if [ -e /system/engine/prop/firstboot ]; then
 $B mount -o remount,rw /system;
 if [ -e /sbin/sysrw ]; then
  /sbin/sysrw;
 fi;
 $B rm -f /system/engine/prop/firstboot;
 $B echo ">> First boot completed." >> $LOG;
fi;
if [ -e /engine.sh ]; then
 $B echo "96" > /sys/class/timed_output/vibrator/enable;
 $B echo "255" > /sys/class/leds/lv5219lg:rgb1:blue/brightness;
 $B echo "255" > /sys/class/leds/lv5219lg:rgb1:red/brightness;
 $B echo "255" > /sys/class/leds/lv5219lg:rgb1:green/brightness;
 $B sleep 0.3;
 $B echo "0" > /sys/class/leds/lv5219lg:rgb1:blue/brightness;
 $B echo "0" > /sys/class/leds/lv5219lg:rgb1:red/brightness;
 $B echo "0" > /sys/class/leds/lv5219lg:rgb1:green/brightness;
 $B sleep 0.3;
 $B echo "96" > /sys/class/timed_output/vibrator/enable;
 $B echo "255" > /sys/class/leds/lv5219lg:rgb1:blue/brightness;
 $B echo "255" > /sys/class/leds/lv5219lg:rgb1:red/brightness;
 $B echo "255" > /sys/class/leds/lv5219lg:rgb1:green/brightness;
 $B sleep 0.3;
 $B echo "0" > /sys/class/leds/lv5219lg:rgb1:blue/brightness;
 $B echo "0" > /sys/class/leds/lv5219lg:rgb1:red/brightness;
 $B echo "0" > /sys/class/leds/lv5219lg:rgb1:green/brightness;
 $B sleep 0.3;
 $B echo "96" > /sys/class/timed_output/vibrator/enable;
 $B echo "255" > /sys/class/leds/lv5219lg:rgb1:blue/brightness;
 $B echo "255" > /sys/class/leds/lv5219lg:rgb1:red/brightness;
 $B echo "255" > /sys/class/leds/lv5219lg:rgb1:green/brightness;
 $B sleep 0.3;
 $B echo "0" > /sys/class/leds/lv5219lg:rgb1:blue/brightness;
 $B echo "0" > /sys/class/leds/lv5219lg:rgb1:red/brightness;
 $B echo "0" > /sys/class/leds/lv5219lg:rgb1:green/brightness;
else
 $B echo "96" > /sys/devices/virtual/timed_output/vibrator/enable;
 $B sleep 0.3;
 $B echo "96" > /sys/devices/virtual/timed_output/vibrator/enable;
 $B sleep 0.3;
 $B echo "96" > /sys/devices/virtual/timed_output/vibrator/enable;
 am start -a android.intent.action.MAIN -e message "FDE status - OK" -n com.rja.utility/.ShowToast;
fi;
$B echo ">> FDE status - OK" >> $LOG;
$B echo "  " >> $LOG;
if [ -e /engine.sh ]; then
 $B run-parts /system/etc/init.d;
fi;
$B sleep 1;
$B mount -o remount,ro /system;
if [ -e /sbin/sysro ]; then
 /sbin/sysro;
fi;
am kill-all;
$B sleep 3;
service call activity 51 i32 "$BG";
if [ "$SDK" -lt "22" ]; then
 if [ -e /system/engine/gears/sleeper.sh ]; then
  svc power stayon false;
  /system/engine/gears/sleeper.sh &
 fi;
fi;
svc power stayon false;
