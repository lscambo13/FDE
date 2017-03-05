#!/system/bin/sh
### FeraDroid Engine v0.25 | By FeraVolt.2017###
B=/system/engine/bin/busybox;
TIME=$($B date | $B awk '{ print $4 }');
RAM=$($B free -m | $B awk '{ print $2 }' | $B sed -n 2p);
CPU=$($B cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq);
FM=$((RAM*(64 + 1)));
FK=$(((RAM*10) - 2699));
EF=$(((RAM*11) - 2966));
$B echo "[$TIME] ***Kernel gear***";
if [ "$EF" -gt "18432" ]; then
 EF=18432;
elif [ "$EF" -le "4096" ]; then
 EF=4096;
fi;
if [ "$FK" -gt "12288" ]; then
 FK=12288;
elif [ "$FK" -le "3072" ]; then
 FK=5120;
fi;
$B echo "Applying optimized kernel parameters..";
if [ -e /proc/sys/kernel/random/read_wakeup_threshold ]; then
 $B echo "1365" > /proc/sys/kernel/random/read_wakeup_threshold;
 $B echo "kernel.random.read_wakeup_threshold=1365" >> /system/etc/sysctl.conf;
 $B sysctl -e -w kernel.random.read_wakeup_threshold=1365;
fi;
if [ -e /proc/sys/kernel/random/write_wakeup_threshold ]; then
 $B echo "2730" > /proc/sys/kernel/random/write_wakeup_threshold;
 $B echo "kernel.random.write_wakeup_threshold=2730" >> /system/etc/sysctl.conf;
 $B sysctl -e -w kernel.random.write_wakeup_threshold=2730;
fi;
if [ -e /proc/sys/vm/vfs_cache_pressure ]; then
 $B echo "75" > /proc/sys/vm/vfs_cache_pressure;
 $B echo "vm.vfs_cache_pressure=75" >> /system/etc/sysctl.conf;
 $B sysctl -e -w vm.vfs_cache_pressure=75;
fi;
if [ -e /proc/sys/vm/min_free_kbytes ]; then
 $B echo "$FK" > /proc/sys/vm/min_free_kbytes;
 $B echo "vm.min_free_kbytes=$FK" >> /system/etc/sysctl.conf;
 $B sysctl -e -w vm.min_free_kbytes=$FK;
fi;
if [ -e /proc/sys/vm/extra_free_kbytes ]; then
 $B echo "$EF" > /proc/sys/vm/extra_free_kbytes;
 $B echo "vm.extra_free_kbytes=$EF" >> /system/etc/sysctl.conf;
 $B sysctl -e -w vm.extra_free_kbytes=$EF;
fi;
if [ -e /proc/sys/vm/drop_caches ]; then
 $B echo "3" > /proc/sys/vm/drop_caches;
 $B echo "vm.drop_caches=3" >> /system/etc/sysctl.conf;
 $B sysctl -e -w vm.drop_caches=3;
fi;
if [ -e /proc/sys/vm/oom_kill_allocating_task ]; then
 $B echo "0" > /proc/sys/vm/oom_kill_allocating_task;
 $B echo "vm.oom_kill_allocating_task=0" >> /system/etc/sysctl.conf;
 $B sysctl -e -w vm.oom_kill_allocating_task=0;
fi;
if [ -e /proc/sys/vm/dirty_ratio ]; then
 if [ "RAM" -ge "3600" ]; then
  $B echo "20" > /proc/sys/vm/dirty_ratio;
  $B echo "vm.dirty_ratio=20" >> /system/etc/sysctl.conf;
  $B sysctl -e -w vm.dirty_ratio=20;
 elif [ "RAM" -ge "2600" ]; then
  $B echo "25" > /proc/sys/vm/dirty_ratio;
  $B echo "vm.dirty_ratio=25" >> /system/etc/sysctl.conf;
  $B sysctl -e -w vm.dirty_ratio=25;
 else
  $B echo "30" > /proc/sys/vm/dirty_ratio;
  $B echo "vm.dirty_ratio=30" >> /system/etc/sysctl.conf;
  $B sysctl -e -w vm.dirty_ratio=30;
 fi;
