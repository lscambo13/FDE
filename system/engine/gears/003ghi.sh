#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2016 ###

B=/system/engine/bin/busybox
RZS=/system/engine/bin/rzscontrol
LOG=/sdcard/Android/FDE.txt
TIME=$($B date | $B awk '{ print $4 }')

$B echo "[$TIME] 003 - ***RAM gear***" >> $LOG
$B echo "" >> $LOG
RAM=$($B free -m | $B awk '{ print $2 }' | $B sed -n 2p)
RAMfree=$($B free -m | $B awk '{ print $4 }' | $B sed -n 2p)
RAMcached=$($B free -m | $B awk '{ print $7 }' | $B sed -n 2p)
RAMreported=$((RAMfree + RAMcached))
SWAP=$($B free -m | $B awk '{ print $2 }' | $B sed -n 4p)
SWAPused=$($B free -m | $B awk '{ print $3 }' | $B sed -n 4p)
$B echo " Current RAM values:" >> $LOG
$B echo "  Total:              $RAM MB" >> $LOG
$B echo "  Free:               $RAMreported MB" >> $LOG
$B echo "  Real free:          $RAMfree MB" >> $LOG
$B echo "  Cached:             $RAMcached MB" >> $LOG
$B echo "  SWAP/ZRAM total:    $SWAP MB" >> $LOG
$B echo "  SWAP/ZRAM used:     $SWAPused MB" >> $LOG
$B echo "" >> $LOG
$B echo " Freeing RAM..." >> $LOG
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
$B echo " Paging check.." >> $LOG
if [ -e /sys/block/zram0/disksize ]; then
 SWAP=$($B free -m | $B awk '{ print $2 }' | $B sed -n 4p)
 ZRAM0=$($B cat /sys/block/zram0/disksize)
 ZZRAM=$((ZRAM0/1024/1024))
 FZRAM=$((RAM/2))
 $B echo " ZRAM detected. Size is $ZZRAM MB" >> $LOG
 $B echo " Perfect ZRAM size according to your RAM should be $FZRAM MB" >> $LOG
 if [ "$ZZRAM" -ge "$FZRAM" ]; then
 $B echo " Size of your ZRAM is OK" >> $LOG
  sync;
 else
 $B echo " Applying new ZRAM parameters.." >> $LOG
 if [ "$SWAP" -gt "0" ]; then
  $B echo "  Stopping swappiness.." >> $LOG
  $B swapoff /dev/block/zram0
  $B sleep 1
  sync;
 fi;
 if [ -e /sys/block/zram0/comp_algorithm ]; then
  $B echo "  Setting compression algorithm to LZ4.." >> $LOG
  $B echo "lz4" > /sys/block/zram0/comp_algorithm
 fi;
 $B echo "  Resetting ZRAM blockdev.." >> $LOG
 $B echo 1 > /sys/block/zram0/reset
 $B echo "  Creating ZRAM blockdev - $FZRAM MB" >> $LOG
 $B echo $((FZRAM*1024*1024)) > /sys/block/zram0/disksize
 $B echo "  Starting swappiness.." >> $LOG
 $B mkswap /dev/block/zram0
 $B swapon /dev/block/zram0
 fi;
 $B echo " Configuring kernel & ZRAM frienship.." >> $LOG
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
 $B echo " RAMZSWAP detected. Size is $ZRZ MB" >> $LOG
 $B echo " Perfect RAMZSWAP size according to your RAM should be $FRZ MB" >> $LOG
 ZRF=$((FRZ*1024))
 if [ "$ZRZ" -ge "$FRZ" ]; then
 $B echo " Size of your RAMZSWAP is OK" >> $LOG
  sync;
 else
 $B echo " Applying new RAMZSWAP parameters.." >> $LOG
 if [ "$SWAP" -gt "0" ]; then
  $B echo "  Stopping swappiness.." >> $LOG
  $B swapoff /dev/block/ramzswap0
  $B sleep 1
  sync;
 fi;
 $B echo "  Resetting RAMZSWAP blockdev.." >> $LOG
 $RZS /dev/block/ramzswap0 --reset
 $B echo "  Creating RAMZSWAP blockdev - $FRZ MB" >> $LOG
 $RZS /dev/block/ramzswap0 -i -d $ZRF
 $B sleep 1
 $B echo "  Starting swappiness.." >> $LOG
 $B mkswap /dev/block/ramzswap0
 $B swapon /dev/block/ramzswap0
 fi;
 $B echo " Configuring kernel & RAMZSWAP frienship.." >> $LOG
 $B echo 99 > /proc/sys/vm/swappiness
 $B echo 3 > /proc/sys/vm/page-cluster
 $B sysctl -e -w vm.swappiness=99
 $B sysctl -e -w vm.page-cluster=3
 $B echo "vm.swappiness=99" >> /system/etc/sysctl.conf
 $B echo "vm.page-cluster=3" >> /system/etc/sysctl.conf
