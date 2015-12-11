#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2015 ###

B=/system/engine/bin/busybox

$B echo "***Kernel configuration gear***"
$B echo " "
$B echo " "
$B echo "Creating kernel config file.."
$B rm -f /system/etc/sysctl.conf
$B touch /system/etc/sysctl.conf
$B echo "Setting proper permissions.."
$B chmod 777 /system/etc/sysctl.conf

$B sysctl -e -w kernel.random.read_wakeup_threshold=1536
$B sysctl -e -w kernel.random.write_wakeup_threshold=256
$B sysctl -e -w vm.vfs_cache_pressure=50
$B sysctl -e -w vm.min_free_kbytes=4096
$B sysctl -e -w vm.extra_free_kbytes=4096
$B sysctl -e -w vm.drop_caches=3
$B sysctl -e -w vm.oom_kill_allocating_task=0
$B sysctl -e -w vm.dirty_ratio=50
$B sysctl -e -w vm.dirty_background_ratio=10
$B sysctl -e -w vm.dirty_writeback_interval=6000
$B sysctl -e -w vm.dirty_expire_centisecs=600

$B echo 1536 > /proc/sys/kernel/random/read_wakeup_threshold
$B echo 256 > /proc/sys/kernel/random/write_wakeup_threshold
$B echo 50 > /proc/sys/vm/vfs_cache_pressure
$B echo 4096 > /proc/sys/vm/min_free_kbytes
$B echo 4096 > /proc/sys/vm/extra_free_kbytes
$B echo 3 > /proc/sys/vm/drop_caches
$B echo 0 > /proc/sys/vm/oom_kill_allocating_task
$B echo 50 > /proc/sys/vm/dirty_ratio
$B echo 10 > /proc/sys/vm/dirty_background_ratio
$B echo 6000 > /proc/sys/vm/vm.dirty_writeback_interval
$B echo 600 > /proc/sys/vm/vm.dirty_expire_centisecs

sysctl -p
$B echo " "
$B echo " "
$B echo "***Check***"
sync;

