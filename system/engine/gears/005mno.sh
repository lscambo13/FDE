#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2015 ###

B=/system/engine/bin/busybox

$B echo "***Kernel configuration gear***"
if [ -e /system/etc/sysctl.conf ]; then
 sync;
else
 $B touch /system/etc/sysctl.conf
 $B echo "Creating kernel config file.."
fi;
$B echo "Setting proper permissions.."
$B chmod 777 /system/etc/sysctl.conf

$B echo "***Check***"
sync;

