#!/system/bin/sh
### FeraDroid Engine v1.1 | By FeraVolt. 2017 ###
B=/system/engine/bin/busybox;
SCORE=/system/engine/prop/score;
MADMAX=$($B cat /system/engine/raw/FDE_config.txt | $B grep -e 'mad_max=1');
RAM=$($B free -m | $B awk '{ print $2 }' | $B sed -n 2p);
FM=$((RAM*(64 + 1)));
FK=$(((RAM*10) - 2699));
EF=$(((RAM*11) - 2966));
if [ "$EF" -gt "18432" ]; then
 EF=18432;
elif [ "$EF" -le "4096" ]; then
 EF=4096;
fi;
if [ "$FK" -gt "12288" ]; then
 FK=12288;
elif [ "$FK" -le "4096" ]; then
 FK=4096;
fi;
$B echo "Applying optimized kernel parameters..";
if [ -e /proc/sys/kernel/random/read_wakeup_threshold ]; then
 $B echo "1024" > /proc/sys/kernel/random/read_wakeup_threshold;
 $B echo "kernel.random.read_wakeup_threshold=1024" >> /system/etc/sysctl.conf;
 $B sysctl -e -w kernel.random.read_wakeup_threshold=1024;
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/kernel/random/write_wakeup_threshold ]; then
 $B echo "2048" > /proc/sys/kernel/random/write_wakeup_threshold;
 $B echo "kernel.random.write_wakeup_threshold=2048" >> /system/etc/sysctl.conf;
 $B sysctl -e -w kernel.random.write_wakeup_threshold=2048;
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/vm/vfs_cache_pressure ]; then
 if [ "$RAM" -le "512" ]; then
  $B echo "150" > /proc/sys/vm/vfs_cache_pressure;
  $B echo "vm.vfs_cache_pressure=150" >> /system/etc/sysctl.conf;
  $B sysctl -e -w vm.vfs_cache_pressure=150;
 else
 $B echo "100" > /proc/sys/vm/vfs_cache_pressure;
 $B echo "vm.vfs_cache_pressure=100" >> /system/etc/sysctl.conf;
 $B sysctl -e -w vm.vfs_cache_pressure=100;
 fi;
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/vm/min_free_kbytes ]; then
 $B echo "$FK" > /proc/sys/vm/min_free_kbytes;
 $B echo "vm.min_free_kbytes=$FK" >> /system/etc/sysctl.conf;
 $B sysctl -e -w vm.min_free_kbytes=$FK;
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/vm/extra_free_kbytes ]; then
 $B echo "$EF" > /proc/sys/vm/extra_free_kbytes;
 $B echo "vm.extra_free_kbytes=$EF" >> /system/etc/sysctl.conf;
 $B sysctl -e -w vm.extra_free_kbytes=$EF;
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/vm/drop_caches ]; then
 $B echo "3" > /proc/sys/vm/drop_caches;
 $B echo "vm.drop_caches=3" >> /system/etc/sysctl.conf;
 $B sysctl -e -w vm.drop_caches=3;
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/vm/oom_kill_allocating_task ]; then
 $B echo "0" > /proc/sys/vm/oom_kill_allocating_task;
 $B echo "vm.oom_kill_allocating_task=0" >> /system/etc/sysctl.conf;
 $B sysctl -e -w vm.oom_kill_allocating_task=0;
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/vm/dirty_ratio ]; then
 if [ "$RAM" -ge "2600" ]; then
  $B echo "20" > /proc/sys/vm/dirty_ratio;
  $B echo "vm.dirty_ratio=20" >> /system/etc/sysctl.conf;
  $B sysctl -e -w vm.dirty_ratio=20;
 else
  $B echo "27" > /proc/sys/vm/dirty_ratio;
  $B echo "vm.dirty_ratio=27" >> /system/etc/sysctl.conf;
  $B sysctl -e -w vm.dirty_ratio=27;
 fi;
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/vm/dirty_background_ratio ]; then
 $B echo "9" > /proc/sys/vm/dirty_background_ratio;
 $B echo "vm.dirty_background_ratio=9" >> /system/etc/sysctl.conf;
 $B sysctl -e -w vm.dirty_background_ratio=9;
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/vm/dirty_writeback_centisecs ]; then
 $B echo "2000" > /proc/sys/vm/dirty_writeback_centisecs;
 $B echo "vm.dirty_writeback_centisecs=2000" >> /system/etc/sysctl.conf;
 $B sysctl -e -w vm.dirty_writeback_centisecs=2000;
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/vm/dirty_expire_centisecs ]; then
 $B echo "700" > /proc/sys/vm/dirty_expire_centisecs;
 $B echo "vm.dirty_expire_centisecs=700" >> /system/etc/sysctl.conf;
 $B sysctl -e -w vm.dirty_expire_centisecs=700;
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/vm/panic_on_oom ]; then
 $B echo "0" > /proc/sys/vm/panic_on_oom;
 $B echo "vm.panic_on_oom=0" >> /system/etc/sysctl.conf;
 $B sysctl -e -w vm.panic_on_oom=0;
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/vm/overcommit_memory ]; then
 $B echo "1" > /proc/sys/vm/overcommit_memory;
 $B echo "vm.overcommit_memory=1" >> /system/etc/sysctl.conf;
 $B sysctl -e -w vm.overcommit_memory=1;
 $B echo "100" > /proc/sys/vm/overcommit_ratio;
 $B echo "vm.overcommit_ratio=100" >> /system/etc/sysctl.conf;
 $B sysctl -e -w vm.overcommit_ratio=100;
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/vm/laptop_mode ]; then
 if [ "mad_max=1" = "$MADMAX" ]; then
  $B echo "Mad cache.";
  $B echo "3" > /proc/sys/vm/laptop_mode;
  $B echo "vm.laptop_mode=3" >> /system/etc/sysctl.conf;
  $B sysctl -e -w vm.laptop_mode=3;
  $B echo "3" >> $SCORE;
 else
  $B echo "1" > /proc/sys/vm/laptop_mode;
  $B echo "vm.laptop_mode=1" >> /system/etc/sysctl.conf;
  $B sysctl -e -w vm.laptop_mode=1;
  $B echo "1" >> $SCORE;
 fi;
