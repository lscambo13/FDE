#!/system/bin/sh
### FeraDroid Engine v0.21 | By FeraVolt. 2016 ###
B=/system/engine/bin/busybox
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] ***Kernel gear***"
RAM=$($B free -m | $B awk '{ print $2 }' | $B sed -n 2p)
FM=$((RAM*(64+1)))
ME=$((RAM*27))
if [ "$RAM" -le "512" ]; then
 DR=24
else
 DR=36
fi;
FK=$((RAM*2*1024/100))
EF=$(((RAM*3*1024/100)-2048))
if [ "$EF" -gt "24576" ]; then
 EF=24576
fi;
if [ "$FK" -gt "18432" ]; then
 FK=18432
fi;
MALL=$((RAM*192))
MMAX=$((MALL*4096))
if [ "$MMAX" -le "268435456" ]; then
 MMAX=268435456
fi;
if [ "$RAM" -le "2048" ]; then
 LM=1
else
 LM=2
fi;
$B mount -o remount,rw /system
$B echo "Applying optimized kernel parameters.."
if [ -e /proc/sys/kernel/random/read_wakeup_threshold ]; then
 $B echo 1536 > /proc/sys/kernel/random/read_wakeup_threshold
 $B echo "kernel.random.read_wakeup_threshold=1536" >> /system/etc/sysctl.conf
 $B sysctl -e -w kernel.random.read_wakeup_threshold=1536
fi;
if [ -e /proc/sys/kernel/random/write_wakeup_threshold ]; then
 $B echo 256 > /proc/sys/kernel/random/write_wakeup_threshold
 $B echo "kernel.random.write_wakeup_threshold=256" >> /system/etc/sysctl.conf
 $B sysctl -e -w kernel.random.write_wakeup_threshold=256
fi;
if [ -e /proc/sys/vm/vfs_cache_pressure ]; then
 $B echo 100 > /proc/sys/vm/vfs_cache_pressure
 $B echo "vm.vfs_cache_pressure=100" >> /system/etc/sysctl.conf
 $B sysctl -e -w vm.vfs_cache_pressure=100
fi;
if [ -e /proc/sys/vm/min_free_kbytes ]; then
 $B echo $FK > /proc/sys/vm/min_free_kbytes
 $B echo "vm.min_free_kbytes=$FK" >> /system/etc/sysctl.conf
 $B sysctl -e -w vm.min_free_kbytes=$FK
fi;
if [ -e /proc/sys/vm/extra_free_kbytes ]; then
 $B echo $EF > /proc/sys/vm/extra_free_kbytes
 $B echo "vm.extra_free_kbytes=$EF" >> /system/etc/sysctl.conf
 $B sysctl -e -w vm.extra_free_kbytes=$EF
fi;
if [ -e /proc/sys/vm/compact_memory ]; then
 $B echo 1 > /proc/sys/vm/compact_memory
 $B echo "vm.compact_memory=1" >> /system/etc/sysctl.conf
 $B sysctl -e -w vm.compact_memory=1
fi;
if [ -e /proc/sys/vm/compact_unevictable_allowed ]; then
 $B echo 1 > /proc/sys/vm/compact_unevictable_allowed
 $B echo "vm.compact_unevictable_allowed=1" >> /system/etc/sysctl.conf
 $B sysctl -e -w vm.compact_unevictable_allowed=1
fi;
if [ -e /proc/sys/vm/drop_caches ]; then
 $B echo 3 > /proc/sys/vm/drop_caches
 $B echo "vm.drop_caches=3" >> /system/etc/sysctl.conf
 $B sysctl -e -w vm.drop_caches=3
fi;
if [ -e /proc/sys/vm/oom_kill_allocating_task ]; then
 $B echo 1 > /proc/sys/vm/oom_kill_allocating_task
 $B echo "vm.oom_kill_allocating_task=1" >> /system/etc/sysctl.conf
 $B sysctl -e -w vm.oom_kill_allocating_task=1
fi;
if [ -e /proc/sys/vm/dirty_ratio ]; then
 $B echo $DR > /proc/sys/vm/dirty_ratio
 $B echo "vm.dirty_ratio=$DR" >> /system/etc/sysctl.conf
 $B sysctl -e -w vm.dirty_ratio=$DR
fi;
if [ -e /proc/sys/vm/dirty_background_ratio ]; then
 $B echo 5 > /proc/sys/vm/dirty_background_ratio
 $B echo "vm.dirty_background_ratio=5" >> /system/etc/sysctl.conf
 $B sysctl -e -w vm.dirty_background_ratio=5
