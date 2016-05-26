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
LOG=/sdcard/Android/FDE.txt
TIME=$($B date | $B awk '{ print $4 }')
rm -f $LOG
mount -o remount,rw /system
chmod 755 /system/engine/bin/*
setprop ro.feralab.engine 21
$B sleep 45
$B sleep 36
$B mount -o remount,rw /system
$B rm -f $LOG
$B touch $LOG
$B echo "### FeraLab ###" > $LOG
$B echo "" >> $LOG
$B echo "[$TIME] FeraDroid Engine v0.21b2" >> $LOG
$B echo "[$TIME] Firing up.." >> $LOG
$B echo "[$TIME] Device: $(getprop ro.product.brand) $(getprop ro.product.model)" >> $LOG
$B echo "[$TIME] Architecture: $ARCH" >> $LOG
$B echo "[$TIME] RAM: $RAM MB" >> $LOG
$B echo "[$TIME] MAX CPU freq:$((MAX/1000))Mhz"
$B echo "[$TIME] MIN CPU freq:$((MIN/1000))Mhz"
$B echo "[$TIME] Current CPU freq:$((CUR/1000))Mhz"
$B echo "[$TIME] CPU Cores : $CORES"
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
 $B cp /system/engine/assets/sleeper_whitelist.txt /sdcard/Android/sleeper_whitelist.txt
fi;
if [ -e /sys/fs/selinux/enforce ]; then
 $B chmod 666 /sys/fs/selinux/enforce
 setenforce 0
 $B echo 0 > /sys/fs/selinux/enforce
 $B chmod 444 /sys/fs/selinux/enforce
fi;
TIME=$($B date | $B awk '{ print $4 }')
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
$B chmod -R 755 /system/engine/*
$B chmod 755 /system/engine/assets/*
$B chmod 755 /system/engine/gears/*
$B chmod 755 /system/engine/prop/*
sync;
$B mount -o remount,rw /system
$B rm -f /system/etc/sysctl.conf
$B touch /system/etc/sysctl.conf
$B chmod 755 /system/etc/sysctl.conf
TIME=$($B date | $B awk '{ print $4 }')
if [ -e /system/engine/prop/ferakernel ]; then
 $B echo "[$TIME] FeraKernel init.." >> $LOG
elif [ -e /system/engine/prop/qcompost ]; then
 $B echo "[$TIME] Qcomm post-boot init.." >> $LOG
elif [ -e /system/engine/prop/hwconf ]; then
 $B echo "[$TIME] HW-conf init.." >> $LOG
elif [ -e /system/engine/prop/zrami ]; then
 $B echo "[$TIME] Zram-i init.." >> $LOG
elif [ -e /system/engine/prop/irec ]; then
 $B echo "[$TIME] Install-recovery init.." >> $LOG
elif [ -e /system/etc/init.d/999fde ]; then
 $B echo "[$TIME] Init.d init.." >> $LOG
fi;
if [ -e /system/engine/gears/001abc.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }')
 $B echo "[$TIME] Running 001 gear.." >> $LOG
 /system/engine/gears/001abc.sh | $B tee -a $LOG
fi;
if [ -e /system/engine/gears/002def.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }')
 $B echo "[$TIME] Running 002 gear.." >> $LOG
 /system/engine/gears/002def.sh | $B tee -a $LOG
fi;
if [ -e /system/engine/gears/003ghi.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }')
 $B echo "[$TIME] Running 003 gear.." >> $LOG
 /system/engine/gears/003ghi.sh | $B tee -a $LOG
fi;
if [ -e /system/engine/gears/004jkl.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }')
 $B echo "[$TIME] Running 004 gear.." >> $LOG
 /system/engine/gears/004jkl.sh | $B tee -a $LOG
fi;
if [ -e /system/engine/gears/005mno.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }')
 $B echo "[$TIME] Running 005 gear.." >> $LOG
 /system/engine/gears/005mno.sh | $B tee -a $LOG
fi;
if [ -e /system/engine/gears/006pqr.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }')
 $B echo "[$TIME] Running 006 gear.." >> $LOG
 /system/engine/gears/006pqr.sh | $B tee -a $LOG
fi;
if [ -e /system/engine/gears/007stu.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }')
 $B echo "[$TIME] Running 007 gear.." >> $LOG
 /system/engine/gears/007stu.sh | $B tee -a $LOG
fi;
if [ -e /system/engine/gears/008vwx.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }')
 $B echo "[$TIME] Running 008 gear.." >> $LOG
 /system/engine/gears/008vwx.sh | $B tee -a $LOG
fi;
if [ -e /system/engine/gears/009yza.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }')
 $B echo "[$TIME] Running 009 gear.." >> $LOG
 /system/engine/gears/009yza.sh | $B tee -a $LOG
fi;
if [ -e /system/engine/gears/010bcd.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }')
 $B echo "[$TIME] Running 010 gear.." >> $LOG
 /system/engine/gears/010bcd.sh | $B tee -a $LOG
fi;
if [ -e /system/engine/gears/011efg.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }')
 $B echo "[$TIME] Running 011 gear.." >> $LOG
 /system/engine/gears/011efg.sh | $B tee -a $LOG
fi;
if [ -e /system/engine/gears/end.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }')
 $B echo "[$TIME] "END" start" >> $LOG
 /system/engine/gears/end.sh
fi;
if [ -e /system/engine/gears/sleeper.sh ]; then
$B echo "[$TIME] Init sleeper daemon" >> $LOG
 /system/engine/gears/sleeper.sh &
fi;
sync;
$B sleep 3
if [ -e /system/engine/prop/firstboot ]; then
 $B mount -o remount,rw /system
 $B rm -f /system/engine/prop/firstboot
 $B mount -o remount,ro /system
 $B echo "[$TIME] First boot completed." >> $LOG
fi;
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] FDE status - OK" >> $LOG
$B mount -o remount,ro /system
$B echo "" >> $LOG
