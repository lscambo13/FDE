#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2016 ###
B=/system/engine/bin/busybox
LOG=/sdcard/Android/FDE.txt
TIME=$($B date | $B awk '{ print $4 }')
SDK=$(getprop ro.build.version.sdk)
$B echo "[$TIME] 005 - ***Kernel gear***" >> $LOG
RAM=$($B free -m | $B awk '{ print $2 }' | $B sed -n 2p)
FM=$((RAM*(64+1)))
ME=$((RAM*27))
if [ -e /proc/sys/vm/extra_free_kbytes ]; then
 if [ "$RAM" -gt "2048" ]; then
  EF=$((RAM*4))
  FK=$((RAM*3))
 elif [ "$RAM" -gt "1024" ]; then
  EF=$((RAM*6))
  FK=$((RAM*4))
 else
  EF=$((RAM*8))
  FK=$((RAM*6))
 fi;
else
 FK=$((RAM*8))
fi;
MALL=$((RAM*192))
MMAX=$((MALL*4096))
if [ "$MMAX" -le "268435456" ]; then
 MMAX=268435456
fi;
if [ -e /proc/sys/vm/user_reserve_kbytes ]; then
 UR=$((RAM*12))
 AR=8192
fi;
$B echo "Writing optimized kernel parameters to sysfs.." >> $LOG
$B echo 1536 > /proc/sys/kernel/random/read_wakeup_threshold
$B echo 256 > /proc/sys/kernel/random/write_wakeup_threshold
$B echo 90 > /proc/sys/vm/vfs_cache_pressure
$B echo $FK > /proc/sys/vm/min_free_kbytes
if [ -e /proc/sys/vm/extra_free_kbytes ]; then
 $B echo $EF > /proc/sys/vm/extra_free_kbytes
fi;
if [ -e /proc/sys/vm/user_reserve_kbytes ]; then
 $B echo $UR > /proc/sys/vm/user_reserve_kbytes
 $B echo $AR > /proc/sys/vm/admin_reserve_kbytes
fi;
if [ -e /proc/sys/vm/compact_memory ]; then
 $B echo 1 > /proc/sys/vm/compact_memory
 $B echo 1 > /proc/sys/vm/compact_unevictable_allowed
fi;
$B echo 3 > /proc/sys/vm/drop_caches
$B echo 1 > /proc/sys/vm/oom_kill_allocating_task
$B echo 40 > /proc/sys/vm/dirty_ratio
$B echo 15 > /proc/sys/vm/dirty_background_ratio
$B echo 0 > /proc/sys/vm/dirty_writeback_centisecs
$B echo 0 > /proc/sys/vm/dirty_expire_centisecs
$B echo 0 > /proc/sys/vm/panic_on_oom
$B echo 1 > /proc/sys/vm/overcommit_memory
$B echo 100 > /proc/sys/vm/overcommit_ratio
$B echo 2 > /proc/sys/vm/laptop_mode
$B echo 0 > /proc/sys/vm/block_dump
$B echo 0 > /proc/sys/vm/oom_dump_tasks
$B echo 4 > /proc/sys/vm/min_free_order_shift
$B echo $FM > /proc/sys/fs/file-max
$B echo 1 > /proc/sys/fs/leases-enable
$B echo 5 > /proc/sys/fs/lease-break-time
$B echo $ME > /proc/sys/fs/inotify/max_queued_events
$B echo 256 > /proc/sys/fs/inotify/max_user_instances
$B echo 16384 > /proc/sys/fs/inotify/max_user_watches
$B echo 2 > /proc/sys/kernel/randomize_va_space
$B echo 0 > /proc/sys/kernel/softlockup_panic
$B echo 0 > /proc/sys/kernel/hung_task_timeout_secs
$B echo 0 > /proc/sys/kernel/panic_on_oops
$B echo 0 > /proc/sys/kernel/panic
$B echo 4096 > /proc/sys/kernel/shmmni
$B echo $MALL > /proc/sys/kernel/shmall
$B echo $MMAX > /proc/sys/kernel/shmmax
$B echo 16384 > /proc/sys/kernel/msgmni
$B echo 8192 > /proc/sys/kernel/msgmax
$B echo 8192 > /proc/sys/kernel/msgmnb
$B echo '250 32000 96 128' > /proc/sys/kernel/sem
$B echo "Writing optimized kernel parameters to sysctl.." >> $LOG
$B mount -o remount,rw /system
$B echo "kernel.random.read_wakeup_threshold=1536" >> /system/etc/sysctl.conf
$B echo "kernel.random.write_wakeup_threshold=256" >> /system/etc/sysctl.conf
$B echo "vm.vfs_cache_pressure=90" >> /system/etc/sysctl.conf
$B echo "vm.min_free_kbytes=$FK" >> /system/etc/sysctl.conf
if [ -e /proc/sys/vm/extra_free_kbytes ]; then
 $B echo "vm.extra_free_kbytes=$EF" >> /system/etc/sysctl.conf
