#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2015 ###

B=/system/engine/bin/busybox

$B echo "***Memory gear***"
$B echo " "
$B echo " "
RAM=$($B free -m | $B awk '{ print $2 }' | $B sed -n 2p)
SWAP=$($B free -m | $B awk '{ print $2 }' | $B sed -n 4p)
KB=$((((RAM+(SWAP/2))/64+1)*128))
STL="/sys/block/stl*"
BML="/sys/block/bml*"
MMC="/sys/block/mmc*"
ZRM="/sys/block/zram*"
MTD="/sys/block/mtd*"
RM="/sys/block/ram*"
LP="/sys/block/loop*"
$B echo "Device has $RAM MB of RAM and $SWAP MB of SWAP/ZRAM"
$B echo "Basing on your RAM & SWAP/ZRAM.."
$B echo "Calculated readahead parameter is $KB KB"

if [ -e /mnt/sd-ext ]; then
 $B echo "Mounting EXT partitions"
 $B mount -t ext3 -o rw /dev/block/vold/179:2 /mnt/sd-ext
 $B mount -t ext3 -o rw /dev/block/mmcblk0p2 /mnt/sd-ext
 $B sleep 1
 $B mount -t ext4 -o rw /dev/block/vold/179:2 /mnt/sd-ext
 $B mount -t ext4 -o rw /dev/block/mmcblk0p2 /mnt/sd-ext
 $B sleep 1
fi;

for i in $STL $BML $MMC $ZRM $MTD $RM $LP; do
if [ -e "${i}"/bdi/read_ahead_kb ]; then
 $B echo "Applying parameters.."
 $B echo $KB > "${i}"/bdi/read_ahead_kb
 $B echo "noop" > "${i}"/queue/scheduler
 $B echo 0 > "${i}"/queue/iostats
 $B echo 0 > "${i}"/queue/rotational
 $B echo 256 > "${i}"/queue/nr_requests
fi;
done

$B echo $KB > /sys/block/mmcblk0/queue/read_ahead_kb
CHK=$($B cat /sys/devices/virtual/bdi/179:0/read_ahead_kb)
$B echo "Checking if worked. Current parameter is $CHK KB"
$B echo " "
$B echo "FStrim init.."
$B fstrim -v /system
$B fstrim -v /data
$B fstrim -v /cache
$B echo "***Check***"
$B sleep 1
sync;