fi;
if [ -e /proc/sys/vm/block_dump ]; then
 $B echo "0" > /proc/sys/vm/block_dump;
 $B echo "vm.block_dump=0" >> /system/etc/sysctl.conf;
 $B sysctl -e -w vm.block_dump=0;
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/vm/oom_dump_tasks ]; then
 $B echo "0" > /proc/sys/vm/oom_dump_tasks;
 $B echo "vm.oom_dump_tasks=0" >> /system/etc/sysctl.conf;
 $B sysctl -e -w vm.oom_dump_tasks=0;
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/vm/min_free_order_shift ]; then
 $B echo "4" > /proc/sys/vm/min_free_order_shift;
 $B echo "vm.min_free_order_shift=4" >> /system/etc/sysctl.conf;
 $B sysctl -e -w vm.min_free_order_shift=4;
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/vm/page-cluster ]; then
 $B echo "1" > /proc/sys/vm/page -cluster;
 $B echo "vm.page-cluster=1" >> /system/etc/sysctl.conf;
 $B sysctl -e -w vm.page-cluster=1;
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/vm/scan_unevictable_pages ]; then
 $B echo "0" > /proc/sys/vm/scan_unevictable_pages;
 $B echo "vm.scan_unevictable_pages=0" >> /system/etc/sysctl.conf;
 $B sysctl -e -w vm.scan_unevictable_pages=0;
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/vm/highmem_is_dirtyable ]; then
 $B echo "1" > /proc/sys/vm/highmem_is_dirtyable;
 $B echo "vm.highmem_is_dirtyable=1" >> /system/etc/sysctl.conf;
 $B sysctl -e -w vm.highmem_is_dirtyable=1;
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/fs/file-max ]; then
 $B echo "$FM" > /proc/sys/fs/file -max;
 $B echo "fs.file-max=$FM" >> /system/etc/sysctl.conf;
 $B sysctl -e -w fs.file-max=$FM;
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/fs/leases-enable ]; then
 $B echo "1" > /proc/sys/fs/leases -enable;
 $B echo "fs.leases-enable=1" >> /system/etc/sysctl.conf;
 $B sysctl -e -w fs.leases-enable=1;
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/fs/lease-break-time ]; then
 $B echo "9" > /proc/sys/fs/lease-break-time;
 $B echo "fs.lease-break-time=9" >> /system/etc/sysctl.conf;
 $B sysctl -e -w fs.lease-break-time=9;
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/fs/inotify/max_queued_events ]; then
 $B echo "24576" > /proc/sys/fs/inotify/max_queued_events;
 $B echo "fs.inotify.max_queued_events=24576" >> /system/etc/sysctl.conf;
 $B sysctl -e -w fs.inotify.max_queued_events=24576;
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/fs/inotify/max_user_instances ]; then
 $B echo "192" > /proc/sys/fs/inotify/max_user_instances;
 $B echo "fs.inotify.max_user_instances=192" >> /system/etc/sysctl.conf;
 $B sysctl -e -w fs.inotify.max_user_instances=192;
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/fs/inotify/max_user_watches ]; then
 $B echo "12288" > /proc/sys/fs/inotify/max_user_watches;
 $B echo "fs.inotify.max_user_watches=12288" >> /system/etc/sysctl.conf;
 $B sysctl -e -w fs.inotify.max_user_watches=12288;
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/kernel/softlockup_panic ]; then
 $B echo "0" > /proc/sys/kernel/softlockup_panic;
 $B echo "kernel.softlockup_panic=0" >> /system/etc/sysctl.conf;
 $B sysctl -e -w kernel.softlockup_panic=0;
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/kernel/hung_task_timeout_secs ]; then
 $B echo "0" > /proc/sys/kernel/hung_task_timeout_secs;
 $B echo "kernel.hung_task_timeout_secs=0" >> /system/etc/sysctl.conf;
 $B sysctl -e -w kernel.hung_task_timeout_secs=0;
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/kernel/panic ]; then
 $B echo "0" > /proc/sys/kernel/panic;
 $B echo "kernel.panic=0" >> /system/etc/sysctl.conf;
 $B sysctl -e -w kernel.panic=0;
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/kernel/panic_on_oops ]; then
 $B echo "0" > /proc/sys/kernel/panic_on_oops;
 $B echo "kernel.panic_on_oops=0" >> /system/etc/sysctl.conf;
 $B sysctl -e -w kernel.panic_on_oops=0;
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/kernel/nmi_watchdog ]; then
 $B echo "0" > /proc/sys/kernel/nmi_watchdog;
 $B echo "kernel.nmi_watchdog=0" >> /system/etc/sysctl.conf;
 $B sysctl -e -w kernel.nmi_watchdog=0;
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/kernel/auto_msgmni ]; then
 $B echo "1" > /proc/sys/kernel/auto_msgmni;
 $B echo "kernel.auto_msgmni=1" >> /system/etc/sysctl.conf;
 $B sysctl -e -w kernel.auto_msgmni=1;
 $B echo "1" >> $SCORE;