fi;
if [ -e /proc/sys/vm/dirty_writeback_centisecs ]; then
 $B echo 0 > /proc/sys/vm/dirty_writeback_centisecs
 $B echo "vm.dirty_writeback_centisecs=0" >> /system/etc/sysctl.conf
 $B sysctl -e -w vm.dirty_writeback_centisecs=0
fi;
if [ -e /proc/sys/vm/dirty_expire_centisecs ]; then
 $B echo 0 > /proc/sys/vm/dirty_expire_centisecs
 $B echo "vm.dirty_expire_centisecs=0" >> /system/etc/sysctl.conf
 $B sysctl -e -w vm.dirty_expire_centisecs=0
fi;
if [ -e /proc/sys/vm/panic_on_oom ]; then
 $B echo 0 > /proc/sys/vm/panic_on_oom
 $B echo "vm.panic_on_oom=0" >> /system/etc/sysctl.conf
 $B sysctl -e -w vm.panic_on_oom=0
fi;
if [ -e /proc/sys/vm/overcommit_memory ]; then
 $B echo 1 > /proc/sys/vm/overcommit_memory
 $B echo "vm.overcommit_memory=1" >> /system/etc/sysctl.conf
 $B sysctl -e -w vm.overcommit_memory=1
fi;
if [ -e /proc/sys/vm/overcommit_ratio ]; then
 $B echo 100 > /proc/sys/vm/overcommit_ratio
 $B echo "vm.overcommit_ratio=100" >> /system/etc/sysctl.conf
 $B sysctl -e -w vm.overcommit_ratio=100
fi;
if [ -e /proc/sys/vm/laptop_mode ]; then
 $B echo $LM > /proc/sys/vm/laptop_mode
 $B echo "vm.laptop_mode=$LM" >> /system/etc/sysctl.conf
 $B sysctl -e -w vm.laptop_mode=$LM
fi;
if [ -e /proc/sys/vm/block_dump ]; then
 $B echo 0 > /proc/sys/vm/block_dump
 $B echo "vm.block_dump=0" >> /system/etc/sysctl.conf
 $B sysctl -e -w vm.block_dump=0
fi;
if [ -e /proc/sys/vm/oom_dump_tasks ]; then
 $B echo 0 > /proc/sys/vm/oom_dump_tasks
 $B echo "vm.oom_dump_tasks=0" >> /system/etc/sysctl.conf
 $B sysctl -e -w vm.oom_dump_tasks=0
fi;
if [ -e /proc/sys/vm/min_free_order_shift ]; then
 $B echo 4 > /proc/sys/vm/min_free_order_shift
 $B echo "vm.min_free_order_shift=4" >> /system/etc/sysctl.conf
 $B sysctl -e -w vm.min_free_order_shift=4
fi;
if [ -e /proc/sys/vm/page-cluster ]; then
 $B echo 1 > /proc/sys/vm/page-cluster
 $B echo "vm.page-cluster=1" >> /system/etc/sysctl.conf
 $B sysctl -e -w vm.page-cluster=1
fi;
if [ -e /proc/sys/vm/scan_unevictable_pages ]; then
 $B echo 0 > /proc/sys/vm/scan_unevictable_pages
 $B echo "vm.scan_unevictable_pages=0" >> /system/etc/sysctl.conf
 $B sysctl -e -w vm.scan_unevictable_pages=0
fi;
if [ -e /proc/sys/vm/highmem_is_dirtyable ]; then
 $B echo 0 > /proc/sys/vm/highmem_is_dirtyable
 $B echo "vm.highmem_is_dirtyable=0" >> /system/etc/sysctl.conf
 $B sysctl -e -w vm.highmem_is_dirtyable=0
fi;
if [ -e /proc/sys/fs/file-max ]; then
 $B echo $FM > /proc/sys/fs/file-max
 $B echo "fs.file-max=$FM" >> /system/etc/sysctl.conf
 $B sysctl -e -w fs.file-max=$FM
fi;
if [ -e /proc/sys/fs/leases-enable ]; then
 $B echo 1 > /proc/sys/fs/leases-enable
 $B echo "fs.leases-enable=1" >> /system/etc/sysctl.conf
 $B sysctl -e -w fs.leases-enable=1
fi;
if [ -e /proc/sys/fs/lease-break-time ]; then
 $B echo 9 > /proc/sys/fs/lease-break-time
 $B echo "fs.lease-break-time=9" >> /system/etc/sysctl.conf
 $B sysctl -e -w fs.lease-break-time=9
