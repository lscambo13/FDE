echo "FeraDroid Engine"
echo "version 0.19"
echo "By FeraVolt."

if [ -e /system/engine/prop/firstboot ];
then
   /system/xbin/sysrw
   sh /system/engine/fix.sh
   sleep 54
   sleep 54
   sleep 54
   /system/xbin/sysrw
   rm -f /system/engine/prop/firstboot
   rm -f /system/usr/vendor/prop/notferalab
   exit
else

/system/engine/bin/run-parts /system/engine/tweaks
chmod 644 /system/build.prop
chmod -R 777 /system/etc/sysctl.conf
rm -f /data/cache/*.apk
rm -f /data/cache/*.tmp
rm -f /data/dalvik-cache/*.apk
rm -f /data/dalvik-cache/*.tmp
rm -Rf /system/lost+found/*
rm -f /data/tombstones/*
rm -f /mnt/sdcard/LOST.DIR/*
rm -Rf /mnt/sdcard/LOST.DIR
rm -f /mnt/sdcard/found000/*
rm -Rf /mnt/sdcard/found000
rm -f /mnt/sdcard/fix_permissions.log
chmod 000 /data/tombstones