elif [ "$SWAP" -gt "0" ]; then
 SWAP=$($B free -m | $B awk '{ print $2 }' | $B sed -n 4p)
 $B echo " SWAP detected. Size is $SWAP MB" >> $LOG
 $B echo " Configuring kernel & SWAP frienship.." >> $LOG
 $B echo 50 > /proc/sys/vm/swappiness
 $B echo 1 > /proc/sys/vm/page-cluster
 $B sysctl -e -w vm.swappiness=50
 $B sysctl -e -w vm.page-cluster=1
 $B echo "vm.swappiness=50" >> /system/etc/sysctl.conf
 $B echo "vm.page-cluster=1" >> /system/etc/sysctl.conf
 if [ -e /sys/module/zswap/parameters/enabled ]; then
  $B echo " ZSWAP detected. Enabling.." >> $LOG
  $B echo 1 > /sys/module/zswap/parameters/enabled
  $B echo " LZ4 compression algorithm for ZSWAP" >> $LOG
  $B echo lz4 > /sys/module/zswap/parameters/compressor
 fi;
else
 $B echo " No SWAP/ZRAM/RAMZSWAP was detected" >> $LOG
 $B echo " Configuring kernel for swappless system.." >> $LOG
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
  $B echo " KSM detected" >> $LOG
  $B echo " KSM + swappiness is a bad. Disabling KSM.." >> $LOG
  $B echo 0 > /sys/kernel/mm/ksm/run
 fi;
elif [ "$SWAP" = "0" ]; then
 if [ -e /sys/kernel/mm/ksm/run ]; then
  $B echo " KSM detected" >> $LOG
  $B echo " Starting and tuning KSM.." >> $LOG
  $B echo 90 > /sys/kernel/mm/ksm/pages_to_scan
  $B echo 5000 > /sys/kernel/mm/ksm/sleep_millisecs
  $B echo 1 > /sys/kernel/mm/ksm/run
 fi;
fi;
$B echo " Paging check completed" >> $LOG

RAMfree=$($B free -m | $B awk '{ print $4 }' | $B sed -n 2p)
RAMcached=$($B free -m | $B awk '{ print $7 }' | $B sed -n 2p)
RAMreported=$((RAMfree + RAMcached))
SWAP=$($B free -m | $B awk '{ print $2 }' | $B sed -n 4p)
SWAPused=$($B free -m | $B awk '{ print $3 }' | $B sed -n 4p)
$B echo " RAM values now:" >> $LOG
$B echo "  Total:              $RAM MB" >> $LOG
$B echo "  Free:               $RAMreported MB" >> $LOG
$B echo "  Real free:          $RAMfree MB" >> $LOG
$B echo "  Cached:             $RAMcached MB" >> $LOG
$B echo "  SWAP/ZRAM total:    $SWAP MB" >> $LOG
$B echo "  SWAP/ZRAM used:     $SWAPused MB" >> $LOG
$B echo "" >> $LOG
$B echo "[$TIME] 003 - ***RAM gear*** - OK" >> $LOG
sync;

