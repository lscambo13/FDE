#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2015 ###

B=/system/engine/bin/busybox
RZS=/system/engine/bin/rzscontrol

$B echo "***RAM gear***"
$B echo " "
$B echo " "
RAM=$($B free -m | $B awk '{ print $2 }' | $B sed -n 2p)
RAMfree=$($B free -m | $B awk '{ print $4 }' | $B sed -n 2p)
RAMcached=$($B free -m | $B awk '{ print $7 }' | $B sed -n 2p)
RAMreported=$((RAMfree + RAMcached))
SWAP=$($B free -m | $B awk '{ print $2 }' | $B sed -n 4p)
SWAPused=$($B free -m | $B awk '{ print $3 }' | $B sed -n 4p)
$B echo "Current RAM values:"
$B echo "Total:              $RAM MB"
$B echo "Free:               $RAMreported MB"
$B echo "Real free:          $RAMfree MB"
$B echo "Cached:             $RAMcached MB"
$B echo "SWAP/ZRAM total:    $SWAP MB"
$B echo "SWAP/ZRAM used:     $SWAPused MB"
$B echo " "
$B echo " "
$B echo "Dropping caches.."
$B echo " "
$B echo " "
sync;
$B sleep 1
$B echo 3 > /proc/sys/vm/drop_caches
$B sleep 1
sync;
$B sleep 1
$B echo 2 > /proc/sys/vm/drop_caches
$B sleep 1
sync;
$B sleep 1
$B echo 1 > /proc/sys/vm/drop_caches
$B sleep 1
sync;
$B sleep 1
$B echo 3 > /proc/sys/vm/drop_caches
$B sleep 3
sync;

if [ -e /sys/block/zram0/disksize ]; then
 SWAP=$($B free -m | $B awk '{ print $2 }' | $B sed -n 4p)
 ZRAM0=$($B cat /sys/block/zram0/disksize)
 ZZRAM=$((ZRAM0/1024/1024))
 FZRAM=$((RAM/2))
 $B echo "ZRAM detected. Tuning.."
 $B echo "ZRAM0 size is $ZZRAM MB"
 $B echo "Basing on your RAM.."
 $B echo "Calculated ZRAM0 size is $FZRAM MB"
 $B echo "Applying parameter.."
 if [ "$ZZRAM" -ge "$FZRAM" ]; then
 $B echo "Size is fine..tuning.."
  sync;
 else
 if [ "$SWAP" -gt "0" ]; then
  $B swapoff /dev/block/zram0
  $B sleep 1
  sync;
 fi;
 if [ -e /sys/block/zram0/comp_algorithm ]; then
  $B echo "Better compression level"
  $B echo "lz4" > /sys/block/zram0/comp_algorithm
 fi;
 $B echo 1 > /sys/block/zram0/reset
 $B echo $((FZRAM*1024*1024)) > /sys/block/zram0/disksize
 $B mkswap /dev/block/zram0
 $B swapon /dev/block/zram0
 fi;
 $B echo 99 > /proc/sys/vm/swappiness
 $B echo 3 > /proc/sys/vm/page-cluster
 $B sysctl -e -w vm.swappiness=99
 $B sysctl -e -w vm.page-cluster=3
 $B echo "vm.swappiness=99" >> /system/etc/sysctl.conf
 $B echo "vm.page-cluster=3" >> /system/etc/sysctl.conf
