#!/system/bin/sh
### FeraDroid Engine v1.1 | By FeraVolt. 2017 ###
export PATH=/sbin:/system/sbin:/system/bin:/system/xbin:/system/engine/bin:/su/bin
B=/system/engine/bin/busybox;
RAM=$($B free -m | $B awk '{ print $2 }' | $B sed -n 2p);
CORES=$($B grep -c 'processor' /proc/cpuinfo);
SCORE=/system/engine/prop/score;
FSCORE=/system/engine/prop/fscore;
BG=$((RAM/128));
if [ "$BG" -le "3" ]; then
 BG=3;
fi;
if [ "$CORES" = "0" ]; then
 CORES=1;
fi;
svc power stayon true;
$B echo "lock_me" > /sys/power/wake_lock;
if [ "$CORES" -gt "4" ]; then
 $B sleep 45;
else
 $B sleep 72;
fi;
svc power stayon true;
setprop ro.feralab.engine 1.1;
if [ -d /sdcard/Android/ ]; then
 LOG=/sdcard/Android/FDE_log.txt;
 CONFIG=/sdcard/Android/FDE_config.txt;
else
 LOG=/data/media/0/Android/FDE_log.txt;
 CONFIG=/data/media/0/Android/FDE_config.txt;
fi;
$B rm -f $LOG;
$B touch $LOG;
$B chmod 666 $LOG;
$B chmod 666 $CONFIG;
ROM=$(getprop ro.build.display.id);
SDK=$(getprop ro.build.version.sdk);
MAX=$($B cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq);
MIN=$($B cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq);
CUR=$($B cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq);
GPU=$(dumpsys SurfaceFlinger | $B grep "GLES:" | sed -e "s=GLES: ==");
KERNEL=$($B uname -r);
ARCH=$($B grep -Eo "ro.product.cpu.abi(2)?=.+" /system/build.prop 2>/dev/null | $B grep -Eo "[^=]*$" | head -n1);
if [ -e /sys/power/cpufreq_max_axi_freq ]; then
 $B chmod 664 /sys/power/cpufreq_max_axi_freq;
 AXI=$($B cat /sys/power/cpufreq_max_axi_freq);
fi;
$B echo "90" > /sys/devices/virtual/timed_output/vibrator/enable;
msg -t "FDE v1.1 - firing up...";
{
 $B echo "### FeraLab ###"
 $B echo "FeraDroid Engine v1.1"
 $B echo "   "
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
  $B echo ">> CPU max AXI freq: $AXI MHz"
 fi;
 $B echo ">> RAM: $RAM MB"
 $B echo ">> GPU: $GPU"
 $B echo ">> Kernel version: $KERNEL"
 $B echo ">> ROM version: $ROM"
 $B echo ">> Android version: $(getprop ro.build.version.release)"
 $B echo ">> SDK: $SDK"
 $B echo ">> SElinux state: $(getenforce)"
} >> $LOG;
$B echo "Firing up..." >> $LOG;
$B sleep 1;
if [ -e /sys/fs/selinux/enforce ]; then
 $B chmod 666 /sys/fs/selinux/enforce;
 SEMOD=$($B cat /sys/fs/selinux/enforce);
 setenforce 0;
 $B echo "0" > /sys/fs/selinux/enforce;
fi;
if [ -e /sys/fs/selinux/enforce ]; then
 $B echo ">> Tuning SElinux.." >> $LOG;
 supolicy --live "allow mediaserver mediaserver_tmpfs:file { read write execute }";
 supolicy --live "allow audioserver audioserver_tmpfs:file { read write execute }";
