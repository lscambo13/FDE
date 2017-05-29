#!/system/bin/sh
### FeraDroid Engine v1.1 | By FeraVolt. 2017 ###
B=/system/engine/bin/busybox;
SCORE=/system/engine/prop/score;
MADMAX=$($B cat /system/engine/raw/FDE_config.txt | $B grep -e 'mad_max=1');
if [ "mad_max=1" = "$MADMAX" ]; then
 KB=8196;
 $B echo "8" >> $SCORE;
 $B echo "Mad read-ahead.";
else
 KB=4096;
 $B echo "4" >> $SCORE;
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
 $B echo "1" >> $SCORE;
fi;
if [ -e /storage/extSdCard ]; then
 $B echo "Trying to mount extSdCard partition (EXT4) if it exists..";
 $B mount -t ext4 -o rw /dev/block/mmcblk1p1/storage/extSdCard;
 $B sleep 0.5;
 $B echo "1" >> $SCORE;
fi;
$B echo "Applying new I/O parameters..";
for b in $MMC $MTD $DM;
do
 $B echo "$KB" > "${b}"/bdi/read_ahead_kb;
 $B echo "$KB" > "${b}"/queue/read_ahead_kb;
 $B echo "0" > "${b}"/queue/add_random;
 $B echo "0" > "${b}"/queue/iostats;
 $B echo "0" > "${b}"/queue/rotational;
 $B echo "1" > "${b}"/queue/nomerges;
 $B echo "1" > "${b}"/queue/rq_affinity;
 $B echo "1024" > "${b}"/queue/nr_requests;
 $B echo "1" >> $SCORE;
done;
$B echo "Remounting EXT4 partitions..";
for x in $($B mount | grep ext4 | cut -d " " -f3);
do
 $B mount -o remount, nodiratime, relatime, delalloc, discard "${x}";
 $B echo "1" >> $SCORE;
done;
$B echo "Remounting storage partitions..";
for m in $ST $SST;
do
 $B mount -o remount, nosuid, nodev, noatime, nodiratime -t auto "${m}";
 $B echo "1" >> $SCORE;
done;
if [ -e /sys/devices/virtual/sec/sec_slow/io_is_busy ]; then
 $B echo "I/O is buzy..";
 $B echo "1" > /sys/devices/virtual/sec/sec_slow/io_is_busy;
 $B echo "1" >> $SCORE;
fi;
sync;
$B sleep 1;