fi;
if [ -e /sys/kernel/debug/sched_features ]; then
 $B echo "NO_GENTLE_FAIR_SLEEPERS" > /sys/kernel/debug/sched_features;
 $B echo "NO_AFFINE_WAKEUPS" > /sys/kernel/debug/sched_features;
 $B echo "NO_WAKEUP_OVERLAP" > /sys/kernel/debug/sched_features;
 $B echo "NO_WAKEUP_PREEMPT" > /sys/kernel/debug/sched_features;
 $B echo "NO_DOUBLE_TICK" > /sys/kernel/debug/sched_features;
 $B echo "Tuning kernel sleepers..";
 $B echo "5" >> $SCORE;
fi;
if [ -e /sys/kernel/sched/gentle_fair_sleepers ]; then
 $B echo "0" > /sys/kernel/sched/gentle_fair_sleepers;
 $B echo "Tuning kernel gentle-sleepers..";
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/kernel/sched_window_stats_policy ]; then
 $B echo "3" > /proc/sys/kernel/sched_window_stats_policy;
 $B echo "Tuning kernel sched policy..";
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/kernel/sched_ravg_hist_size ]; then
 $B echo "3" > /proc/sys/kernel/sched_ravg_hist_size;
 $B echo "Tuning kernel sched history size..";
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/kernel/sched_spill_load ]; then
 $B echo "96" > /proc/sys/kernel/sched_spill_load;
 $B echo "Tuning kernel sched spill load..";
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/kernel/sched_spill_nr_run ]; then
 $B echo "9" > /proc/sys/kernel/sched_spill_nr_run;
 $B echo "Tuning kernel sched spill nr run..";
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/kernel/sched_upmigrate ]; then
 $B echo "90" > /proc/sys/kernel/sched_upmigrate;
 $B echo "Tuning kernel sched upmigrate..";
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/kernel/sched_downmigrate ]; then
 $B echo "70" > /proc/sys/kernel/sched_downmigrate;
 $B echo "Tuning kernel sched downmigrate..";
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/kernel/sched_heavy_task ]; then
 $B echo "90" > /proc/sys/kernel/sched_heavy_task;
 $B echo "Tuning kernel sched heavy task..";
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/kernel/sched_init_task_load ]; then
 $B echo "30" > /proc/sys/kernel/sched_init_task_load;
 $B echo "Tuning kernel sched init task load..";
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/kernel/sched_enable_power_aware ]; then
 $B echo "1" > /proc/sys/kernel/sched_enable_power_aware;
 $B echo "Tuning kernel sched power-saving..";
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/kernel/sched_upmigrate_min_nice ]; then
 $B echo "9" > /proc/sys/kernel/sched_upmigrate_min_nice;
 $B echo "Tuning kernel sched upmigrate nice..";
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/kernel/sched_small_wakee_task_load ]; then
 $B echo "12" > /proc/sys/kernel/sched_small_wakee_task_load;
 $B echo "Tuning kernel sched wake task load..";
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/kernel/sched_small_task ]; then
 $B echo "18" > /proc/sys/kernel/sched_small_task;
 $B echo "Tuning kernel sched samll task..";
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/kernel/sched_wakeup_load_threshold ]; then
 $B echo "110" > /proc/sys/kernel/sched_wakeup_load_threshold;
 $B echo "Tuning kernel sched wakeup load treshold..";
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/kernel/sched_migration_fixup ]; then
 $B echo "1" > /proc/sys/kernel/sched_migration_fixup;
 $B echo "Tuning kernel sched migration..";
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/kernel/sched_boost ]; then
 $B echo "0" > /proc/sys/kernel/sched_boost;
 $B echo "Tuning kernel sched boost..";
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/kernel/sched_tunable_scaling ]; then
 $B echo "0" > /proc/sys/kernel/sched_tunable_scaling;
 $B echo "Tuning kernel sched scaling..";
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/kernel/sched_latency_ns ]; then
 $B echo "1000000" > /proc/sys/kernel/sched_latency_ns;
 $B echo "Tuning kernel sched latency..";
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/kernel/sched_wakeup_granularity_ns ]; then
 $B echo "100000" > /proc/sys/kernel/sched_wakeup_granularity_ns;
 $B echo "Tuning kernel sched wakeup granularity..";
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/kernel/sched_child_runs_first ]; then
 $B echo "0" > /proc/sys/kernel/sched_child_runs_first;
 $B echo "Disabling kernel sched child runs first..";
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/kernel/sched_sched_min_granularity_ns ]; then
 $B echo "500000" > /proc/sys/kernel/sched_min_granularity_ns;
 $B echo "Tuning kernel sched min granularity..";
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/kernel/sched_sched_rt_runtime_us ]; then
 $B echo "950000" > /proc/sys/kernel/sched_rt_runtime_us;
 $B echo "Tuning kernel sched rt runtime..";
 $B echo "1" >> $SCORE;
