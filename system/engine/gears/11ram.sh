#!/system/bin/sh
### FeraDroid Engine v0.25 | By FeraVolt. 2017 ###
B=/system/engine/bin/busybox;
RZS=/system/engine/bin/rzscontrol;
TIME=$($B date | $B awk '{ print $4 }');
$B echo "[$TIME] ***RAM gear***";
RAM=$($B free -m | $B awk '{ print $2 }' | $B sed -n 2p);
RAMfree=$($B free -m | $B awk '{ print $4 }' | $B sed -n 2p);
RAMcached=$($B free -m | $B awk '{ print $7 }' | $B sed -n 2p);
RAMreported=$((RAMfree + RAMcached));
SWAP=$($B free -m | $B awk '{ print $2 }' | $B sed -n 4p);
SWAPused=$($B free -m | $B awk '{ print $3 }' | $B sed -n 4p);
CORES=$($B grep -c 'processor' /proc/cpuinfo);
if [ "$RAM" -gt "1024" ]; then
 FZRAM=$((RAM/4));
 PZ=45;
elif [ "$RAM" -gt "512" ]; then
 FZRAM=$(((RAM/3)+96));
 PZ=45;
elif [ "$RAM" -le "512" ]; then
 FZRAM=$((RAM-96));
 PZ=50;
fi;
$B echo "Current RAM values:";
$B echo "  Total:              $RAM MB";
$B echo "  Free:               $RAMreported MB";
$B echo "  Real free:          $RAMfree MB";
$B echo "  Cached:             $RAMcached MB";
$B echo "  SWAP/ZRAM total:    $SWAP MB";
$B echo "  SWAP/ZRAM used:     $SWAPused MB";
$B echo "Freeing RAM...";
sync;
$B sleep 1;
$B echo "3" > /proc/sys/vm/drop_caches;
$B sleep 3;
$B mount -o remount,rw /system;
if [ -e /sbin/sysrw ]; then
 /sbin/sysrw;
fi;
sync;
$B echo "Paging check..";
if [ -e /sys/block/zram0/disksize ]; then
 SWAP=$($B free -m | $B awk '{ print $2 }' | $B sed -n 4p);
 ZRAM0=$($B cat /sys/block/zram0/disksize);
 ZZRAM=$((ZRAM0/1024/1024));
 $B echo "ZRAM detected. Size is $ZZRAM MB";
 if [ "$RAM" -gt "2048" ]; then
  $B echo "You don't need zRAM";
  $B echo "Stopping swappiness..";
  $B swapoff /dev/block/zram0 > /dev/null 2>&1;
  $B echo "0" > /sys/block/zram0/disksize;
  $B umount /dev/block/zram0;
  if [ -e /sys/block/zram1/disksize ]; then
   $B swapoff /dev/block/zram1 > /dev/null 2>&1;
   $B echo "0" > /sys/block/zram1/disksize;
   $B umount /dev/block/zram1;
  fi;
  $B sleep 1;
  sync;
 else
  $B echo "Perfect ZRAM size according to your RAM should be $FZRAM MB";
  $B echo "Applying new ZRAM parameters..";
  if [ "$SWAP" -gt "0" ]; then
   $B echo "Stopping swappiness..";
   $B swapoff /dev/block/zram0 > /dev/null 2>&1;
   $B echo "0" > /sys/block/zram0/disksize;
   $B umount /dev/block/zram0;
   if [ -e /sys/block/zram1/disksize ]; then
    $B swapoff /dev/block/zram1 > /dev/null 2>&1;
    $B echo "0" > /sys/block/zram1/disksize;
    $B umount /dev/block/zram1;
    $B sleep 1;
    $B echo "1" > /sys/block/zram1/reset;
    $B sleep 1;
   fi;
   $B sleep 1;
   sync;
  fi;
  $B echo "Resetting ZRAM blockdev..";
  $B echo "1" > /sys/block/zram0/reset;
  $B sleep 1;
  $B echo "Creating ZRAM blockdev - $FZRAM MB";
  $B echo "$((FZRAM*1024*1024))" > /sys/block/zram0/disksize;
  if [ -e /sys/block/zram0/comp_algorithm ]; then
   $B echo "Setting compression algorithm to LZ4..";
   $B echo "lz4" > /sys/block/zram0/comp_algorithm;
  fi;
  if [ -e /sys/module/zram/parameters/lzo_algo_type ]; then
   $B echo "Setting compression algorithm to LZO..";
   $B chmod 644 /sys/module/zram/parameters/lzo_algo_type;
   $B echo "1" > /sys/module/zram/parameters/lzo_algo_type;
  fi;
  if [ -e /sys/block/zram0/max_comp_streams ]; then
   $B echo "Set max compression streams..";
   $B echo "2" > /sys/block/zram0/max_comp_streams;
  fi;
  $B echo "Starting swappiness..";
  $B mkswap /dev/block/zram0 > /dev/null 2>&1;
  $B swapon /dev/block/zram0 > /dev/null 2>&1;
 fi;
