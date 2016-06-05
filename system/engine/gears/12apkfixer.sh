#!/system/bin/sh
### FeraDroid Engine v21 | By FeraVolt. 2016 ###
B=/system/engine/bin/busybox
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] ***APK-fixer gear***"
ZIPALIGNDB=/data/zipalign.db
if [ ! -f $ZIPALIGNDB ]; then
 $B touch $ZIPALIGNDB
fi;
for DIR in /system/app /system/priv-app /data/app; do
 cd $DIR
 for APK in *.apk; do
  if [ $APK -ot $ZIPALIGNDB ] && [ $($B grep "$DIR/$APK" $ZIPALIGNDB | $B wc -l) -gt 0 ]; then
   $B echo "Already checked: $DIR/$APK"
  else
   ZIPCHECK=`/system/xbin/zipalign -c -v 4 $APK | $B grep FAILED | $B wc -l`
   if [ $ZIPCHECK = "1" ]; then
    $B echo "Now aligning: $DIR/$APK"
    /system/engine/bin/zipalign -v -f 4 $APK /sdcard/download/$APK
    $B mount -o rw,remount /system
    $B cp -f -p /sdcard/download/$APK $APK
    $B grep "$DIR/$APK" $ZIPALIGNDB > /dev/null || echo $DIR/$APK >> $ZIPALIGNDB
   else
    $B echo "Already aligned: $DIR/$APK"
    $B grep "$DIR/$APK" $ZIPALIGNDB > /dev/null || echo $DIR/$APK >> $ZIPALIGNDB
   fi;
  fi;
 done;
done;
$B touch $ZIPALIGNDB
$B chmod 644 /system/app/*
$B chmod 644 /system/priv-app/*
$B chmod 644 /data/app/*
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] ***APK-fixer gear*** - OK"
