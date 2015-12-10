#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2015 ###

B=/system/engine/bin/busybox
RZS=/system/engine/bin/rzscontrol

$B echo "***RAM gear***"
RAM=$($B free -m | $B awk '{ print $2 }' | $B sed -n 2p)
RAMfree=$($B free -m | $B awk '{ print $4 }' | $B sed -n 2p)
RAMcached=$($B free -m | $B awk '{ print $7 }' | $B sed -n 2p)
RAMreported=$((RAMfree + RAMcached))
SWAP=$($B free -m | $B awk '{ print $2 }' | $B sed -n 4p)
SWAPused=$($B free -m | $B awk '{ print $3 }' | $B sed -n 4p)
$B echo "Device has $RAM MB of RAM"
$B echo "$RAMfree MB of RAM is realy free"
$B echo "System reports that $RAMreported MB of RAM is free"
$B echo "$RAMcached MB of RAM is cached"
$B echo "SWAP/ZRAM is $SWAP MB"
$B echo "$SWAPused MB of SWAP/ZRAM is used"
$B echo " "
$B echo "Dropping caches.."
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
$B echo " "

if [ -e /sys/block/zram0/disksize ]; then
 ZRAM0=$($B cat /sys/block/zram0/disksize)
 ZZRAM=$((ZRAM0/1024))
 FZRAM=$((RAM/2))
 $B echo "ZRAM detected. Tuning.."
 $B echo "ZRAM0 size is $ZZRAM MB"
 $B echo "Basing on your RAM.."
 $B echo "Calculated ZRAM0 size is $FZRAM MB"
 $B echo "Applying parameter.."
 $B swapoff /dev/block/zram0
 $B sleep 1
 $B echo 1 > /sys/block/zram0/reset
 $B echo $((FZRAM*1024*1024)) > /sys/block/zram0/disksize
 $B mkswap /dev/block/zram0
 $B swapon /dev/block/zram0
 $B echo 99 > /proc/sys/vm/swappiness
elif [ -e /sys/block/ramzswap0/size ]; then
 RZ=$($B cat /sys/block/ramzswap0/size)
 ZRZ=$((RZ/1024))
 FRZ=$((RAM/2))
 $B echo "RAMZSWAP detected. Tuning.."
 $B echo "RAMZSWAP size is $ZRZ MB"
 $B echo "Basing on your RAM.."
 $B echo "Calculated RAMZSWAP size is $FRZ MB"
 ZRF=$((FRZ*1024))
 $B echo "Applying parameter.."
 $B swapoff /dev/block/ramzswap0
 $B sleep 1
 $RZS /dev/block/ramzswap0 --reset
 $RZS /dev/block/ramzswap0 -i -d $ZRF
 $B swapon /dev/block/ramzswap0
 $B echo 99 > /proc/sys/vm/swappiness
elif [ "$SWAP" -gt "0" ]; then
 $B echo "SWAP detected. Tuning.."
 $B echo "SWAP size is $SWAP MB"
 $B echo "Tuning system for SWAP.."
 $B echo 50 > /proc/sys/vm/swappiness
 if [ -e /sys/kernel/mm/ksm/run ]; then
  $B echo "KSM detected. Tuning.."
  $B echo "KSM + SWAP/ZRAM/RAMZSWAP is a bad idea for Android."
  $B echo "You have RAM paging enabled, so..disabling KSM.."
  $B echo 0 > /sys/kernel/mm/ksm/run
 fi;
else
 $B echo "No SWAP/ZRAM/RAMZSWAP was detected. Tuning system.."
 $B echo 0 > /proc/sys/vm/swappiness
 if [ -e /sys/kernel/mm/ksm/run ]; then
  $B echo "KSM detected. Tuning.."
  $B echo "You have no RAM paging. Let's enable/tune KSM.."
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
$B echo "NOW:"
$B echo "Realy free RAM is $RAMfree MB"
$B echo "System reported free RAM is $RAMreported MB"
$B echo "Cached RAM is $RAMcached MB"
$B echo "SWAP/ZRAM is $SWAP MB"
$B echo "Used SWAP/ZRAM is $SWAPused MB"
$B echo " "
$B echo "***Check***"
sync;