fi;
if [ -e /proc/sys/fs/inotify/max_queued_events ]; then
 $B echo $ME > /proc/sys/fs/inotify/max_queued_events
 $B echo "fs.inotify.max_queued_events=$ME" >> /system/etc/sysctl.conf
 $B sysctl -e -w fs.inotify.max_queued_events=$ME
fi;
if [ -e /proc/sys/fs/inotify/max_user_instances ]; then
 $B echo 256 > /proc/sys/fs/inotify/max_user_instances
 $B echo "fs.inotify.max_user_instances=256" >> /system/etc/sysctl.conf
 $B sysctl -e -w fs.inotify.max_user_instances=256
fi;
if [ -e /proc/sys/fs/inotify/max_user_watches ]; then
 $B echo 16384 > /proc/sys/fs/inotify/max_user_watches
 $B echo "fs.inotify.max_user_watches=16384" >> /system/etc/sysctl.conf
 $B sysctl -e -w fs.inotify.max_user_watches=16384
fi;
if [ -e /proc/sys/kernel/randomize_va_space ]; then
 $B echo 2 > /proc/sys/kernel/randomize_va_space
 $B echo "kernel.randomize_va_space=2" >> /system/etc/sysctl.conf
 $B sysctl -e -w kernel.randomize_va_space=2
fi;
if [ -e /proc/sys/kernel/softlockup_panic ]; then
 $B echo 0 > /proc/sys/kernel/softlockup_panic
 $B echo "kernel.softlockup_panic=0" >> /system/etc/sysctl.conf
 $B sysctl -e -w kernel.softlockup_panic=0
fi;
if [ -e /proc/sys/kernel/hung_task_timeout_secs ]; then
 $B echo 0 > /proc/sys/kernel/hung_task_timeout_secs
 $B echo "kernel.hung_task_timeout_secs=0" >> /system/etc/sysctl.conf
 $B sysctl -e -w kernel.hung_task_timeout_secs=0
fi;
if [ -e /proc/sys/kernel/panic ]; then
 $B echo 0 > /proc/sys/kernel/panic
 $B echo "kernel.panic=0" >> /system/etc/sysctl.conf
 $B sysctl -e -w kernel.panic=0
fi;
if [ -e /proc/sys/kernel/panic_on_oops ]; then
 $B echo 0 > /proc/sys/kernel/panic_on_oops
 $B echo "kernel.panic_on_oops=0" >> /system/etc/sysctl.conf
 $B sysctl -e -w kernel.panic_on_oops=0
fi;
if [ -e /proc/sys/kernel/shmmni ]; then
 $B echo 4096 > /proc/sys/kernel/shmmni
 $B echo "kernel.shmmni=4096" >> /system/etc/sysctl.conf
 $B sysctl -e -w kernel.shmmni=4096
fi;
if [ -e /proc/sys/kernel/shmall ]; then
 $B echo $MALL > /proc/sys/kernel/shmall
 $B echo "kernel.shmall=$MALL" >> /system/etc/sysctl.conf
 $B sysctl -e -w kernel.shmall=$MALL
fi;
if [ -e /proc/sys/kernel/shmmax ]; then
 $B echo $MMAX > /proc/sys/kernel/shmmax
 $B echo "kernel.shmmax=$MMAX" >> /system/etc/sysctl.conf
 $B sysctl -e -w kernel.shmmax=$MMAX
fi;
if [ -e /proc/sys/kernel/msgmni ]; then
 $B echo 16384 > /proc/sys/kernel/msgmni
 $B echo "kernel.msgmni=16384" >> /system/etc/sysctl.conf
 $B sysctl -e -w kernel.msgmni=16384
fi;
if [ -e /proc/sys/kernel/msgmax ]; then
 $B echo 8192 > /proc/sys/kernel/msgmax
 $B echo "kernel.msgmax=8192" >> /system/etc/sysctl.conf
 $B sysctl -e -w kernel.msgmax=8192
fi;
if [ -e /proc/sys/kernel/msgmnb ]; then
 $B echo 8192 > /proc/sys/kernel/msgmnb
 $B echo "kernel.msgmnb=8192" >> /system/etc/sysctl.conf
 $B sysctl -e -w kernel.msgmnb=8192