elif [ -e /sys/block/ramzswap0/size ]; then
 SWAP=$($B free -m | $B awk '{ print $2 }' | $B sed -n 4p);
 RZ=$($B cat /sys/block/ramzswap0/size);
 ZRZ=$((RZ/1024));
 $B echo "RAMZSWAP detected. Size is $ZRZ MB";
 $B echo "Perfect RAMZSWAP size according to your RAM should be $FZRAM MB";
 ZRF=$((FZRAM*1024));
 if [ "$ZRZ" -ge "$FZRAM" ]; then
  $B echo "Size of your RAMZSWAP is OK";
  sync;
 else
  $B echo "Applying new RAMZSWAP parameters..";
  if [ "$SWAP" -gt "0" ]; then
   $B echo "Stopping swappiness..";
   sync;
   $B sleep 1;
   $B swapoff /dev/block/ramzswap0;
   $B sleep 1;
   sync;
  fi;
  $B echo "Resetting RAMZSWAP blockdev..";
  $RZS /dev/block/ramzswap0 --reset;
  $B sleep 1;
  $B echo "Creating RAMZSWAP blockdev - $FZRAM MB";
  $RZS /dev/block/ramzswap0 -i -d $ZRF;
  $B sleep 1;
  $B echo "Starting swappiness..";
  $B swapon /dev/block/ramzswap0;
  $B echo "100" > /proc/sys/vm/swappiness;
  $B echo "vm.swappiness=100" >> /system/etc/sysctl.conf;
  $B sysctl -e -w vm.swappiness=100;
  setprop sys.vm.swappiness 100;
 fi;
elif [ "$SWAP" -gt "0" ]; then
 SWAP=$($B free -m | $B awk '{ print $2 }' | $B sed -n 4p);
 $B echo "SWAP detected. Size is $SWAP MB";
 $B echo "Configuring kernel & SWAP frienship..";
 $B echo "40" > /proc/sys/vm/swappiness;
 $B echo "vm.swappiness=40" >> /system/etc/sysctl.conf;
 $B sysctl -e -w vm.swappiness=40;
 setprop sys.vm.swappiness 40;
 if [ -e /sys/module/zswap/parameters/enabled ]; then
  $B echo "ZSWAP detected. Enabling..";
  $B echo "1" > /sys/module/zswap/parameters/enabled;
  $B echo "LZ4 compression algorithm for ZSWAP";
  $B echo "lz4" > /sys/module/zswap/parameters/compressor;
 fi;