fi;
if [ -e /proc/sys/kernel/sched_sched_rt_period_us ]; then
 $B echo "1000000" > /proc/sys/kernel/sched_rt_period_us;
 $B echo "Tuning kernel sched rt period..";
 $B echo "1" >> $SCORE;
fi;
if [ -e /sys/devices/virtual/misc/fsynccontrol/fsync_enabled ]; then
 $B echo "Fsync control detected. Tuning..";
 $B echo "0" > /sys/devices/virtual/misc/fsynccontrol/fsync_enabled;
 $B echo "1" >> $SCORE;
fi;
if [ -e /sys/class/misc/fsynccontrol/fsync_enabled ]; then
 $B echo "Fsync control detected. Tuning..";
 $B echo "0" > /sys/class/misc/fsynccontrol/fsync_enabled;
 $B echo "1" >> $SCORE;
fi;
if [ -e /sys/module/sync/parameters/fsync ]; then
 $B echo "0" > /sys/module/sync/parameters/fsync;
 $B echo "1" >> $SCORE;
 $B echo "Fsync module -OFF";
fi;
if [ -e /sys/module/sync/parameters/fsync_enabled ]; then
 $B echo "0" > /sys/module/sync/parameters/fsync_enabled;
 $B echo "N" > /sys/module/sync/parameters/fsync_enabled;
 $B echo "1" >> $SCORE;
 $B echo "Fsync module -OFF";
