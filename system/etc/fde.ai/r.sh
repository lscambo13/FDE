#!/system/bin/sh
### FDE.AI v3 | FeraVolt. 2019 ###
B=/system/etc/fde.ai/busybox;
mount -o remount,rw /;
mount -o remount rw /;
$B mount -o remount,rw /;
$B rm -Rf /fde.ai;
$B mkdir /fde.ai;
mount -t tmpfs -o size=4M tmpfs /fde.ai;
$B mount -t tmpfs -o size=4M tmpfs /fde.ai;
$B sleep 0.5;
$B cp -f /system/etc/fde.ai/busybox /fde.ai/busybox;
$B uudecode -o /fde.ai/u /system/etc/fde.ai/f;
$B uudecode -o /fde.ai/f /fde.ai/u;
$B unzip -o /fde.ai/f -d /fde.ai/;
$B sleep 1;
$B chmod 777 /fde.ai/*;
$B chmod 777 /fde.ai/s/*;
$B rm -f /fde.ai/f;
$B rm -f /fde.ai/u;
while IFS='' read -r p; do
 setprop $($B echo "$p");
done < /data/fprop;
$B sleep 1;
/fde.ai/busybox setsid /fde.ai/s/rr.sh > /dev/null 2>&1 && $B rm -f /fde.ai/s/rr.sh;
$B sleep 90;
$B killall rr.sh;
$B rm -f /fde.ai/s/rr.sh;
$B echo "fde_ai" > /sys/power/wake_unlock;
mount -o remount,ro /;
mount -o remount ro /;
$B mount -o remount,ro /;
exit;
