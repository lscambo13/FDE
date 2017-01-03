#!/system/bin/sh
### FeraDroid Engine v0.22 | By FeraVolt. 2017 ###
B=/system/engine/bin/busybox
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] ***Memory gear***"
RAM=$($B free -m | $B awk '{ print $2 }' | $B sed -n 2p)
if [ "$RAM" -le "1024" ]; then
 SKB=$((RAM*6))
elif [ "$RAM" -le "2048" ]; then
 SKB=$((RAM*5))
else
 SKB=$((RAM*4))
fi;
KB=1024
AA="/sys/block/*"
BB="/sys/devices/virtual/block/*"
BD="/sys/devices/virtual/bdi/*"
MMC="/sys/block/mmc*"
MTD="/sys/block/mtd*"
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
$B echo "Calculated readahead parameter is $SKB KB"
$B echo "Applying new I/O parameters.."
for i in $AA $BB; do
if [ -e "${i}"/queue/read_ahead_kb ]; then
 $B echo $KB > "${i}"/queue/read_ahead_kb
 $B echo $KB > "${i}"/bdi/read_ahead_kb
 $B echo 0 > "${i}"/queue/iostats
 $B echo 0 > "${i}"/queue/rotational
 $B echo 2 > "${i}"/queue/nomerges
 $B echo 1 > "${i}"/queue/rq_affinity
fi;
done;
for i in $BD; do
if [ -e "${i}"/read_ahead_kb ]; then
 $B echo $KB > "${i}"/read_ahead_kb
fi;
done;
$B echo "Applying new rnd parameters.."
for b in $MMC $MTD; do
if [ -e "${b}"/queue/add_random ]; then
 $B echo 0 > "${b}"/queue/add_random
 $B echo 0 > "${b}"/queue/iosched/slice_idle
fi;
done;
for node in $($B find /sys -name nr_requests | $B grep mmcblk); do
 $B echo "1024" > "$node"
done;
$B echo "$SKB" > /sys/devices/virtual/bdi/default/read_ahead_kb
if [ -e /sys/devices/virtual/bdi/179:0/read_ahead_kb ]; then
 $B echo "$SKB" > /sys/devices/virtual/bdi/179:0/read_ahead_kb
fi;
if [ -e /sys/devices/virtual/bdi/179:1/read_ahead_kb ]; then
 $B echo "$SKB" > /sys/devices/virtual/bdi/179:1/read_ahead_kb
fi;
if [ -e /sys/devices/virtual/bdi/179:2/read_ahead_kb ]; then
 $B echo "$SKB" > /sys/devices/virtual/bdi/179:2/read_ahead_kb
fi;
if [ -e /sys/devices/virtual/bdi/179:32/read_ahead_kb ]; then
 $B echo "$SKB" > /sys/devices/virtual/bdi/179:32/read_ahead_kb
fi;
if [ -e /sys/devices/virtual/bdi/179:64/read_ahead_kb ]; then
 $B echo "$SKB" > /sys/devices/virtual/bdi/179:64/read_ahead_kb
fi;
if [ -e /sys/devices/virtual/bdi/179:96/read_ahead_kb ]; then
 $B echo "$SKB" > /sys/devices/virtual/bdi/179:96/read_ahead_kb
fi;
if [ -e /sys/devices/virtual/bdi/179:0/read_ahead_kb ]; then
 $B echo "$SKB" > /sys/devices/virtual/bdi/179:*/read_ahead_kb
fi;
if [ -e /sys/block/mmcblk0/max_write_speed ]; then
 $B echo "off" > /sys/block/mmcblk0/max_read_speed
 $B echo "off" > /sys/block/mmcblk0/max_write_speed
 $B echo "off" > /sys/block/mmcblk0/cache_size
 $B echo "I/O speed cap disabled."
fi;
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] ***Memory gear*** - OK"
sync;