fi;
if [ -e /proc/sys/vm/user_reserve_kbytes ]; then
 $B echo "vm.user_reserve_kbytes=$UR" >> /system/etc/sysctl.conf
 $B echo "vm.admin_reserve_kbytes=$AR" >> /system/etc/sysctl.conf
fi;
if [ -e /proc/sys/vm/compact_memory ]; then
 $B echo "vm.compact_memory=1" >> /system/etc/sysctl.conf
 $B echo "vm.compact_unevictable_allowed=1" >> /system/etc/sysctl.conf
fi;
$B echo "vm.drop_caches=3" >> /system/etc/sysctl.conf
$B echo "vm.oom_kill_allocating_task=1" >> /system/etc/sysctl.conf
$B echo "vm.dirty_ratio=40" >> /system/etc/sysctl.conf
$B echo "vm.dirty_background_ratio=15" >> /system/etc/sysctl.conf
$B echo "vm.dirty_writeback_centisecs=0" >> /system/etc/sysctl.conf
$B echo "vm.dirty_expire_centisecs=0" >> /system/etc/sysctl.conf
$B echo "vm.panic_on_oom=0" >> /system/etc/sysctl.conf
$B echo "vm.overcommit_memory=1" >> /system/etc/sysctl.conf
$B echo "vm.overcommit_ratio=100" >> /system/etc/sysctl.conf
$B echo "vm.laptop_mode=2" >> /system/etc/sysctl.conf
$B echo "vm.block_dump=0" >> /system/etc/sysctl.conf
$B echo "vm.oom_dump_tasks=0" >> /system/etc/sysctl.conf
$B echo "vm.min_free_order_shift=4" >> /system/etc/sysctl.conf
$B echo "fs.file-max=$FM" >> /system/etc/sysctl.conf
$B echo "fs.leases-enable=1" >> /system/etc/sysctl.conf
$B echo "fs.lease-break-time=5" >> /system/etc/sysctl.conf
$B echo "fs.inotify.max_queued_events=$ME" >> /system/etc/sysctl.conf
$B echo "fs.inotify.max_user_instances=256" >> /system/etc/sysctl.conf
$B echo "fs.inotify.max_user_watches=16384" >> /system/etc/sysctl.conf
$B echo "kernel.randomize_va_space=2" >> /system/etc/sysctl.conf
$B echo "kernel.sched_compat_yield=1" >> /system/etc/sysctl.conf
$B echo "kernel.scan_unevictable_pages=0" >> /system/etc/sysctl.conf
$B echo "kernel.hung_task_timeout_secs=0" >> /system/etc/sysctl.conf
$B echo "kernel.panic=0" >> /system/etc/sysctl.conf
$B echo "kernel.panic_on_oops=0" >> /system/etc/sysctl.conf
$B echo "kernel.softlockup_panic=0" >> /system/etc/sysctl.conf
$B echo "kernel.shmmni=4096" >> /system/etc/sysctl.conf
$B echo "kernel.shmall=$MALL" >> /system/etc/sysctl.conf
$B echo "kernel.shmmax=$MMAX" >> /system/etc/sysctl.conf
$B echo "kernel.msgmni=16384" >> /system/etc/sysctl.conf
$B echo "kernel.msgmax=8192" >> /system/etc/sysctl.conf
$B echo "kernel.msgmnb=8192" >> /system/etc/sysctl.conf
$B echo "kernel.sem='250 32000 96 128'" >> /system/etc/sysctl.conf
$B echo "Executing optimized kernel parameters via sysctl.." >> $LOG
$B sysctl -e -w kernel.random.read_wakeup_threshold=1536
$B sysctl -e -w kernel.random.write_wakeup_threshold=256
$B sysctl -e -w vm.vfs_cache_pressure=90
$B sysctl -e -w vm.min_free_kbytes=$FK
if [ -e /proc/sys/vm/extra_free_kbytes ]; then
 $B sysctl -e -w vm.extra_free_kbytes=$EF
fi;
if [ -e /proc/sys/vm/user_reserve_kbytes ]; then
 $B sysctl -e -w vm.user_reserve_kbytes=$UR
 $B sysctl -e -w vm.admin_reserve_kbytes=$AR
fi;
if [ -e /proc/sys/vm/compact_memory ]; then
 $B sysctl -e -w vm.compact_memory=1
 $B sysctl -e -w vm.compact_unevictable_allowed=1
