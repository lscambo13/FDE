#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2016 ###

B=/system/engine/bin/busybox
LOG=/sdcard/Android/FDE.txt
TIME=$($B date | $B awk '{ print $4 }')

$B echo "[$TIME] 005 - ***Kernel gear***" >> $LOG
$B echo "" >> $LOG
RAM=$($B free -m | $B awk '{ print $2 }' | $B sed -n 2p)
FM=$((RAM*64))

$B echo " Writing optimized kernel parameters to sysfs.." >> $LOG
$B echo 1536 > /proc/sys/kernel/random/read_wakeup_threshold
$B echo 256 > /proc/sys/kernel/random/write_wakeup_threshold
$B echo 50 > /proc/sys/vm/vfs_cache_pressure
$B echo 4096 > /proc/sys/vm/min_free_kbytes
$B echo 4096 > /proc/sys/vm/extra_free_kbytes
$B echo 3 > /proc/sys/vm/drop_caches
$B echo 1 > /proc/sys/vm/oom_kill_allocating_task
$B echo 90 > /proc/sys/vm/dirty_ratio
$B echo 15 > /proc/sys/vm/dirty_background_ratio
$B echo 3600 > /proc/sys/vm/dirty_writeback_centisecs
$B echo 600 > /proc/sys/vm/dirty_expire_centisecs
$B echo 0 > /proc/sys/vm/panic_on_oom
$B echo 1 > /proc/sys/vm/overcommit_memory
$B echo 100 > /proc/sys/vm/overcommit_ratio
$B echo 0 > /proc/sys/vm/laptop_mode
$B echo 0 > /proc/sys/vm/block_dump
$B echo 0 > /proc/sys/vm/oom_dump_tasks
$B echo 4 > /proc/sys/vm/min_free_order_shift
$B echo $FM > /proc/sys/fs/file-max
$B echo 1 > /proc/sys/fs/leases-enable
$B echo 10 > /proc/sys/fs/lease-break-time
$B echo 2 > /proc/sys/kernel/randomize_va_space
$B echo 0 > /proc/sys/kernel/softlockup_panic
$B echo 0 > /proc/sys/kernel/hung_task_timeout_secs
$B echo 0 > /proc/sys/kernel/panic_on_oops
$B echo 0 > /proc/sys/kernel/panic
$B echo " Writing optimized kernel parameters to sysctl.." >> $LOG
$B echo "kernel.random.read_wakeup_threshold=1536" >> /system/etc/sysctl.conf
$B echo "kernel.random.write_wakeup_threshold=256" >> /system/etc/sysctl.conf
$B echo "vm.vfs_cache_pressure=50" >> /system/etc/sysctl.conf
$B echo "vm.min_free_kbytes=4096" >> /system/etc/sysctl.conf
$B echo "vm.extra_free_kbytes=4096" >> /system/etc/sysctl.conf
$B echo "vm.drop_caches=3" >> /system/etc/sysctl.conf
$B echo "vm.oom_kill_allocating_task=1" >> /system/etc/sysctl.conf
$B echo "vm.dirty_ratio=90" >> /system/etc/sysctl.conf
$B echo "vm.dirty_background_ratio=15" >> /system/etc/sysctl.conf
$B echo "vm.dirty_writeback_centisecs=3600" >> /system/etc/sysctl.conf
$B echo "vm.dirty_expire_centisecs=600" >> /system/etc/sysctl.conf
$B echo "vm.panic_on_oom=0" >> /system/etc/sysctl.conf
$B echo "vm.overcommit_memory=1" >> /system/etc/sysctl.conf
$B echo "vm.overcommit_ratio=100" >> /system/etc/sysctl.conf
$B echo "vm.laptop_mode=0" >> /system/etc/sysctl.conf
$B echo "vm.block_dump=0" >> /system/etc/sysctl.conf
$B echo "vm.oom_dump_tasks=0" >> /system/etc/sysctl.conf
$B echo "vm.min_free_order_shift=4" >> /system/etc/sysctl.conf
$B echo "fs.file-max=$FM" >> /system/etc/sysctl.conf
$B echo "fs.leases-enable=1" >> /system/etc/sysctl.conf
$B echo "fs.lease-break-time=10" >> /system/etc/sysctl.conf
$B echo "kernel.randomize_va_space=2" >> /system/etc/sysctl.conf
$B echo "kernel.sched_compat_yield=1" >> /system/etc/sysctl.conf
$B echo "kernel.scan_unevictable_pages=0" >> /system/etc/sysctl.conf
$B echo "kernel.hung_task_timeout_secs=0" >> /system/etc/sysctl.conf
$B echo "kernel.panic=0" >> /system/etc/sysctl.conf
$B echo "kernel.panic_on_oops=0" >> /system/etc/sysctl.conf
$B echo "kernel.softlockup_panic=0" >> /system/etc/sysctl.conf
$B echo " Executing optimized kernel parameters via sysctl.." >> $LOG
$B sysctl -e -w kernel.random.read_wakeup_threshold=1536
$B sysctl -e -w kernel.random.write_wakeup_threshold=256
$B sysctl -e -w vm.vfs_cache_pressure=50
$B sysctl -e -w vm.min_free_kbytes=4096
$B sysctl -e -w vm.extra_free_kbytes=4096
$B sysctl -e -w vm.drop_caches=3
$B sysctl -e -w vm.oom_kill_allocating_task=1
$B sysctl -e -w vm.dirty_ratio=90
$B sysctl -e -w vm.dirty_background_ratio=15
$B sysctl -e -w vm.dirty_writeback_centisecs=3600
$B sysctl -e -w vm.dirty_expire_centisecs=600
$B sysctl -e -w vm.panic_on_oom=0
$B sysctl -e -w vm.overcommit_memory=1
$B sysctl -e -w vm.overcommit_ratio=100
$B sysctl -e -w vm.laptop_mode=0
$B sysctl -e -w vm.block_dump=0
$B sysctl -e -w vm.oom_dump_tasks=0
$B sysctl -e -w vm.min_free_order_shift=4
$B sysctl -e -w fs.file-max=$FM
$B sysctl -e -w fs.leases-enable=1
$B sysctl -e -w fs.lease-break-time=10
$B sysctl -e -w kernel.randomize_va_space=2
$B sysctl -e -w kernel.sched_compat_yield=1
$B sysctl -e -w kernel.scan_unevictable_pages=0
$B sysctl -e -w kernel.hung_task_timeout_secs=0
$B sysctl -e -w kernel.panic=0
$B sysctl -e -w kernel.panic_on_oops=0
$B sysctl -e -w kernel.softlockup_panic=0

