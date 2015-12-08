#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2015 ###

B=/system/engine/bin/busybox

$B echo "***RAM gear***"
RAM=$((`$B free | $B awk '{ print $2 }' | $B sed -n 2p`/1024))
RAMfree=$((`$B free | $B awk '{ print $4 }' | $B sed -n 2p`/1024))
RAMcached=$((`$B free | $B awk '{ print $7 }' | $B sed -n 2p`/1024))
RAMreported=$(($RAMfree + $RAMcached))
SWAP=$((`$B free | $B awk '{ print $2 }' | $B sed -n 4p`/1024))
SWAPused=$((`$B free | $B awk '{ print $3 }' | $B sed -n 4p`/1024))
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
RAMfree=$((`$B free | $B awk '{ print $4 }' | $B sed -n 2p`/1024))
RAMcached=$((`$B free | $B awk '{ print $7 }' | $B sed -n 2p`/1024))
RAMreported=$(($RAMfree + $RAMcached))
SWAP=$((`$B free | $B awk '{ print $2 }' | $B sed -n 4p`/1024))
SWAPused=$((`$B free | $B awk '{ print $3 }' | $B sed -n 4p`/1024))
$B echo " "
$B echo "NOW:"
$B echo "Realy free RAM is $RAMfree MB"
$B echo "System repored free RAM is $RAMreported MB"
$B echo "Cached RAM is $RAMcached MB"
$B echo "SWAP/ZRAM is $SWAP MB"
$B echo "Used SWAP/ZRAM is $SWAPused MB"
$B echo " "
$B echo "***Check***"
sync;

