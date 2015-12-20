#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2015 ###

B=/system/engine/bin/busybox

$B echo "Apps gear***"
$B echo " "
$B echo " "
$B mount -o rw,remount /system;
for DIR in /system/app /data/app /system/priv-app;
do
 cd $DIR || exit
  for APK in *.apk */*.apk;
  do
  /system/engine/bin/zipalign -f 4 "$APK" /data/local/"$APK";
  if [ -e "/data/local/$APK" ]; then
   $B cp -f -p "/data/local/$APK" "$APK"
   $B rm -f "/data/local/$APK";
  fi;
 done;
done;
$B sleep 1
$B echo " "
$B echo " "
$B echo "***Check***"
sync;

