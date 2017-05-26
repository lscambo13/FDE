#!/system/bin/sh
### FeraDroid Engine v1.1 | By FeraVolt. 2017 ###
B=/system/engine/bin/busybox;
SCORE=/system/engine/prop/score;
MADMAX=$($B cat /system/engine/raw/FDE_config.txt | $B grep -e 'mad_max=1');
if [ "mad_max=1" = "$MADMAX" ]; then
 KB=2048;
else
 KB=8196;
fi;
$B echo "Read-ahead cache - $KB";
MMC="/sys/block/mmc*";
MTD="/sys/block/mtd*";
DM="/sys/block/dm-0";
ST="/storage/emulated/*";
SST="/storage/*";
if [ -e /mnt/sd-ext ]; then
 $B echo "Trying to mount SD-EXT (EXT4) partition if it exists..";
 $B mount -t ext4 -o rw /dev/block/vold/179:2/mnt/sd-ext;
 $B mount -t ext4 -o rw /dev/block/mmcblk0p2/mnt/sd-ext;
 $B sleep 0.5;
fi;
if [ -e /storage/extSdCard ]; then
 $B echo "Trying to mount extSdCard partition (EXT4) if it exists..";
 $B mount -t ext4 -o rw /dev/block/mmcblk1p1/storage/extSdCard;
 $B sleep 0.5;
fi;
$B echo "Applying new I/O parameters..";
for b in $MMC $MTD $DM;
do
 $B echo "off" > "${b}"/max_read_speed;
 $B echo "off" > "${b}"/max_write_speed;
 $B echo "off" > "${b}"/cache_size;
 $B echo "$KB" > "${b}"/bdi/read_ahead_kb;
 $B echo "$KB" > "${b}"/queue/read_ahead_kb;
 $B echo "0" > "${b}"/queue/add_random;
 $B echo "0" > "${b}"/queue/iostats;
 $B echo "0" > "${b}"/queue/rotational;
 $B echo "1" > "${b}"/queue/nomerges;
 $B echo "2" > "${b}"/queue/rq_affinity;
 $B echo "1024" > "${b}"/queue/nr_requests;
done;
$B echo "Remounting EXT4 partitions..";
for x in $($B mount | grep ext4 | cut -d " " -f3);
do
 $B mount -o remount, noatime, delalloc, nosuid, nodev, nodiratime, barrier=0, commit=30, discard, data=writeback "${x}";
done;
$B echo "Remounting storage partitions..";
for m in $ST $SST;
do
 $B mount -o remount, nosuid, nodev, noatime, nodiratime -t auto "${m}";
done;
sync;
$B sleep 1;