fi;
if [ -e /proc/sys/vm/dirty_background_ratio ]; then
 $B echo "4" > /proc/sys/vm/dirty_background_ratio;
 $B echo "vm.dirty_background_ratio=4" >> /system/etc/sysctl.conf;
 $B sysctl -e -w vm.dirty_background_ratio=4;
fi;
if [ -e /proc/sys/vm/dirty_writeback_centisecs ]; then
 $B echo "0" > /proc/sys/vm/dirty_writeback_centisecs;
 $B echo "vm.dirty_writeback_centisecs=0" >> /system/etc/sysctl.conf;
 $B sysctl -e -w vm.dirty_writeback_centisecs=0;
fi;
if [ -e /proc/sys/vm/dirty_expire_centisecs ]; then
 $B echo "0" > /proc/sys/vm/dirty_expire_centisecs;
 $B echo "vm.dirty_expire_centisecs=0" >> /system/etc/sysctl.conf;
 $B sysctl -e -w vm.dirty_expire_centisecs=0;
fi;
if [ -e /proc/sys/vm/panic_on_oom ]; then
 $B echo "0" > /proc/sys/vm/panic_on_oom;
 $B echo "vm.panic_on_oom=0" >> /system/etc/sysctl.conf;
 $B sysctl -e -w vm.panic_on_oom=0;
fi;
if [ -e /proc/sys/vm/overcommit_memory ]; then
 $B echo "1" > /proc/sys/vm/overcommit_memory;
 $B echo "vm.overcommit_memory=1" >> /system/etc/sysctl.conf;
 $B sysctl -e -w vm.overcommit_memory=1;
fi;
if [ -e /proc/sys/vm/laptop_mode ]; then
 if [ "$CPU" -ge "1800000" ]; then
  $B echo "2" > /proc/sys/vm/laptop_mode;
  $B echo "vm.laptop_mode=2" >> /system/etc/sysctl.conf;
  $B sysctl -e -w vm.laptop_mode=2;
 else
  $B echo "1" > /proc/sys/vm/laptop_mode;
  $B echo "vm.laptop_mode=1" >> /system/etc/sysctl.conf;
  $B sysctl -e -w vm.laptop_mode=1;
 fi;
fi;
if [ -e /proc/sys/vm/block_dump ]; then
 $B echo "0" > /proc/sys/vm/block_dump;
 $B echo "vm.block_dump=0" >> /system/etc/sysctl.conf;
 $B sysctl -e -w vm.block_dump=0;
fi;
if [ -e /proc/sys/vm/oom_dump_tasks ]; then
 $B echo "0" > /proc/sys/vm/oom_dump_tasks;
 $B echo "vm.oom_dump_tasks=0" >> /system/etc/sysctl.conf;
 $B sysctl -e -w vm.oom_dump_tasks=0;
fi;
if [ -e /proc/sys/vm/min_free_order_shift ]; then
 $B echo "4" > /proc/sys/vm/min_free_order_shift;
 $B echo "vm.min_free_order_shift=4" >> /system/etc/sysctl.conf;
 $B sysctl -e -w vm.min_free_order_shift=4;
fi;
if [ -e /proc/sys/vm/page-cluster ]; then
 $B echo "1" > /proc/sys/vm/page -cluster;
 $B echo "vm.page-cluster=1" >> /system/etc/sysctl.conf;
 $B sysctl -e -w vm.page-cluster=1;
fi;
if [ -e /proc/sys/vm/scan_unevictable_pages ]; then
 $B echo "0" > /proc/sys/vm/scan_unevictable_pages;
 $B echo "vm.scan_unevictable_pages=0" >> /system/etc/sysctl.conf;
 $B sysctl -e -w vm.scan_unevictable_pages=0;