fi;
if [ -e /sys/kernel/dyn_fsync/Dyn_fsync_active ]; then
 $B echo "Dynamic fsync detected. Activating..";
 $B echo "1" > /sys/kernel/dyn_fsync/Dyn_fsync_active;
 $B echo "1" >> $SCORE;
fi;
if [ -e /sys/module/wakelock/parameters/debug_mask ]; then
 $B echo "7" > /sys/module/wakelock/parameters/debug_mask;
 $B echo "Wakelock debugging -OFF";
 $B echo "1" >> $SCORE;
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
 $B echo "1" >> $SCORE;
fi;
if [ -e /system/etc/slog.conf ]; then
 $B sed -e "s=enable=disable=" -i /system/etc/slog.conf;
 $B sed -e "s=enable=disable=" -i /system/etc/slog.conf.user;
 $B echo "Slog conf tuning..";
 $B echo "1" >> $SCORE;
fi;
if [ -e /sys/module/logger/parameters/log_mode ]; then
 $B echo "2" > /sys/module/logger/parameters/log_mode;
 $B echo "Disabling Android logger..";
 $B echo "1" >> $SCORE;
fi;
if [ -e /sys/module/sit/parameters/log_ecn_error ]; then
 $B echo "0" > /sys/module/sit/parameters/log_ecn_error;
 $B echo "SIT log OFF.";
 $B echo "1" >> $SCORE;
fi;
$B echo "Disabling debugging for all modules..";
for n in /sys/module/*;
do
 if [ -e "$n"/parameters/debug_mask ]; then
  $B echo "0" > "$n"/parameters/debug_mask;
  $B echo "1" >> $SCORE;
 fi;
 if [ -e "$n"/parameters/debug ]; then
  $B echo "0" > "$n"/parameters/debug;
  $B echo "N" > "$n"/parameters/debug;
  $B echo "1" >> $SCORE;
 fi;
done;
setprop sys.sysctl.extra_free_kbytes $EF;
$B echo "1" >> $SCORE;
sync;
$B sleep 1;