if [ -e /sys/kernel/dyn_fsync/Dyn_fsync_active ]; then
 $B echo " Dynamic fsync detected. Activating.." >> $LOG
 $B echo "1" > /sys/kernel/dyn_fsync/Dyn_fsync_active
fi;

$B echo " Tuning kernel scheduling.." >> $LOG
$B mount -t debugfs none /sys/kernel/debug;
$B echo "NO_HRTICK" > /sys/kernel/debug/sched_features
$B echo "NO_CACHE_HOT_BUDDY" > /sys/kernel/debug/sched_features
$B echo "NO_LB_BIAS" > /sys/kernel/debug/sched_features
$B echo "NO_OWNER_SPIN" > /sys/kernel/debug/sched_features
$B echo "NO_START_DEBIT" > /sys/kernel/debug/sched_features
$B echo "NO_NEW_FAIR_SLEEPERS" > /sys/kernel/debug/sched_features
$B echo "NO_NORMALIZED_SLEEPERS" > /sys/kernel/debug/sched_features
$B echo "NO_DOUBLE_TICK" > /sys/kernel/debug/sched_features
$B echo "NO_AFFINE_WAKEUPS" > /sys/kernel/debug/sched_features
$B echo "NO_NEXT_BUDDY" > /sys/kernel/debug/sched_features
$B echo "NO_WAKEUP_OVERLAP" > /sys/kernel/debug/sched_features
$B echo " Tuning Android.." >> $LOG
setprop ro.config.nocheckin 1
setprop ro.kernel.android.checkjni 0
setprop ro.kernel.checkjni 0
setprop persist.service.lgospd.enable false
setprop persist.service.pcsync.enable false
setprop touch.presure.scale 0.001
$B echo "" >> $LOG
$B echo "[$TIME] 005 - ***Kernel gear*** - OK" >> $LOG
sync;

