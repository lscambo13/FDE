#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2015 ###

B=/system/engine/bin/busybox
LOG=/sdcard/Android/FDE.txt
TIME=$($B date | $B awk '{ print $4 }')

$B echo "[$TIME] 004 - ***Memory gear***" >> $LOG
$B echo "" >> $LOG
RAM=$($B free -m | $B awk '{ print $2 }' | $B sed -n 2p)
SWAP=$($B free -m | $B awk '{ print $2 }' | $B sed -n 4p)
KB=$((((RAM+(SWAP/2))/64+1)*128))
AA="/sys/block/*"
BB="/sys/devices/virtual/block/*"

$B echo " Device has $RAM MB of RAM and $SWAP MB of SWAP/ZRAM" >> $LOG
$B echo " Basing on your RAM + SWAP/ZRAM, calculated readahead parameter is $KB KB" >> $LOG

if [ -e /mnt/sd-ext ]; then
 $B echo " Trying to mount SD-EXT partition.." >> $LOG
 $B mount -t ext3 -o rw /dev/block/vold/179:2 /mnt/sd-ext
 $B mount -t ext3 -o rw /dev/block/mmcblk0p2 /mnt/sd-ext
 $B sleep 1
 $B mount -t ext4 -o rw /dev/block/vold/179:2 /mnt/sd-ext
 $B mount -t ext4 -o rw /dev/block/mmcblk0p2 /mnt/sd-ext
 $B sleep 1
fi;

for y in $($B mount | grep relatime | cut -d " " -f3);
do
 $B mount -o noatime,remount "${y}"
 $B echo "  Remounting relatime partitions.." >> $LOG
done;

for x in $($B mount | grep ext4 | cut -d " " -f3);
do
 $B mount -o noatime,remount,rw,discard,barrier=0,commit=60,noauto_da_alloc,delalloc "${x}"
 $B echo "  Remounting EXT4 partitions.." >> $LOG
done;

for i in $AA $BB; do
if [ -e "${i}"/queue/read_ahead_kb ]; then
 $B echo "  Applying new parameters.." >> $LOG
 $B echo $KB > "${i}"/queue/read_ahead_kb
 $B echo $KB > "${i}"/bdi/read_ahead_kb
 $B echo 0 > "${i}"/queue/iostats
 $B echo 0 > "${i}"/queue/rotational
fi;
done

CHK=$($B cat /sys/devices/virtual/bdi/179:0/read_ahead_kb)
$B echo " Checking if worked. Current parameter is $CHK KB" >> $LOG
$B echo " FStrim init.." >> $LOG
$B echo "  Trim /system" >> $LOG
$B fstrim -v /system | $B tee -a $LOG
$B echo "  Trim /data" >> $LOG
$B fstrim -v /data | $B tee -a $LOG
$B echo "  Trim /cache" >> $LOG
$B fstrim -v /cache | $B tee -a $LOG
$B sleep 1
$B echo "" >> $LOG
$B echo "[$TIME] 004 - ***Memory gear*** - OK" >> $LOG
sync;