fi;
$B echo ">> Mounting partitions RW.." >> $LOG;
$B mount -o remount,rw /data;
mount -o remount,rw /data;
$B mount -o remount,rw /system;
mount -o remount,rw /system;
$B mount -t debugfs none /sys/kernel/debug;
mount -t debugfs none /sys/kernel/debug;
$B mount -t debugfs debugfs /sys/kernel/debug;
mount -t debugfs debugfs /sys/kernel/debug;
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
$B chmod -R 711 /system/engine/*;
$B chmod 711 /system/engine/gears/*;
$B chmod 711 /system/engine/prop/*;
$B chmod 777 /system/engine/raw/*;
$B rm -f /system/etc/sysctl.conf;
$B touch /system/etc/sysctl.conf;
$B chmod 777 /system/etc/sysctl.conf;
if [ -e /system/engine/prop/firstboot ]; then
 $B echo ">> First boot." >> $LOG;
 $B touch /system/engine/prop/fscore;
 $B chmod 777 /system/engine/prop/fscore;
 $B echo ">> Running one time init gear..." >> $LOG;
 $B echo "================================" >> $LOG;
 /system/engine/gears/runonce.sh | $B tee -a $LOG;
 $B echo "================================" >> $LOG;
 $B rm -f $CONFIG;
 $B cp /system/engine/raw/FDE_config.txt $CONFIG;
 $B mount -o remount,rw /system;
 mount -o remount,rw /system;
 if [ -e /sbin/sysrw ]; then
  /sbin/sysrw;
 fi;
 if [ -e /system/media/bak_bootanimation.zip ]; then
  $B rm -f /system/media/bootanimation.zip;
  $B mv /system/media/bak_bootanimation.zip /system/media/bootanimation.zip;
  $B chmod 644 /system/media/bootanimation.zip;
  $B echo ">> Bootanimation restored." >> $LOG;
 fi;
 $B rm -f /system/engine/prop/firstboot;
 $B rm -f /system/engine/gears/runonce.sh;
 $B echo ">> First boot completed." >> $LOG;
 sync;
 $B sleep 3;
 msg -t "FDE deployed. Rebooting NOW!";
 $B sleep 3;
 reboot
 $B sleep 9;
 exit 0;
fi;
if [ -e $CONFIG ]; then
 $B echo ">> Loading FDE_config..." >> $LOG;
 $B rm -f /system/engine/raw/FDE_config.txt;
 $B cp $CONFIG /system/engine/raw/FDE_config.txt;
fi;
MADMAX=$($B cat /system/engine/raw/FDE_config.txt | $B grep -e 'mad_max=1');
if [ "mad_max=1" = "$MADMAX" ]; then
{
 $B echo -e "\xE2\x98\xA0 \xE2\x98\xA0 \xE2\x98\xA0 \xE2\x98\xA0 \xE2\x98\xA0 \xE2\x98\xA0 \xE2\x98\xA0 \xE2\x98\xA0 \xE2\x98\xA0"
 $B echo " MAD MAX MODE ACTIVE "
 $B echo -e "\xE2\x98\xA0 \xE2\x98\xA0 \xE2\x98\xA0 \xE2\x98\xA0 \xE2\x98\xA0 \xE2\x98\xA0 \xE2\x98\xA0 \xE2\x98\xA0 \xE2\x98\xA0"
} >> $LOG;
fi;
$B echo "0" > $SCORE;
$B echo "$((CORES+CORES+1))" >> $SCORE;
if [ -e /sys/fs/selinux/enforce ]; then
 $B echo "5" >> $SCORE;
fi;
if [ -e /system/engine/gears/battery.sh ]; then
 BATTERY=$($B cat /system/engine/raw/FDE_config.txt | $B grep -e 'battery=1');
 if [ "battery=1" = "$BATTERY" ]; then
  $B echo ">> Running BATTERY gear..." >> $LOG;
  $B echo "================================" >> $LOG;
  /system/engine/gears/battery.sh | $B tee -a $LOG;
  $B echo "================================" >> $LOG;
 fi;
fi;
if [ -e /system/engine/gears/cleaner.sh ]; then
 CLEANER=$($B cat /system/engine/raw/FDE_config.txt | $B grep -e 'cleaner=1');
 if [ "cleaner=1" = "$CLEANER" ]; then
  $B echo ">> Running CLEANER gear..." >> $LOG;
  $B echo "================================" >> $LOG;
  /system/engine/gears/cleaner.sh | $B tee -a $LOG;
  $B echo "================================" >> $LOG;
  $B echo "3" >> $SCORE;
 fi;
fi;
if [ -e /system/engine/gears/cpu.sh ]; then
 CPU=$($B cat /system/engine/raw/FDE_config.txt | $B grep -e 'cpu=1');
 if [ "cpu=1" = "$CPU" ]; then
  $B echo ">> Running CPU gear..." >> $LOG;
  $B echo "================================" >> $LOG;
  /system/engine/gears/cpu.sh | $B tee -a $LOG;
  $B echo "================================" >> $LOG;
 fi;
fi;
if [ -e /system/engine/gears/graphics.sh ]; then
 GRAPHICS=$($B cat /system/engine/raw/FDE_config.txt | $B grep -e 'graphics=1');
 if [ "graphics=1" = "$GRAPHICS" ]; then
  $B echo ">> Running GRAPHICS gear..." >> $LOG;
  $B echo "================================" >> $LOG;
  /system/engine/gears/graphics.sh | $B tee -a $LOG;
  $B echo "================================" >> $LOG;
 fi;
fi;
if [ -e /system/engine/gears/io.sh ]; then
 IO=$($B cat /system/engine/raw/FDE_config.txt | $B grep -e 'io=1');
 if [ "io=1" = "$IO" ]; then
  $B echo ">> Running IO gear..." >> $LOG;
  $B echo "================================" >> $LOG;
  /system/engine/gears/io.sh | $B tee -a $LOG;
  $B echo "================================" >> $LOG;
 fi;
fi;
if [ -e /system/engine/gears/kernel.sh ]; then
 KERNEL=$($B cat /system/engine/raw/FDE_config.txt | $B grep -e 'kernel=1');
 if [ "kernel=1" = "$KERNEL" ]; then
  $B echo ">> Running KERNEL gear..." >> $LOG;
  $B echo "================================" >> $LOG;
  /system/engine/gears/kernel.sh | $B tee -a $LOG;
  $B echo "================================" >> $LOG;
 fi;
fi;
if [ -e /system/engine/gears/network.sh ]; then
 NETWORK=$($B cat /system/engine/raw/FDE_config.txt | $B grep -e 'network=1');
 if [ "network=1" = "$NETWORK" ]; then
  $B echo ">> Running NETWORK gear..." >> $LOG;
  $B echo "================================" >> $LOG;
  /system/engine/gears/network.sh | $B tee -a $LOG;
  $B echo "================================" >> $LOG;
 fi;
fi;
if [ -e /system/engine/gears/ram.sh ]; then
 RAM=$($B cat /system/engine/raw/FDE_config.txt | $B grep -e 'ram=1');
 if [ "ram=1" = "$RAM" ]; then
  $B echo ">> Running RAM gear..." >> $LOG;
  $B echo "================================" >> $LOG;
  /system/engine/gears/ram.sh | $B tee -a $LOG;
  $B echo "================================" >> $LOG;
 fi;
fi;
if [ -e /system/engine/gears/vm.sh ]; then
 VM=$($B cat /system/engine/raw/FDE_config.txt | $B grep -e 'vm=1');
 if [ "vm=1" = "$VM" ]; then
  $B echo ">> Running VM gear..." >> $LOG;
  $B echo "================================" >> $LOG;
  /system/engine/gears/vm.sh | $B tee -a $LOG;
  $B echo "================================" >> $LOG;
 fi;
fi;
sync;
$B sleep 1;
$B echo ">> Executing kernel configuration..." >> $LOG;
sysctl -p;
$B echo "1" >> $SCORE;
if [ "$SDK" -le "18" ]; then
 if [ "$SDK" -gt "10" ]; then
  $B echo ">> Mediaserver fix..." >> $LOG;
  $B killall -9 android.process.media;
  $B killall -9 mediaserver;
  $B echo "2" >> $SCORE;
 fi;
fi;
if [ -e /etc/fstab ]; then
 $B echo "FStab onboard.";
 $B echo "1" >> $SCORE;
else
 $B cp /fstab.* /etc/fstab;
fi;
$B echo ">> FileSystem check..." >> $LOG;
$B fsck -A -C -V -T | $B tee -a $LOG;
$B echo ">> FileSystem trim..." >> $LOG;
$B fstrim -v /system | $B tee -a $LOG;
$B fstrim -v /data | $B tee -a $LOG;
$B fstrim -v /cache | $B tee -a $LOG;
$B echo "3" >> $SCORE;
sync;
$B echo ">> Harden security..." >> $LOG;
if [ -e /sys/fs/selinux/enforce ]; then
 $B chmod 666 /sys/fs/selinux/enforce;
 if [ -e /system/lib/soundfx/libv4a_fx_ics.so ]; then
  $B echo ">> Viper4Android support." >> $LOG;
  setenforce 0;
  $B echo "0" > /sys/fs/selinux/enforce;
  setprop lpa.decode false;
  setprop tunnel.decode false;
  setprop lpa.use-stagefright false;
 else
  setenforce "$SEMOD";
  $B echo "1" > /sys/fs/selinux/enforce;
 fi;
 $B chmod 444 /sys/fs/selinux/enforce;
fi;
setprop ro.secure 1;
setprop ro.adb.secure 1;
setprop security.perf_harden 1;
$B echo "3" >> $SCORE;
$B echo ">> Tweaking multitasking.." >> $LOG;
service call activity 51 i32 "$BG";
setprop ro.sys.fw.bg_apps_limit "$BG";
$B echo "$BG" >> $SCORE;
svc power stayon false;
$B echo "lock_me" > /sys/power/wake_unlock;
$B killall -9 com.google.android.gms.persistent;
$B echo "1" >> $SCORE;
FSCR=$($B awk '{ sum += $1 } END { print sum }' $FSCORE);
$B echo "$FSCR" >> $SCORE;
$B sleep 1;
$B echo "120" > /sys/devices/virtual/timed_output/vibrator/enable;
$B sleep 0.3;
$B echo "120" > /sys/devices/virtual/timed_output/vibrator/enable;
$B sleep 0.3;
$B echo "120" > /sys/devices/virtual/timed_output/vibrator/enable;
msg -t "FDE status - OK";
$B echo "FDE status - OK" >> $LOG;
$B echo "  " >> $LOG;
SCR=$($B awk '{ sum += $1 } END { print sum }' $SCORE);
$B sleep 1;
$B echo "*** Your FDE score is - $SCR ***" >> $LOG;
msg -t "Your FDE score is >> $SCR";
$B echo "  " >> $LOG;
$B sleep 1;
msg -t "Logfile >> $LOG";
if [ -e /engine.sh ]; then
 $B run-parts /system/etc/init.d;
fi;
sync;
$B sleep 1;
$B mount -o remount,ro /system;
mount -o remount,ro /system;
if [ -e /sbin/sysro ]; then
 /sbin/sysro;
fi;
for x in $($B mount | grep ext4 | cut -d " " -f3); do
 $B mount -o remount,noatime,nodiratime,nobarrier,discard "${x}";
done;
if [ -e /system/engine/gears/cleaner.sh ]; then
 CLEANERD=$($B cat /system/engine/raw/FDE_config.txt | $B grep -e 'cleanerd=1');
 if [ "cleanerd=1" = "$CLEANERD" ]; then
  $B echo ">> Starting CLEANERD daemon.." >> $LOG;
  $B setsid /system/engine/gears/cleanerd.sh >> $LOG 2>&1 < /dev/null &
 fi;
fi;
if [ -e /system/engine/gears/sleeper.sh ]; then
 if [ "$SDK" -le "22" ]; then
  SLEEPER=$($B cat /system/engine/raw/FDE_config.txt | $B grep -e 'sleeper=1');
  if [ "sleeper=1" = "$SLEEPER" ]; then
   $B echo ">> Starting SLEEPER daemon.." >> $LOG;
   $B setsid /system/engine/gears/sleeper.sh >> $LOG 2>&1 < /dev/null &
  fi;
 fi;
elif [ "mad_max=1" = "$MADMAX" ]; then
 SLEEPER=$($B cat /system/engine/raw/FDE_config.txt | $B grep -e 'sleeper=1');
 if [ "sleeper=1" = "$SLEEPER" ]; then
  $B echo ">> Starting SLEEPER daemon.." >> $LOG;
  $B setsid /system/engine/gears/sleeper.sh >> $LOG 2>&1 < /dev/null &
 fi;
fi;
sync;
$B sleep 2;
exit 0
