#!/system/bin/sh
### FeraDroid Engine v0.22 | By FeraVolt. 2017 ###
B=/system/engine/bin/busybox
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] ***GPS gear***"
$B mount -o remount,rw /system
$B mount -o remount,rw /data
if [ -e /data/misc/mtkgps.dat ]; then
 $B rm -f /data/misc/mtkgps.dat
 $B echo "MTK GPS data cleared."
fi;
if [ -e /data/misc/epo.dat ]; then
 $B rm -f /data/misc/epo.dat
 $B echo "EPO data cleared."
fi;
if [ -e /system/engine/prop/nogps ]; then
 if [ -e /system/etc/gps ]; then
  $B echo "Patched GPS."
 else
  $B echo "Patching GPS config..."
  if [ -e /system/etc/gps.conf ]; then
   $B chmod 777 /system/etc/gps.conf
  else
   $B touch /system/etc/gps.conf
  fi;
  $B sed -e "s=DEBUG_LEVEL=#=" -i /system/etc/gps.conf
  $B sed -e "s=ERR_ESTIMATE=#=" -i /system/etc/gps.conf
  $B sed -e "s=NTP_SERVER=#=" -i /system/etc/gps.conf
  $B sed -e "s=XTRA_=#=" -i /system/etc/gps.conf
  $B sed -e "s=DEFAULT=#=" -i /system/etc/gps.conf
  $B sed -e "s=INTERMEDIATE=#=" -i /system/etc/gps.conf
  $B sed -e "s=ACCURACY=#=" -i /system/etc/gps.conf
  $B sed -e "s=SUPL_HOST=#=" -i /system/etc/gps.conf
  $B sed -e "s=SUPL_PORT=#=" -i /system/etc/gps.conf
  $B sed -e "s=NMEA=#=" -i /system/etc/gps.conf
  $B sed -e "s=CAPABILITIES=#=" -i /system/etc/gps.conf
  $B sed -e "s=SUPL_ES=#=" -i /system/etc/gps.conf
  $B sed -e "s=USE_EMERGENCY=#=" -i /system/etc/gps.conf
  $B sed -e "s=SUPL_MODE=#=" -i /system/etc/gps.conf
  $B sed -e "s=SUPL_VER=#=" -i /system/etc/gps.conf
  $B sed -e "s=REPORT=#=" -i /system/etc/gps.conf
  $B echo "" >> /system/etc/gps.conf
  $B echo "### FeraDroid Engine v0.22 | By FeraVolt. 2017 ###" >> /system/etc/gps.conf
  $B echo "DEBUG_LEVEL=0" >> /system/etc/gps.conf
  $B echo "ERR_ESTIMATE=0" >> /system/etc/gps.conf
  $B echo "NTP_SERVER=time.gpsonextra.net" >> /system/etc/gps.conf
  $B echo "NTP_SERVER=pool.ntp.org" >> /system/etc/gps.conf
  $B echo "CAPABILITIES=0x37" >> /system/etc/gps.conf
  $B echo "DEFAULT_AGPS_ENABLE=TRUE" >> /system/etc/gps.conf
  $B echo "DEFAULT_USER_PLANE=TRUE" >> /system/etc/gps.conf
  $B echo "INTERMEDIATE_POS=1" >> /system/etc/gps.conf
  $B echo "ACCURACY_THRES=1000" >> /system/etc/gps.conf
  $B echo "NMEA_PROVIDER=0" >> /system/etc/gps.conf
  $B echo "REPORT_POSITION_USE_SUPL_REFLOC=1" >> /system/etc/gps.conf
  $B echo "XTRA_SERVER_1=http://xtrapath1.izatcloud.net/xtra2.bin" >> /system/etc/gps.conf
  $B echo "XTRA_SERVER_2=http://xtrapath2.izatcloud.net/xtra2.bin" >> /system/etc/gps.conf
  $B echo "XTRA_SERVER_3=http://xtrapath3.izatcloud.net/xtra2.bin" >> /system/etc/gps.conf
  $B echo "XTRA_VERSION_CHECK=1" >> /system/etc/gps.conf
  $B echo "SUPL_ES=1" >> /system/etc/gps.conf
  $B echo "USE_EMERGENCY_PDN_FOR_EMERGENCY_SUPL=1" >> /system/etc/gps.conf
  $B echo "SUPL_MODE=1" >> /system/etc/gps.conf
  $B echo "SUPL_HOST=supl.google.com" >> /system/etc/gps.conf
  $B echo "SUPL_PORT=7276" >> /system/etc/gps.conf
  $B echo "SUPL_NO_SECURE_PORT=3425" >> /system/etc/gps.conf
  $B echo "SUPL_VER=0x20000" >> /system/etc/gps.conf
  $B chmod 644 /system/etc/gps.conf
  $B rm -f /system/engine/prop/nogps
  $B touch /system/etc/gps
  $B echo "1" > /system/etc/gps
 fi;
fi;
$B echo "[$TIME] ***GPS gear*** - OK"
sync;