elif [ -e /sys/block/ramzswap0/size ]; then
 SWAP=$($B free -m | $B awk '{ print $2 }' | $B sed -n 4p)
 RZ=$($B cat /sys/block/ramzswap0/size)
 ZRZ=$((RZ/1024))
 FRZ=$((RAM/2))
 $B echo "RAMZSWAP detected. Tuning.."
 $B echo "RAMZSWAP size is $ZRZ MB"
 $B echo "Basing on your RAM.."
 $B echo "Calculated RAMZSWAP size is $FRZ MB"
 ZRF=$((FRZ*1024))
 $B echo "Applying parameter.."
 if [ "$ZRZ" -ge "$FRZ" ]; then
 $B echo "Size is fine..tuning.."
  sync;
 else
 if [ "$SWAP" -gt "0" ]; then
  $B swapoff /dev/block/ramzswap0
  $B sleep 1
  sync;
 fi;
 $RZS /dev/block/ramzswap0 --reset
 $RZS /dev/block/ramzswap0 -i -d $ZRF
 $B sleep 1
 $B swapon /dev/block/ramzswap0
 fi;
 $B echo 99 > /proc/sys/vm/swappiness
 $B echo 3 > /proc/sys/vm/page-cluster
 $B sysctl -e -w vm.swappiness=99
 $B sysctl -e -w vm.page-cluster=3
 $B echo "vm.swappiness=99" >> /system/etc/sysctl.conf
 $B echo "vm.page-cluster=3" >> /system/etc/sysctl.conf
elif [ "$SWAP" -gt "0" ]; then
 SWAP=$($B free -m | $B awk '{ print $2 }' | $B sed -n 4p)
 $B echo "SWAP detected. Tuning.."
 $B echo "SWAP size is $SWAP MB"
 $B echo "Tuning system.."
 $B echo 50 > /proc/sys/vm/swappiness
 $B echo 1 > /proc/sys/vm/page-cluster
 $B sysctl -e -w vm.swappiness=50
 $B sysctl -e -w vm.page-cluster=1
 $B echo "vm.swappiness=50" >> /system/etc/sysctl.conf
 $B echo "vm.page-cluster=1" >> /system/etc/sysctl.conf
 if [ -e /sys/module/zswap/parameters/enabled ]; then
  $B echo "ZSWAP detected. Enabling/tuning it.."
  $B echo 1 > /sys/module/zswap/parameters/enabled
  $B echo lz4 > /sys/module/zswap/parameters/compressor
 fi;
else
 $B echo "No SWAP/ZRAM was detected. Tuning system.."
 $B echo 0 > /proc/sys/vm/swappiness
 $B echo 0 > /proc/sys/vm/page-cluster
 $B sysctl -e -w vm.swappiness=0
 $B sysctl -e -w vm.page-cluster=0
 $B echo "vm.swappiness=0" >> /system/etc/sysctl.conf
 $B echo "vm.page-cluster=0" >> /system/etc/sysctl.conf
fi;
$B echo " "
SWAP=$($B free -m | $B awk '{ print $2 }' | $B sed -n 4p)
if [ "$SWAP" -gt "0" ]; then
 if [ -e /sys/kernel/mm/ksm/run ]; then
  $B echo "KSM detected. Tuning.."
  $B echo "KSM + SWAP/ZRAM is a bad idea for Android."
  $B echo "You have RAM paging enabled, so..disabling KSM.."
  $B echo 0 > /sys/kernel/mm/ksm/run
 fi;
elif [ "$SWAP" = "0" ]; then
 if [ -e /sys/kernel/mm/ksm/run ]; then
  $B echo "KSM detected."
  $B echo "You have no RAM paging enabled. Let's enable/tune KSM.."
  $B echo 90 > /sys/kernel/mm/ksm/pages_to_scan
  $B echo 5000 > /sys/kernel/mm/ksm/sleep_millisecs
  $B echo 1 > /sys/kernel/mm/ksm/run
 fi;
fi;

RAMfree=$($B free -m | $B awk '{ print $4 }' | $B sed -n 2p)
RAMcached=$($B free -m | $B awk '{ print $7 }' | $B sed -n 2p)
RAMreported=$((RAMfree + RAMcached))
SWAP=$($B free -m | $B awk '{ print $2 }' | $B sed -n 4p)
SWAPused=$($B free -m | $B awk '{ print $3 }' | $B sed -n 4p)
$B echo " "
$B echo " "
$B echo "RAM values NOW:"
$B echo "Total:              $RAM MB"
$B echo "Free:               $RAMreported MB"
$B echo "Real free:          $RAMfree MB"
$B echo "Cached:             $RAMcached MB"
$B echo "SWAP/ZRAM total:    $SWAP MB"
$B echo "SWAP/ZRAM used:     $SWAPused MB"
$B echo " "
$B echo " "
$B echo "***Check***"
sync;

