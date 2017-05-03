#!/system/bin/sh
### FeraDroid Engine v1.1 | By FeraVolt. 2017 ###
export PATH=/sbin:/system/sbin:/system/bin:/system/xbin:/system/engine/bin
B=/system/engine/bin/busybox;
RAM=$($B free -m | $B awk '{ print $2 }' | $B sed -n 2p);
ROM=$(getprop ro.build.display.id);
SDK=$(getprop ro.build.version.sdk);
MAX=$($B cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq);
MIN=$($B cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq);
CUR=$($B cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq);
CORES=$($B grep -c 'processor' /proc/cpuinfo);
GPU=$(dumpsys SurfaceFlinger | $B grep "GLES:" | sed -e "s=GLES: ==");
ARCH=$($B grep -Eo "ro.product.cpu.abi(2)?=.+" /system/build.prop 2>/dev/null | $B grep -Eo "[^=]*$" | head -n1);
if [ -e /sys/power/cpufreq_max_axi_freq ]; then
 AXI=$($B cat /sys/power/cpufreq_max_axi_freq);
fi;
BG=$((RAM/100));
if [ "$CORES" = "0" ]; then
 CORES=1;
fi;
if [ -e /sys/fs/selinux/enforce ]; then
 $B chmod 666 /sys/fs/selinux/enforce;
 setenforce 0;
 $B echo "0" > /sys/fs/selinux/enforce;
fi;
setprop persist.added_boot_bgservices "$CORES";
setprop ro.config.max_starting_bg "$((CORES +1))";
$B sleep 81;
svc power stayon true;
setprop ro.feralab.engine 1.1;
if [ -d /data/media/0/Android ]; then
 LOG=/data/media/0/Android/FDE_log.txt;
 CONFIG=/data/media/0/Android/FDE_config.txt;
else
 LOG=/sdcard/Android/FDE_log.txt;
 CONFIG=/sdcard/Android/FDE_config.txt;
fi;
$B rm -f $LOG;
$B touch $LOG;
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
 if [ -e /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq ]; then
  BIGMAX=$($B cat /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq);
  $B echo ">> Max CPU freq: $((BIGMAX/1000))Mhz"
 elif [ -e /sys/devices/system/cpu/cpu5/cpufreq/scaling_max_freq ]; then
  BIGMAX=$($B cat /sys/devices/system/cpu/cpu5/cpufreq/scaling_max_freq);
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
} >> $LOG;
service call activity 51 i32 1;
$B sleep 1;
$B echo ">> Tuning SElinux.." >> $LOG;
supolicy --live "allow sdcardd unlabeled dir { append create execute write relabelfrom link unlink ioctl getattr setattr read rename lock mounton quotaon swapon rmdir audit_access remove_name add_name reparent execmod search open }";
supolicy --live "allow sdcardd unlabeled file { append create write relabelfrom link unlink ioctl getattr setattr read rename lock mounton quotaon swapon audit_access open }";
supolicy --live "allow unlabeled unlabeled filesystem associate";
supolicy --live "allow mediaserver mediaserver_tmpfs:file { read write execute }";
$B echo ">> Mounting partitions RW.." >> $LOG;
mount -o remount,rw /data;
mount -o remount,rw /system;
mount -t debugfs none /sys/kernel/debug;
mount debugfs debugfs /sys/kernel/debug;
$B chmod 0755 /sys/kernel/debug;
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
 $B rm -f $CONFIG;
 $B cp /system/engine/assets/FDE_config.txt $CONFIG;
fi;
if [ -e /system/media/bak_bootanimation.zip ]; then
 $B rm -f /system/media/bootanimation.zip;
 $B mv /system/media/bak_bootanimation.zip /system/media/bootanimation.zip;
 $B chmod 644 /system/media/bootanimation.zip;
fi;
if [ -e $CONFIG ]; then
 $B echo ">> Loading FDE_config..." >> $LOG;
 $B rm -f /system/engine/assets/FDE_config.txt;
 $B cp $CONFIG /system/engine/assets/FDE_config.txt;
fi;
if [ -e /system/engine/gears/dummy.sh ]; then
 DUMMY=$($B cat /system/engine/assets/FDE_config.txt | $B grep -e 'dummy=1');
 if [ "dummy=1" = "$DUMMY" ]; then
  $B echo ">> Running Dummy gear..." >> $LOG;
  /system/engine/gears/dummy.sh | $B tee -a $LOG;
 fi;
fi;
sync;
$B sleep 1;
$B echo ">> Executing kernel configuration..." >> $LOG;
sysctl -p;
if [ "$SDK" -le "18" ]; then
 $B echo ">> Mediaserver fix..." >> $LOG;
 $B killall -9 android.process.media;
 $B killall -9 mediaserver;
fi;
if [ -e /etc/fstab ]; then
 $B echo "FStab onboard.";
else
 $B cp /fstab.* /etc/fstab;
fi;
$B echo ">> FileSystem check..." >> $LOG;
$B fsck -A -C -V -T | $B tee -a $LOG;
$B echo ">> FileSystem trim..." >> $LOG;
$B fstrim -v /system | $B tee -a $LOG;
$B fstrim -v /data | $B tee -a $LOG;
$B fstrim -v /cache | $B tee -a $LOG;
sync;
if [ -e /system/engine/prop/firstboot ]; then
 mount -o remount,rw /system;
 if [ -e /sbin/sysrw ]; then
  /sbin/sysrw;
 fi;
 $B rm -f /system/engine/prop/firstboot;
 $B echo ">> First boot completed." >> $LOG;
fi;
$B echo ">> Harden security..." >> $LOG;
if [ -e /sys/fs/selinux/enforce ]; then
 $B chmod 666 /sys/fs/selinux/enforce;
 if [ -e /system/lib/soundfx/libv4a_fx_ics.so ]; then
  $B echo ">> Viper4Android support." >> $LOG;
  setenforce 0;
  $B echo "0" > /sys/fs/selinux/enforce;
 else
  setenforce 1;
  $B echo "1" > /sys/fs/selinux/enforce;
 fi;
 $B chmod 444 /sys/fs/selinux/enforce;
fi;
setprop ro.secure 1;
setprop ro.adb.secure 1;
setprop security.perf_harden 1;
setprop ro.debuggable 0;
$B echo ">> Tweaking multitasking.." >> $LOG;
setprop ro.sys.fw.bg_apps_limit "$BG";
service call activity 51 i32 "$BG";
svc power stayon false;
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
$B killall -9 com.google.android.gms.persistent;
$B echo ">> FDE status - OK" >> $LOG;
$B echo "  " >> $LOG;
if [ -e /engine.sh ]; then
 $B run-parts /system/etc/init.d;
fi;
$B sleep 1;
mount -o remount,ro /system;
if [ -e /sbin/sysro ]; then
 /sbin/sysro;
fi;
if [ "$SDK" -lt "22" ]; then
 if [ -e /system/engine/gears/sleeper.sh ]; then
  /system/engine/gears/sleeper.sh &
 fi;
fi;

