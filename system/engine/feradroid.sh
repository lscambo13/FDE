#!/system/bin/sh
### FeraDroid Engine v0.21 | By FeraVolt. 2016 ###
B=/system/engine/bin/busybox
KERNEL=$($B uname -r)
ARCH=$($B uname -m)
RAM=$($B free -m | $B awk '{ print $2 }' | $B sed -n 2p)
ROM=$(getprop ro.build.display.id)
SDK=$(getprop ro.build.version.sdk)
SF=$($B df -Ph /system | $B grep -v ^Filesystem | $B awk '{print $4}')
MAX=$($B cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq)
MIN=$($B cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq)
CUR=$($B cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq)
CORES=$($B grep -c 'processor' /proc/cpuinfo)
LOG=/sdcard/Android/FDE_log.txt
TIME=$($B date | $B awk '{ print $4 }')
setprop ro.feralab.engine 21
$B sleep 96
$B mount -o remount,rw /system
$B rm -f $LOG
$B touch $LOG
if [ -e $LOG ]; then
 $B echo "LOG - OK"
 CONFIG=/sdcard/Android/FDE_config.txt
else
 LOG=/data/media/0/Android/FDE_log.txt
 CONFIG=/data/media/0/Android/FDE_config.txt
fi;
$B rm -f $LOG
$B touch $LOG
$B chown 0:0 $LOG
$B chown 0:0 $CONFIG
$B chmod 777 $LOG
$B chmod 777 $CONFIG
$B echo "### FeraLab ###" > $LOG
$B echo "" >> $LOG
$B echo "[$TIME] FeraDroid Engine v0.21-b7" >> $LOG
$B echo "[$TIME] Firing up.." >> $LOG
$B echo "[$TIME] Device: $(getprop ro.product.brand) $(getprop ro.product.model)" >> $LOG
$B echo "[$TIME] Architecture: $ARCH" >> $LOG
$B echo "[$TIME] RAM: $RAM MB" >> $LOG
$B echo "[$TIME] MAX CPU freq:$((MAX/1000))Mhz" >> $LOG
$B echo "[$TIME] MIN CPU freq:$((MIN/1000))Mhz" >> $LOG
$B echo "[$TIME] Current CPU freq:$((CUR/1000))Mhz" >> $LOG
$B echo "[$TIME] CPU Cores: $CORES" >> $LOG
$B echo "[$TIME] Kernel version: $KERNEL" >> $LOG
$B echo "[$TIME] ROM version: $ROM" >> $LOG
$B echo "[$TIME] Android version: $(getprop ro.build.version.release)" >> $LOG
$B echo "[$TIME] SDK: $SDK" >> $LOG
$B echo "[$TIME] /system free space: $SF" >> $LOG
if [ -e /system/engine/prop/firstboot ]; then
 $B echo "[$TIME] First boot after deploy" >> $LOG
 $B mount -o remount,rw /system
 if [ -e /sbin/sysrw ]; then
  /sbin/sysrw
  $B sleep 1
 fi;
 $B cp /system/engine/bin/zipalign /system/xbin/zipalign
 $B cp /system/engine/bin/boost /system/xbin/boost
 $B rm -f $CONFIG
 $B cp /system/engine/assets/FDE_config.txt $CONFIG
 if [ -e /system/engine/assets/gp ]; then
  $B echo "Google Play services fix" >> $LOG
  /system/engine/assets/gp
 fi;
fi;
TIME=$($B date | $B awk '{ print $4 }')
if [ -e $CONFIG ]; then
 $B echo "[$TIME] Loading FDE_config.." >> $LOG
 $B mount -o remount,rw /system
 $B rm -f /system/engine/assets/FDE_config.txt
 $B cp $CONFIG /system/engine/assets/FDE_config.txt
fi;
if [ -e /sys/fs/selinux/enforce ]; then
 $B chmod 666 /sys/fs/selinux/enforce
 setenforce 0
 $B echo 0 > /sys/fs/selinux/enforce
 $B chmod 444 /sys/fs/selinux/enforce
fi;
if [ -e /sbin/sysrw ]; then
 $B echo "[$TIME] Remapped partition mount detected" >> $LOG
 /sbin/sysrw
 $B sleep 1
