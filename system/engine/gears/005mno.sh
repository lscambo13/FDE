#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2015 ###

B=/system/engine/bin/busybox

$B echo "***Kernel configuration gear***"
$B echo " "
$B echo " "
$B echo "Creating kernel config file.."
$B rm -f /system/etc/sysctl.conf
$B touch /system/etc/sysctl.conf
$B echo "Setting proper permissions.."
$B chmod 777 /system/etc/sysctl.conf

$B sysctl -e -w kernel.random.read_wakeup_threshold=1536
$B sysctl -e -w kernel.random.write_wakeup_threshold=512

sysctl -p
$B echo "***Check***"
sync;

