#!/system/bin/sh
### FeraDroid Engine v0.23 | By FeraVolt. 2017 ###
B=/system/engine/bin/busybox
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] ***Memory gear***"
MMC="/sys/block/mmc*"
MTD="/sys/block/mtd*"
ZR="/sys/block/zram*"
ST="/storage/emulated/*"
SST="/storage/*"
if [ -e /mnt/sd-ext ]; then
 $B echo "Trying to mount SD-EXT partition if it exists.."
 $B mount -t ext3 -o rw /dev/block/vold/179:2 /mnt/sd-ext
 $B mount -t ext3 -o rw /dev/block/mmcblk0p2 /mnt/sd-ext
 $B sleep 1
 $B mount -t ext4 -o rw /dev/block/vold/179:2 /mnt/sd-ext
 $B mount -t ext4 -o rw /dev/block/mmcblk0p2 /mnt/sd-ext
 $B sleep 1
fi;
if [ -e /storage/extSdCard ]; then
 $B echo "Trying to mount extSdCard partition if it exists.."
 $B mount -t ext3 -o rw /dev/block/mmcblk1p1 /storage/extSdCard
 $B sleep 1
 $B mount -t ext4 -o rw /dev/block/mmcblk1p1 /storage/extSdCard
 $B sleep 1
fi;
$B echo "Remounting storage partitions.."
for m in $ST $SST; do
  $B mount -o remount,nosuid,nodev,noatime,nodiratime -t auto "${m}"
  $B mount -o remount,nosuid,nodev,noatime,nodiratime -t auto "${m}"/Android/obb
done;
$B echo "Remounting EXT4 partitions.."
for x in $($B mount | grep ext4 | cut -d " " -f3); do
 $B mount -o remount,noatime,delalloc,nosuid,nodev,nodiratime,barrier=0,nobh,commit=60,discard,data=writeback,rw "${x}"
done;
$B echo "Applying new I/O parameters.."
for b in $MMC $MTD $ZR; do
 $B echo "5120" > "${b}"/queue/read_ahead_kb
 $B echo "0" > "${b}"/queue/add_random
 $B echo "0" > "${b}"/queue/iosched/slice_idle
 $B echo "0" > "${b}"/queue/iostats
 $B echo "0" > "${b}"/queue/rotational
 $B echo "2" > "${b}"/queue/nomerges
 $B echo "1" > "${b}"/queue/rq_affinity
 $B echo "1024" > "${b}"/queue/nr_requests
 $B echo "off" > "${b}"/max_read_speed
 $B echo "off" > "${b}"/max_write_speed
 $B echo "off" > "${b}"/cache_size
done;
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] ***Memory gear*** - OK"
sync;