fi;
$B sysctl -e -w vm.drop_caches=3
$B sysctl -e -w vm.oom_kill_allocating_task=1
$B sysctl -e -w vm.dirty_ratio=40
$B sysctl -e -w vm.dirty_background_ratio=15
$B sysctl -e -w vm.dirty_writeback_centisecs=0
$B sysctl -e -w vm.dirty_expire_centisecs=0
$B sysctl -e -w vm.panic_on_oom=0
$B sysctl -e -w vm.overcommit_memory=1
$B sysctl -e -w vm.overcommit_ratio=100
$B sysctl -e -w vm.laptop_mode=2
$B sysctl -e -w vm.block_dump=0
$B sysctl -e -w vm.oom_dump_tasks=0
$B sysctl -e -w vm.min_free_order_shift=4
$B sysctl -e -w fs.file-max=$FM
$B sysctl -e -w fs.leases-enable=1
$B sysctl -e -w fs.lease-break-time=5
$B sysctl -e -w fs.inotify.max_queued_events=$ME
$B sysctl -e -w fs.inotify.max_user_instances=256
$B sysctl -e -w fs.inotify.max_user_watches=16384
$B sysctl -e -w kernel.randomize_va_space=2
$B sysctl -e -w kernel.sched_compat_yield=1
$B sysctl -e -w kernel.scan_unevictable_pages=0
$B sysctl -e -w kernel.hung_task_timeout_secs=0
$B sysctl -e -w kernel.panic=0
$B sysctl -e -w kernel.panic_on_oops=0
$B sysctl -e -w kernel.softlockup_panic=0
$B sysctl -e -w kernel.shmmni=4096
$B sysctl -e -w kernel.shmall=$MALL
$B sysctl -e -w kernel.shmmax=$MMAX
$B sysctl -e -w kernel.msgmni=16384
$B sysctl -e -w kernel.msgmax=8192
$B sysctl -e -w kernel.msgmnb=8192
$B sysctl -e -w kernel.sem='250 32000 96 128'
if [ -e /sys/kernel/dyn_fsync/Dyn_fsync_active ]; then
 $B echo "Dynamic fsync detected. Activating.." >> $LOG
 $B echo "1" > /sys/kernel/dyn_fsync/Dyn_fsync_active
fi;
if [ -e /sys/class/misc/fsynccontrol/fsync_enabled ]; then
 $B echo "Fsync control detected. Tuning.." >> $LOG
 $B echo "0" > /sys/class/misc/fsynccontrol/fsync_enabled
fi;
if [ -e /sys/module/sync/parameters/fsync ]; then
 $B echo "0" > /sys/module/sync/parameters/fsync
 $B echo "Fsync - OFF" >> $LOG
fi;
if [ "$SDK" -le "17" ]; then
 $B echo "Trying to enable Seeder entropy generator.. " >> $LOG
 if [ -e /system/xbin/qrngd ]; then
  $B echo "qrngd detected. Seeder will not be started." >> $LOG
 else
  /system/engine/bin/rngd -t 2 -T 1 -s 256 --fill-watermark=80% | $B tee -a $LOG
  $B sleep 3
  $B echo -8 > /proc/"$(pgrep rngd)"/oom_adj | $B tee -a $LOG
  renice 5 "$(pidof rngd)" | $B tee -a $LOG
  $B echo "Seeder entropy generator activated." >> $LOG
 fi;
fi;
for n in /sys/module/*
do
 if [ -e "$n"/parameters/debug_mask ]; then
  $B echo "Turning debugging OFF.." >> $LOG
  $B echo "0" > "$n"/parameters/debug_mask
 fi;
done;
$B echo "Tuning kernel scheduling.." >> $LOG
$B mount -t debugfs none /sys/kernel/debug | $B tee -a $LOG
$B echo "NO_HRTICK" > /sys/kernel/debug/sched_features
$B echo "NO_CACHE_HOT_BUDDY" > /sys/kernel/debug/sched_features
$B echo "NO_LB_BIAS" > /sys/kernel/debug/sched_features
$B echo "NO_OWNER_SPIN" > /sys/kernel/debug/sched_features
$B echo "NO_START_DEBIT" > /sys/kernel/debug/sched_features
$B echo "NO_GENTLE_FAIR_SLEEPERS" > /sys/kernel/debug/sched_features
$B echo "NO_NORMALIZED_SLEEPERS" > /sys/kernel/debug/sched_features
$B echo "NO_DOUBLE_TICK" > /sys/kernel/debug/sched_features
$B echo "NO_AFFINE_WAKEUPS" > /sys/kernel/debug/sched_features
$B echo "NO_NEXT_BUDDY" > /sys/kernel/debug/sched_features
$B echo "NO_WAKEUP_OVERLAP" > /sys/kernel/debug/sched_features
$B echo 0 > /sys/kernel/sched/gentle_fair_sleepers
$B echo "Tuning Android.." >> $LOG
setprop ro.config.nocheckin 1
setprop ro.kernel.android.checkjni 0
setprop ro.kernel.checkjni 0
setprop sys.sysctl.extra_free_kbytes $EF
setprop profiler.force_disable_err_rpt 1
setprop profiler.force_disable_ulog 1
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] 005 - ***Kernel gear*** - OK" >> $LOG
sync;
