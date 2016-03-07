#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2016 ###
B=/system/engine/bin/busybox
RZS=/system/engine/bin/rzscontrol
LOG=/sdcard/Android/FDE.txt
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] 003 - ***RAM gear***" >> $LOG
RAM=$($B free -m | $B awk '{ print $2 }' | $B sed -n 2p)
RAMfree=$($B free -m | $B awk '{ print $4 }' | $B sed -n 2p)
RAMcached=$($B free -m | $B awk '{ print $7 }' | $B sed -n 2p)
RAMreported=$((RAMfree + RAMcached))
SWAP=$($B free -m | $B awk '{ print $2 }' | $B sed -n 4p)
SWAPused=$($B free -m | $B awk '{ print $3 }' | $B sed -n 4p)
$B echo "Current RAM values:" >> $LOG
$B echo "  Total:              $RAM MB" >> $LOG
$B echo "  Free:               $RAMreported MB" >> $LOG
$B echo "  Real free:          $RAMfree MB" >> $LOG
$B echo "  Cached:             $RAMcached MB" >> $LOG
$B echo "  SWAP/ZRAM total:    $SWAP MB" >> $LOG
$B echo "  SWAP/ZRAM used:     $SWAPused MB" >> $LOG
$B echo "" >> $LOG
if [ "$RAM" -ge "768" ]; then
 setprop ro.config.low_ram false
 setprop ro.board_ram_size high
fi;
$B echo "Freeing RAM..." >> $LOG
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
$B mount -o remount,rw /system
sync;
$B echo "Paging check.." >> $LOG
if [ -e /sys/block/zram0/disksize ]; then
 SWAP=$($B free -m | $B awk '{ print $2 }' | $B sed -n 4p)
 ZRAM0=$($B cat /sys/block/zram0/disksize)
 ZZRAM=$((ZRAM0/1024/1024))
 if [ "$RAM" -gt "1700" ]; then
  FZRAM=$((RAM/4))
 else
  FZRAM=$((RAM/2))
 fi;
 $B echo "ZRAM detected. Size is $ZZRAM MB" >> $LOG
 if [ "$ZZRAM" -ge "$FZRAM" ]; then
 $B echo "Size of your ZRAM is OK" >> $LOG
  sync;
 elif [ "$RAM" -gt "2100" ]; then
  $B echo "You don't need zRAM" >> $LOG
 if [ "$SWAP" -gt "0" ]; then
  $B echo "Stopping swappiness.." >> $LOG
  $B swapoff /dev/block/zram0 | $B tee -a $LOG
  if [ -e /sys/block/zram1/disksize ]; then
   $B swapoff /dev/block/zram1 | $B tee -a $LOG
  fi;
  $B sleep 1
  sync;
 fi;
 else
 $B echo "Perfect ZRAM size according to your RAM should be $FZRAM MB" >> $LOG
 $B echo "Applying new ZRAM parameters.." >> $LOG
 if [ "$SWAP" -gt "0" ]; then
  $B echo "Stopping swappiness.." >> $LOG
  $B swapoff /dev/block/zram0 | $B tee -a $LOG
  if [ -e /sys/block/zram1/disksize ]; then
   $B swapoff /dev/block/zram1 | $B tee -a $LOG
   $B sleep 1
   $B echo 1 > /sys/block/zram1/reset | $B tee -a $LOG
  fi;
  $B sleep 1
  sync;
 fi;
 $B echo "Resetting ZRAM blockdev.." >> $LOG
 $B echo 1 > /sys/block/zram0/reset | $B tee -a $LOG
 $B echo "Creating ZRAM blockdev - $FZRAM MB" >> $LOG
 $B echo $((FZRAM*1024*1024)) > /sys/block/zram0/disksize | $B tee -a $LOG
 if [ -e /sys/block/zram0/comp_algorithm ]; then
  $B echo "Setting compression algorithm to LZ4.." >> $LOG
  $B echo "lz4" > /sys/block/zram0/comp_algorithm
 fi;
 $B echo "Starting swappiness.." >> $LOG
 $B mkswap /dev/block/zram0 | $B tee -a $LOG
 $B swapon /dev/block/zram0 | $B tee -a $LOG
 fi;
 $B echo "Configuring kernel & ZRAM frienship.." >> $LOG
 if [ "$RAM" -gt "1700" ]; then
  $B echo 30 > /proc/sys/vm/swappiness
  $B echo "vm.swappiness=30" >> /system/etc/sysctl.conf
  $B sysctl -e -w vm.swappiness=30
 else
  $B echo 60 > /proc/sys/vm/swappiness
  $B echo "vm.swappiness=60" >> /system/etc/sysctl.conf
  $B sysctl -e -w vm.swappiness=60
 fi;
 $B echo 2 > /proc/sys/vm/page-cluster
 $B echo "vm.page-cluster=2" >> /system/etc/sysctl.conf
 $B sysctl -e -w vm.page-cluster=2
 setprop ro.config.zram.support true
 setprop zram.disksize $FZRAM
