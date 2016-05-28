#!/system/bin/sh
### FeraDroid Engine v0.21 | By FeraVolt. 2016 ###
B=/system/engine/bin/busybox
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] 004 - ***Memory gear***"
SDK=$(getprop ro.build.version.sdk)
RAM=$($B free -m | $B awk '{ print $2 }' | $B sed -n 2p)
if [ "$RAM" -le "1024" ]; then
 SKB=$((RAM*9))
elif [ "$RAM" -le "2048" ]; then
 SKB=$((RAM*5))
else
 SKB=$((RAM*4))
fi;
AA="/sys/block/*"
BB="/sys/devices/virtual/block/*"
MMC="/sys/block/mmc*"
MTD="/sys/block/mtd*"
BDI="/sys/devices/virtual/bdi"
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
 $B mount -o remount,noatime,delalloc,nosuid,nodev,nodiratime,barrier=0,nobh,commit=90,discard,data=writeback,rw "${x}"
done;
$B echo "Calculated readahead parameter is $SKB KB"
$B echo "Applying new I/O parameters.."
for i in $AA $BB; do
if [ -e "${i}"/queue/read_ahead_kb ]; then
 $B echo $SKB > "${i}"/queue/read_ahead_kb
 $B echo $SKB > "${i}"/bdi/read_ahead_kb
 $B echo 0 > "${i}"/queue/iostats
 $B echo 0 > "${i}"/queue/rotational
 $B echo 2 > "${i}"/queue/nomerges
 $B echo 0 > "${i}"/queue/rq_affinity
fi;
done;
$B echo "Applying new rnd parameters.."
for b in $MMC $MTD; do
if [ -e "${b}"/queue/add_random ]; then
 $B echo 0 > "${b}"/queue/add_random
fi;
done;
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] 004 - ***Memory gear*** - OK"
sync;