fi;
if [ -e /proc/sys/vm/highmem_is_dirtyable ]; then
 $B echo "1" > /proc/sys/vm/highmem_is_dirtyable;
 $B echo "vm.highmem_is_dirtyable=1" >> /system/etc/sysctl.conf;
 $B sysctl -e -w vm.highmem_is_dirtyable=1;
fi;
if [ -e /proc/sys/fs/file-max ]; then
 $B echo "$FM" > /proc/sys/fs/file -max;
 $B echo "fs.file-max=$FM" >> /system/etc/sysctl.conf;
 $B sysctl -e -w fs.file-max=$FM;
fi;
if [ -e /proc/sys/fs/leases-enable ]; then
 $B echo "1" > /proc/sys/fs/leases -enable;
 $B echo "fs.leases-enable=1" >> /system/etc/sysctl.conf;
 $B sysctl -e -w fs.leases-enable=1;
fi;
if [ -e /proc/sys/fs/lease-break-time ]; then
 $B echo "9" > /proc/sys/fs/lease-break-time;
 $B echo "fs.lease-break-time=9" >> /system/etc/sysctl.conf;
 $B sysctl -e -w fs.lease-break-time=9;
fi;
if [ -e /proc/sys/fs/inotify/max_queued_events ]; then
 $B echo "32768" > /proc/sys/fs/inotify/max_queued_events;
 $B echo "fs.inotify.max_queued_events=32768" >> /system/etc/sysctl.conf;
 $B sysctl -e -w fs.inotify.max_queued_events=32768;
fi;
if [ -e /proc/sys/fs/inotify/max_user_instances ]; then
 $B echo "256" > /proc/sys/fs/inotify/max_user_instances;
 $B echo "fs.inotify.max_user_instances=256" >> /system/etc/sysctl.conf;
 $B sysctl -e -w fs.inotify.max_user_instances=256;
fi;
if [ -e /proc/sys/fs/inotify/max_user_watches ]; then
 $B echo "16384" > /proc/sys/fs/inotify/max_user_watches;
 $B echo "fs.inotify.max_user_watches=16384" >> /system/etc/sysctl.conf;
 $B sysctl -e -w fs.inotify.max_user_watches=16384;
fi;
if [ -e /proc/sys/kernel/randomize_va_space ]; then
 $B echo "2" > /proc/sys/kernel/randomize_va_space;
 $B echo "kernel.randomize_va_space=2" >> /system/etc/sysctl.conf;
 $B sysctl -e -w kernel.randomize_va_space=2;
fi;
if [ -e /proc/sys/kernel/softlockup_panic ]; then
 $B echo "0" > /proc/sys/kernel/softlockup_panic;
 $B echo "kernel.softlockup_panic=0" >> /system/etc/sysctl.conf;
 $B sysctl -e -w kernel.softlockup_panic=0;
fi;
if [ -e /proc/sys/kernel/hung_task_timeout_secs ]; then
 $B echo "0" > /proc/sys/kernel/hung_task_timeout_secs;
 $B echo "kernel.hung_task_timeout_secs=0" >> /system/etc/sysctl.conf;
 $B sysctl -e -w kernel.hung_task_timeout_secs=0;
fi;
if [ -e /proc/sys/kernel/panic ]; then
 $B echo "0" > /proc/sys/kernel/panic;
 $B echo "kernel.panic=0" >> /system/etc/sysctl.conf;
 $B sysctl -e -w kernel.panic=0;
fi;
if [ -e /proc/sys/kernel/panic_on_oops ]; then
 $B echo "0" > /proc/sys/kernel/panic_on_oops;
 $B echo "kernel.panic_on_oops=0" >> /system/etc/sysctl.conf;
 $B sysctl -e -w kernel.panic_on_oops=0;
fi;
if [ -e /proc/sys/kernel/nmi_watchdog ]; then
 $B echo "0" > /proc/sys/kernel/nmi_watchdog;
 $B echo "kernel.nmi_watchdog=0" >> /system/etc/sysctl.conf;
 $B sysctl -e -w kernel.nmi_watchdog=0;
