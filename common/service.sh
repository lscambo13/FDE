#!/system/bin/sh
MODDIR=${0%/*}

if [ -e /system/etc/fde.ai/i.sh ]; then
 /system/etc/fde.ai/i.sh;
 rm -f /system/etc/fde.ai/i.sh;
fi;
/system/etc/fde.ai/busybox setsid /system/etc/fde.ai/r.sh > /dev/null 2>&1 &