fi;
$B echo "[$TIME] Remounting /data and /system - RW" >> $LOG
$B mount -o remount,rw /system
$B mount -o remount,rw /data
$B echo "[$TIME] Set SElinux permissive.." >> $LOG
$B echo "[$TIME] Correcting permissions.." >> $LOG
$B chmod 644 /system/build.prop
$B chmod -R 777 /cache/*
$B chmod -R 777 /system/engine/*
$B chmod 777 /system/engine/assets/*
$B chmod 777 /system/engine/gears/*
$B chmod 777 /system/engine/prop/*
sync;
$B mount -o remount,rw /system
$B rm -f /system/etc/sysctl.conf
$B touch /system/etc/sysctl.conf
$B chmod 777 /system/etc/sysctl.conf
TIME=$($B date | $B awk '{ print $4 }')
if [ -e /system/engine/prop/ferakernel ]; then
 $B echo "[$TIME] FeraKernel init.." >> $LOG
elif [ -e /system/engine/prop/qcompost ]; then
 $B echo "[$TIME] Qcomm post-boot init.." >> $LOG
elif [ -e /system/engine/prop/hwconf ]; then
 $B echo "[$TIME] HW-conf init.." >> $LOG
elif [ -e /system/engine/prop/zrami ]; then
 $B echo "[$TIME] Zram init.." >> $LOG
elif [ -e /system/etc/init.d/999fde ]; then
 $B echo "[$TIME] Init.d init.." >> $LOG
fi;
if [ -e /system/engine/gears/01network.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }')
 $B echo "[$TIME] Running Network gear.." >> $LOG
 /system/engine/gears/01network.sh | $B tee -a $LOG
fi;
if [ -e /system/engine/gears/02cleaner.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }')
 $B echo "[$TIME] Running Cleaner gear.." >> $LOG
 /system/engine/gears/02cleaner.sh | $B tee -a $LOG
fi;
if [ -e /system/engine/gears/03battery.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }')
 $B echo "[$TIME] Running Battery gear.." >> $LOG
 /system/engine/gears/03battery.sh | $B tee -a $LOG
fi;
if [ -e /system/engine/gears/04vm.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }')
 $B echo "[$TIME] Running VM gear.." >> $LOG
 /system/engine/gears/04vm.sh | $B tee -a $LOG
fi;
if [ -e /system/engine/gears/05gps.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }')
 $B echo "[$TIME] Running GPS gear.." >> $LOG
 /system/engine/gears/05gps.sh | $B tee -a $LOG
fi;
if [ -e /system/engine/gears/06kernel.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }')
 $B echo "[$TIME] Running Kernel gear.." >> $LOG
 /system/engine/gears/06kernel.sh | $B tee -a $LOG
fi;
if [ -e /system/engine/gears/07memory.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }')
 $B echo "[$TIME] Running Memory gear.." >> $LOG
 /system/engine/gears/07memory.sh | $B tee -a $LOG
fi;
if [ -e /system/engine/gears/08cpu.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }')
 $B echo "[$TIME] Running CPU gear.." >> $LOG
 /system/engine/gears/08cpu.sh | $B tee -a $LOG
fi;
if [ -e /system/engine/gears/09gpu.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }')
 $B echo "[$TIME] Running GPU gear.." >> $LOG
 /system/engine/gears/09gpu.sh | $B tee -a $LOG
fi;
if [ -e /system/engine/gears/10adblocker.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }')
 $B echo "[$TIME] Running Ad-Blocker gear.." >> $LOG
 /system/engine/gears/10adblocker.sh | $B tee -a $LOG
fi;
if [ -e /system/engine/gears/11ram.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }')
 $B echo "[$TIME] Running RAM gear.." >> $LOG
 /system/engine/gears/11ram.sh | $B tee -a $LOG
fi;
service call activity 51 i32 0
if [ -e /system/engine/gears/end.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }')
 $B echo "[$TIME] END init.." >> $LOG
 /system/engine/gears/end.sh
fi;
sync;
$B sleep 1
service call activity 51 i32 -1
if [ -e /system/engine/gears/sleeper.sh ]; then
$B echo "[$TIME] Init Sleeper daemon" >> $LOG
 /system/engine/gears/sleeper.sh &
fi;
if [ -e /system/engine/prop/firstboot ]; then
 $B mount -o remount,rw /system
 $B rm -f /system/engine/prop/firstboot
 $B echo "[$TIME] First boot completed." >> $LOG
fi;
$B echo 96 > /sys/devices/virtual/timed_output/vibrator/enable
$B sleep 0.3
$B echo 96 > /sys/devices/virtual/timed_output/vibrator/enable
$B sleep 0.3
$B echo 96 > /sys/devices/virtual/timed_output/vibrator/enable
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] FDE status - OK" >> $LOG
$B mount -o remount,ro /system
$B echo "" >> $LOG
