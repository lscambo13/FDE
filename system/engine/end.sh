#!/system/bin/sh
### FeraDroid Engine v0.20 | By FeraVolt. 2016 ###

B=/system/engine/bin/busybox
LOG=/sdcard/Android/FDE.txt
$B echo "Mediaserver kill" >> $LOG
$B killall -9 android.process.media
$B killall -9 mediaserver
$B echo "Fix permissions and zipalign.." >> $LOG
/system/engine/fix.sh
sync;
$B killall -9 com.google.android.gms
$B killall -9 com.google.android.gms.persistent
$B killall -9 com.google.process.gapps
$B killall -9 com.google.android.gsf
$B killall -9 com.google.android.gsf.persistent
if [ -e /system/engine/prop/firstboot ]; then
 $B echo "Google Play services fix" >> $LOG
 /system/engine/gp.sh
fi;
$B mount -o remount,rw /system
if [ -e /etc/fstab ]; then
 $B echo "FStab onboard.." >> $LOG
else
 $B cp /fstab.* /etc/fstab
fi;
$B fsck -A -C -V -T | $B tee -a $LOG
$B echo "FStrim init.." >> $LOG
$B echo "Trim /system" >> $LOG
$B fstrim -v /system | $B tee -a $LOG
$B echo "Trim /data" >> $LOG
$B fstrim -v /data | $B tee -a $LOG
$B echo "Trim /cache" >> $LOG
$B fstrim -v /cache | $B tee -a $LOG
sync;
$B sleep 1
if [ -e /system/xbin/sqlite3 ]; then
$B echo "Optimizing DataBases.." >> $LOG
for i in \
$($B find /data -iname "*.db") 
do \
 /system/xbin/sqlite3 "$i" 'VACUUM;'
 /system/xbin/sqlite3 "$i" 'REINDEX;'
done;
for i in \
$($B find /sdcard -iname "*.db")
do \
 /system/xbin/sqlite3 "$i" 'VACUUM;'
 /system/xbin/sqlite3 "$i" 'REINDEX;'
done;
fi;
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] Applying kernel configuration.." >> $LOG
sysctl -p | $B tee -a $LOG
$B echo "Sleep, sync and free RAM" >> $LOG
/system/engine/bin/boost | $B tee -a $LOG
$B echo "Remounting /system - RO" >> $LOG
$B mount -o remount,ro /system
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] END end" >> $LOG