fi;
SWAP=$($B free -m | $B awk '{ print $2 }' | $B sed -n 4p);
if [ -e /sys/block/zram0/disksize ]; then
 if [ "$SWAP" -gt "0" ]; then
  setprop ro.config.zram.support true;
  setprop zram.disksize $FZRAM;
  $B echo "80" > /proc/sys/vm/swappiness;
  $B echo "vm.swappiness=80" >> /system/etc/sysctl.conf;
  $B sysctl -e -w vm.swappiness=80;
  setprop sys.vm.swappiness 80;
  if [ -e /sys/module/zram/parameters/total_mem_usage_percent ]; then
   $B echo "Tuning ZRAM parameter..";
   $B echo "$PZ" > /sys/module/zram/parameters/total_mem_usage_percent;
  fi;
  if [ -e /sys/block/zram0/compact ]; then
   $B echo "Activate ZRAM compaction..";
   $B echo "1" > /sys/block/zram0/compact;
  fi;
 fi;
fi;
if [ "$SWAP" -eq "0" ]; then
 $B echo "Configuring kernel for swappless system..";
 $B echo "0" > /proc/sys/vm/swappiness;
 $B echo "vm.swappiness=0" >> /system/etc/sysctl.conf;
 $B sysctl -e -w vm.swappiness=0;
 setprop sys.vm.swappiness 0;
fi;
if [ "$RAM" -le "512" ]; then
 if [ "$CORES" -ge "2" ]; then
  $B echo "Small RAM - KSM wanted..";
  if [ -e /sys/kernel/mm/uksm/run ]; then
   $B echo "uKSM detected";
   $B echo "Starting and tuning uKSM..";
   $B echo "128" > /sys/kernel/mm/uksm/pages_to_scan;
   $B echo "9000" > /sys/kernel/mm/uksm/sleep_millisecs;
   $B echo "45" > /sys/kernel/mm/uksm/max_cpu_percentage;
   $B echo "1" > /sys/kernel/mm/uksm/run;
   $B echo "1" > /sys/kernel/mm/uksm/deferred_timer;
   setprop ro.config.ksm.support true;
  elif [ -e /sys/kernel/mm/ksm/run ]; then
   $B echo "KSM detected";
   $B echo "Starting and tuning KSM..";
   $B echo "128" > /sys/kernel/mm/ksm/pages_to_scan;
   $B echo "9000" > /sys/kernel/mm/ksm/sleep_millisecs;
   $B echo "1" > /sys/kernel/mm/ksm/run;
   $B echo "1" > /sys/kernel/mm/ksm/deferred_timer;
   setprop ro.config.ksm.support true;
  else
   $B echo "No KSM was detected";
  fi;
 fi;
else
 if [ -e /sys/kernel/mm/uksm/run ]; then
  $B echo "uKSM detected";
  $B echo "Disabling KSM..";
  $B echo "0" > /sys/kernel/mm/uksm/run;
  setprop ro.config.ksm.support false;
 elif [ -e /sys/kernel/mm/ksm/run ]; then
  $B echo "KSM detected";
  $B echo "Disabling KSM..";
  $B echo "0" > /sys/kernel/mm/ksm/run;
  setprop ro.config.ksm.support false;
 else
  $B echo "No KSM was detected";
 fi;
fi;
$B echo "Paging check completed";
sync;
$B sleep 1;
$B echo "3" > /proc/sys/vm/drop_caches;
$B sleep 1;
sync;
RAMfree=$($B free -m | $B awk '{ print $4 }' | $B sed -n 2p);
RAMcached=$($B free -m | $B awk '{ print $7 }' | $B sed -n 2p);
RAMreported=$((RAMfree + RAMcached));
SWAP=$($B free -m | $B awk '{ print $2 }' | $B sed -n 4p);
SWAPused=$($B free -m | $B awk '{ print $3 }' | $B sed -n 4p);
$B echo "RAM values now:";
$B echo "  Total:              $RAM MB";
$B echo "  Free:               $RAMreported MB";
$B echo "  Real free:          $RAMfree MB";
$B echo "  Cached:             $RAMcached MB";
$B echo "  SWAP/ZRAM total:    $SWAP MB";
$B echo "  SWAP/ZRAM used:     $SWAPused MB";
TIME=$($B date | $B awk '{ print $4 }');
$B echo "[$TIME] ***RAM gear*** - OK";
sync;