fi;
$B echo "Tuning kernel scheduling..";
if [ -e /sys/kernel/debug/sched_features ]; then
 $B echo "Sched feautres tuning..";
 $B echo "NO_GENTLE_FAIR_SLEEPERS" > /sys/kernel/debug/sched_features;
 $B echo "NO_AFFINE_WAKEUPS" > /sys/kernel/debug/sched_features;
 $B echo "NO_WAKEUP_OVERLAP" > /sys/kernel/debug/sched_features;
 $B echo "NO_WAKEUP_PREEMPT" > /sys/kernel/debug/sched_features;
 $B echo "NO_DOUBLE_TICK" > /sys/kernel/debug/sched_features;
fi;
if [ -e /sys/kernel/sched/gentle_fair_sleepers ]; then
 $B echo "Sleepers tuning..";
 $B echo "0" > /sys/kernel/sched/gentle_fair_sleepers;
fi;
$B echo "Tuning big-little kernel scheduling..";
if [ -e /proc/sys/kernel/sched_window_stats_policy ]; then
 $B echo "3" > /proc/sys/kernel/sched_window_stats_policy;
fi;
if [ -e /proc/sys/kernel/sched_ravg_hist_size ]; then
 $B echo "3" > /proc/sys/kernel/sched_ravg_hist_size;
fi;
if [ -e /proc/sys/kernel/sched_spill_load ]; then
 $B echo "96" > /proc/sys/kernel/sched_spill_load;
fi;
if [ -e /proc/sys/kernel/sched_spill_nr_run ]; then
 $B echo "9" > /proc/sys/kernel/sched_spill_nr_run;
fi;
if [ -e /proc/sys/kernel/sched_upmigrate ]; then
 $B echo "90" > /proc/sys/kernel/sched_upmigrate;
fi;
if [ -e /proc/sys/kernel/sched_downmigrate ]; then
 $B echo "70" > /proc/sys/kernel/sched_downmigrate;
fi;
if [ -e /proc/sys/kernel/sched_heavy_task ]; then
 $B echo "90" > /proc/sys/kernel/sched_heavy_task;
fi;
if [ -e /proc/sys/kernel/sched_init_task_load ]; then
 $B echo "30" > /proc/sys/kernel/sched_init_task_load;
fi;
if [ -e /proc/sys/kernel/sched_enable_power_aware ]; then
 $B echo "1" > /proc/sys/kernel/sched_enable_power_aware;
fi;
if [ -e /proc/sys/kernel/sched_upmigrate_min_nice ]; then
 $B echo "9" > /proc/sys/kernel/sched_upmigrate_min_nice;
fi;
if [ -e /proc/sys/kernel/sched_small_wakee_task_load ]; then
 $B echo "12" > /proc/sys/kernel/sched_small_wakee_task_load;
fi;
if [ -e /proc/sys/kernel/sched_small_task ]; then
 $B echo "12" > /proc/sys/kernel/sched_small_task;
fi;
if [ -e /proc/sys/kernel/sched_wakeup_load_threshold ]; then
 $B echo "110" > /proc/sys/kernel/sched_wakeup_load_threshold;
fi;
if [ -e /proc/sys/kernel/sched_migration_fixup ]; then
 $B echo "1" > /proc/sys/kernel/sched_migration_fixup;
fi;
if [ -e /proc/sys/kernel/sched_boost ]; then
 $B echo "0" > /proc/sys/kernel/sched_boost;
fi;
if [ -e /proc/sys/kernel/sched_min_granularity_ns ]; then
 ABC=$(cat/proc/sys/kernel/sched_latency_ns);
 $B echo "Tuning kernel sched latency..";
 $B echo $((ABC/2)) > /proc/sys/kernel/sched_min_granularity_ns;