elif [ -e /sys/block/ramzswap0/size ]; then
 SWAP=$($B free -m | $B awk '{ print $2 }' | $B sed -n 4p)
 RZ=$($B cat /sys/block/ramzswap0/size)
 ZRZ=$((RZ/1024))
 FRZ=$((RAM/2))
 $B echo "RAMZSWAP detected. Size is $ZRZ MB" >> $LOG
 $B echo "Perfect RAMZSWAP size according to your RAM should be $FRZ MB" >> $LOG
 ZRF=$((FRZ*1024))
 if [ "$ZRZ" -ge "$FRZ" ]; then
 $B echo "Size of your RAMZSWAP is OK" >> $LOG
  sync;
 else
 $B echo "Applying new RAMZSWAP parameters.." >> $LOG
 if [ "$SWAP" -gt "0" ]; then
  $B echo "Stopping swappiness.." >> $LOG
  $B swapoff /dev/block/ramzswap0 | $B tee -a $LOG
  $B sleep 1
  sync;
 fi;
 $B echo "Resetting RAMZSWAP blockdev.." >> $LOG
 $RZS /dev/block/ramzswap0 --reset | $B tee -a $LOG
 $B echo "Creating RAMZSWAP blockdev - $FRZ MB" >> $LOG
 $RZS /dev/block/ramzswap0 -i -d $ZRF | $B tee -a $LOG
 $B sleep 1
 $B echo "Starting swappiness.." >> $LOG
 $B swapon /dev/block/ramzswap0 | $B tee -a $LOG
 fi;
 $B echo "Configuring kernel & RAMZSWAP frienship.." >> $LOG
 $B echo 75 > /proc/sys/vm/swappiness
 $B echo 2 > /proc/sys/vm/page-cluster
 $B echo "vm.swappiness=75" >> /system/etc/sysctl.conf
 $B echo "vm.page-cluster=2" >> /system/etc/sysctl.conf
 $B sysctl -e -w vm.swappiness=75
 $B sysctl -e -w vm.page-cluster=2
elif [ "$SWAP" -gt "0" ]; then
 SWAP=$($B free -m | $B awk '{ print $2 }' | $B sed -n 4p)
 $B echo "SWAP detected. Size is $SWAP MB" >> $LOG
 $B echo "Configuring kernel & SWAP frienship.." >> $LOG
 $B echo 30 > /proc/sys/vm/swappiness
 $B echo 2 > /proc/sys/vm/page-cluster
 $B echo "vm.swappiness=30" >> /system/etc/sysctl.conf
 $B echo "vm.page-cluster=2" >> /system/etc/sysctl.conf
 $B sysctl -e -w vm.swappiness=30
 $B sysctl -e -w vm.page-cluster=2
 if [ -e /sys/module/zswap/parameters/enabled ]; then
  $B echo "ZSWAP detected. Enabling.." >> $LOG
  $B echo 1 > /sys/module/zswap/parameters/enabled
  $B echo "LZ4 compression algorithm for ZSWAP" >> $LOG
  $B echo lz4 > /sys/module/zswap/parameters/compressor
 fi;
