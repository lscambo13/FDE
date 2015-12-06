#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2015 ###

B=/system/engine/bin/busybox
READ_AHEAD_KB="2048"
MAX="97"

if [ -e /mnt/sd-ext ]; then
$B mount -t ext3 -o rw /dev/block/vold/179:2 /mnt/sd-ext
$B mount -t ext3 -o rw /dev/block/mmcblk0p2 /mnt/sd-ext
$B sleep 1
$B mount -t ext4 -o rw /dev/block/vold/179:2 /mnt/sd-ext
$B mount -t ext4 -o rw /dev/block/mmcblk0p2 /mnt/sd-ext
$B sleep 1
fi;

echo $READ_AHEAD_KB > /sys/devices/virtual/bdi/0:22/read_ahead_kb
echo $READ_AHEAD_KB > /sys/devices/virtual/bdi/0:26/read_ahead_kb
echo $READ_AHEAD_KB > /sys/devices/virtual/bdi/179:0/read_ahead_kb
echo $READ_AHEAD_KB > /sys/devices/virtual/bdi/179:2/read_ahead_kb
echo $READ_AHEAD_KB > /sys/devices/virtual/bdi/179:128/read_ahead_kb
echo $READ_AHEAD_KB > /sys/devices/virtual/bdi/179:32/read_ahead_kb
echo $READ_AHEAD_KB > /sys/devices/virtual/bdi/179:64/read_ahead_kb
echo $READ_AHEAD_KB > /sys/devices/virtual/bdi/179:96/read_ahead_kb
echo $READ_AHEAD_KB > /sys/devices/virtual/bdi/253:0/read_ahead_kb
echo $READ_AHEAD_KB > /sys/devices/virtual/bdi/254:0/read_ahead_kb
echo $READ_AHEAD_KB > /sys/devices/virtual/bdi/7:0/read_ahead_kb
echo $READ_AHEAD_KB > /sys/devices/virtual/bdi/7:1/read_ahead_kb
echo $READ_AHEAD_KB > /sys/devices/virtual/bdi/7:2/read_ahead_kb
echo $READ_AHEAD_KB > /sys/devices/virtual/bdi/7:3/read_ahead_kb
echo $READ_AHEAD_KB > /sys/devices/virtual/bdi/7:4/read_ahead_kb
echo $READ_AHEAD_KB > /sys/devices/virtual/bdi/7:5/read_ahead_kb
echo $READ_AHEAD_KB > /sys/devices/virtual/bdi/7:6/read_ahead_kb
echo $READ_AHEAD_KB > /sys/devices/virtual/bdi/7:7/read_ahead_kb
echo $READ_AHEAD_KB > /sys/devices/virtual/bdi/default/read_ahead_kb
echo $MAX > /sys/devices/virtual/bdi/179:0/max_ratio