fi;
$B echo "950000" > /proc/sys/kernel/sched_rt_runtime_us;
$B echo "1000000" > /proc/sys/kernel/sched_rt_period_us;
if [ -e /sys/kernel/dyn_fsync/Dyn_fsync_active ]; then
 $B echo "Dynamic fsync detected. Activating..";
 $B echo "1" > /sys/kernel/dyn_fsync/Dyn_fsync_active;
fi;
if [ -e /sys/devices/virtual/misc/fsynccontrol/fsync_enabled ]; then
 $B echo "Fsync control detected. Tuning..";
 $B echo "0" > /sys/devices/virtual/misc/fsynccontrol/fsync_enabled;
fi;
if [ -e /sys/class/misc/fsynccontrol/fsync_enabled ]; then
 $B echo "Fsync control detected. Tuning..";
 $B echo "0" > /sys/class/misc/fsynccontrol/fsync_enabled;
fi;
if [ -e /sys/module/sync/parameters/fsync ]; then
 $B echo "0" > /sys/module/sync/parameters/fsync;
 $B echo "Fsync module -OFF";
fi;
if [ -e /sys/module/sync/parameters/fsync_enabled ]; then
 $B echo "0" > /sys/module/sync/parameters/fsync_enabled;
 $B echo "N" > /sys/module/sync/parameters/fsync_enabled;
 $B echo "Fsync module -OFF";
fi;
if [ -e /sys/module/wakelock/parameters/debug_mask ]; then
 $B echo "7" > /sys/module/wakelock/parameters/debug_mask;
 $B echo "Wakelock debugging -OFF";
fi;
if [ -e /system/etc/sprd_monitor-user.conf ]; then
 {
  $B echo "sysdump off"
  $B echo "coredump off"
  $B echo "hprofs off"
  $B echo "hw-watchdog off"
  $B echo "res-monitor off"
  $B echo "oprofile off"
  $B echo "" 
 } >> /system/etc/sprd_monitor-user.conf;
 {
 $B echo "sysdump off"
 $B echo "coredump off"
 $B echo "hprofs off"
 $B echo "hw-watchdog off"
 $B echo "res-monitor off"
 $B echo "oprofile off"
 $B echo ""
 } >> /system/etc/sprd_monitor-userdebug.conf;
 $B echo "SPRD monitor tuning..";
fi;
if [ -e /system/etc/slog.conf ]; then
 $B sed -e "s=enable=disable=" -i /system/etc/slog.conf;
 $B sed -e "s=enable=disable=" -i /system/etc/slog.conf.user;
 $B echo "Slog conf tuning..";
fi;
if [ -e /sys/module/logger/parameters/log_mode ]; then
 $B echo "2" > /sys/module/logger/parameters/log_mode;
 $B echo "Disable Android logger..";
fi;
if [ -e /sys/module/sit/parameters/log_ecn_error ]; then
 $B echo "0" > /sys/module/sit/parameters/log_ecn_error;
 $B echo "SIT log OFF.";
fi;
$B echo "Turning debugging OFF..";
for n in /sys/module/*;
do
 if [ -e "$n"/parameters/debug_mask ]; then
  $B echo "0" > "$n"/parameters/debug_mask;
  $B echo "0" > "$n"/parameters/debug;
  $B echo "N" > "$n"/parameters/debug;
 fi;
done;
$B echo "Tuning Android..";
setprop ro.config.nocheckin 1;
setprop ro.kernel.android.checkjni 0;
setprop ro.kernel.checkjni 0;
setprop sys.sysctl.extra_free_kbytes $EF;
setprop profiler.launch false;
setprop profiler.force_disable_err_rpt 1;
setprop profiler.force_disable_ulog 1;
setprop profiler.debugmonitor false;
setprop profiler.hung.dumpdobugreport false;
setprop logcat.live disable;
setprop debugtool.anrhistory 0;
setprop ro.vold.umsdirtyratio 30
TIME=$($B date | $B awk '{ print $4 }');
$B echo "[$TIME] ***Kernel gear*** -OK";
sync;