else
 SWAP=$($B free -m | $B awk '{ print $2 }' | $B sed -n 4p)
 $B echo "No SWAP/ZRAM/RAMZSWAP was detected" >> $LOG
 $B echo "Configuring kernel for swappless system.." >> $LOG
 $B echo 0 > /proc/sys/vm/swappiness
 $B echo 0 > /proc/sys/vm/page-cluster
 $B sysctl -e -w vm.swappiness=0
 $B sysctl -e -w vm.page-cluster=0
 $B echo "vm.swappiness=0" >> /system/etc/sysctl.conf
 $B echo "vm.page-cluster=0" >> /system/etc/sysctl.conf
fi;
SWAP=$($B free -m | $B awk '{ print $2 }' | $B sed -n 4p)
if [ "$SWAP" -gt "0" ]; then
 if [ -e /sys/kernel/mm/uksm/run ]; then
  $B echo "uKSM detected" >> $LOG
  $B echo "uKSM + swappiness is a bad. Disabling KSM.." >> $LOG
  $B echo 0 > /sys/kernel/mm/uksm/run
  setprop ro.config.ksm.support false
 elif [ -e /sys/kernel/mm/ksm/run ]; then
  $B echo "KSM detected" >> $LOG
  $B echo "KSM + swappiness is a bad. Disabling KSM.." >> $LOG
  $B echo 0 > /sys/kernel/mm/ksm/run
  setprop ro.config.ksm.support false
 else
  $B echo "No KSM was detected" >> $LOG
 fi;
elif [ "$SWAP" -eq "0" ]; then
 if [ -e /sys/kernel/mm/ksm/run ]; then
  $B echo "uKSM detected" >> $LOG
  $B echo "Starting and tuning uKSM.." >> $LOG
  $B echo 128 > /sys/kernel/mm/uksm/pages_to_scan
  $B echo 3000 > /sys/kernel/mm/uksm/sleep_millisecs
  $B echo 45 > /sys/kernel/mm/uksm/max_cpu_percentage
  $B echo 1 > /sys/kernel/mm/uksm/run
  setprop ro.config.ksm.support true
 elif [ -e /sys/kernel/mm/ksm/run ]; then
  $B echo "KSM detected" >> $LOG
  $B echo "Starting and tuning KSM.." >> $LOG
  $B echo 128 > /sys/kernel/mm/ksm/pages_to_scan
  $B echo 3000 > /sys/kernel/mm/ksm/sleep_millisecs
  $B echo 1 > /sys/kernel/mm/ksm/run
  setprop ro.config.ksm.support true
 fi;
fi;
$B echo "Paging check completed" >> $LOG
$B echo "" >> $LOG
RAMfree=$($B free -m | $B awk '{ print $4 }' | $B sed -n 2p)
RAMcached=$($B free -m | $B awk '{ print $7 }' | $B sed -n 2p)
RAMreported=$((RAMfree + RAMcached))
SWAP=$($B free -m | $B awk '{ print $2 }' | $B sed -n 4p)
SWAPused=$($B free -m | $B awk '{ print $3 }' | $B sed -n 4p)
$B echo "RAM values now:" >> $LOG
$B echo "  Total:              $RAM MB" >> $LOG
$B echo "  Free:               $RAMreported MB" >> $LOG
$B echo "  Real free:          $RAMfree MB" >> $LOG
$B echo "  Cached:             $RAMcached MB" >> $LOG
$B echo "  SWAP/ZRAM total:    $SWAP MB" >> $LOG
$B echo "  SWAP/ZRAM used:     $SWAPused MB" >> $LOG
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] 003 - ***RAM gear*** - OK" >> $LOG
sync;