fi;
$B echo "Tuning kernel scheduling.."
$B mount -t debugfs none /sys/kernel/debug
if [ -e /sys/kernel/debug/sched_features ]; then
 $B echo "NO_GENTLE_FAIR_SLEEPERS" > /sys/kernel/debug/sched_features
 $B echo "NO_NEW_FAIR_SLEEPERS" > /sys/kernel/debug/sched_features
 $B echo "NO_NORMALIZED_SLEEPERS" > /sys/kernel/debug/sched_features
 $B echo "NO_AFFINE_WAKEUPS" > /sys/kernel/debug/sched_features
 $B echo "NO_WAKEUP_OVERLAP" > /sys/kernel/debug/sched_features
 $B echo "NO_DOUBLE_TICK" > /sys/kernel/debug/sched_features
fi;
if [ -e /sys/kernel/sched/gentle_fair_sleepers ]; then
 $B echo 0 > /sys/kernel/sched/gentle_fair_sleepers
fi;
if [ -e /sys/kernel/dyn_fsync/Dyn_fsync_active ]; then
 $B echo "Dynamic fsync detected. Activating.."
 $B echo "1" > /sys/kernel/dyn_fsync/Dyn_fsync_active
fi;
if [ -e /sys/devices/virtual/misc/fsynccontrol/fsync_enabled ]; then
 $B echo "Fsync control detected. Tuning.."
 $B echo "0" > /sys/devices/virtual/misc/fsynccontrol/fsync_enabled
fi;
if [ -e /sys/class/misc/fsynccontrol/fsync_enabled ]; then
 $B echo "Fsync control detected. Tuning.."
 $B echo "0" > /sys/class/misc/fsynccontrol/fsync_enabled
fi;
if [ -e /sys/module/sync/parameters/fsync ]; then
 $B echo "0" > /sys/module/sync/parameters/fsync
 $B echo "Fsync module - OFF"
fi;
if [ -e /sys/module/sync/parameters/fsync_enabled ]; then
 $B echo "N" > /sys/module/sync/parameters/fsync_enabled
 $B echo "Fsync module - OFF"
fi;
if [ -e /system/etc/sprd_monitor-user.conf ]; then
 $B echo "sysdump off" > /system/etc/sprd_monitor-user.conf
 $B echo "coredump off" >> /system/etc/sprd_monitor-user.conf
 $B echo "hprofs off" >> /system/etc/sprd_monitor-user.conf
 $B echo "hw-watchdog off" >> /system/etc/sprd_monitor-user.conf
 $B echo "res-monitor off" >> /system/etc/sprd_monitor-user.conf
 $B echo "oprofile off" >> /system/etc/sprd_monitor-user.conf
 $B echo "" >> /system/etc/sprd_monitor-user.conf
 $B echo "sysdump off" > /system/etc/sprd_monitor-userdebug.conf
 $B echo "coredump off" >> /system/etc/sprd_monitor-userdebug.conf
 $B echo "hprofs off" >> /system/etc/sprd_monitor-userdebug.conf
 $B echo "hw-watchdog off" >> /system/etc/sprd_monitor-userdebug.conf
 $B echo "res-monitor off" >> /system/etc/sprd_monitor-userdebug.conf
 $B echo "oprofile off" >> /system/etc/sprd_monitor-userdebug.conf
 $B echo "" >> /system/etc/sprd_monitor-userdebug.conf
 $B echo "SPRD monitor tuning.."
fi;
if [ -e /system/etc/slog.conf ]; then
 $B sed -e "s=enable=disable=" -i /system/etc/slog.conf
 $B sed -e "s=enable=disable=" -i /system/etc/slog.conf.user
 $B echo "Slog conf tuning.."
fi;
if [ -e /sys/module/logger/parameters/log_mode ]; then
 $B echo 2 > /sys/module/logger/parameters/log_mode
 $B echo "Disable Android logger.."
fi;
$B echo "Turning debugging OFF.."
for n in /sys/module/*
do
 if [ -e "$n"/parameters/debug_mask ]; then
  $B echo "0" > "$n"/parameters/debug_mask
 fi;
done;
$B echo "Tuning Android.."
setprop ro.kernel.qemu 0
setprop ro.config.nocheckin 1
setprop ro.kernel.android.checkjni 0
setprop ro.kernel.checkjni 0
setprop sys.sysctl.extra_free_kbytes $EF
setprop profiler.launch false
setprop profiler.force_disable_err_rpt 1
setprop profiler.force_disable_ulog 1
setprop profiler.debugmonitor false
setprop profiler.hung.dumpdobugreport false
setprop logcat.live disable
setprop debugtool.anrhistory 0
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] ***Kernel gear*** - OK"
sync;
