#!/system/bin/sh
### FeraDroid Engine v1.1 | By FeraVolt. 2017 ###
B=/system/engine/bin/busybox;
FSCORE=/system/engine/prop/fscore;
SCORE=/system/engine/prop/score;
mount -o remount,rw /data;
mount -o remount,rw /system;
$B echo "Re-calibrating battery...";
dumpsys batteryinfo --reset;
dumpsys batterystats --reset;
$B rm - f /data/system/batterystats.bin;
$B rm - f /data/system/batterystats-checkin.bin;
$B echo "1" > $FSCORE;
if [ -e /sys/devices/platform/i2c-gpio.9/i2c-9/9-0036/power_supply/fuelgauge/fg_reset_soc ]; then
 $B echo "Fuelgauge report reset.";
 $B echo "1" > /sys/devices/platform/i2c-gpio.9/i2c-9/9-0036/power_supply/fuelgauge/fg_reset_soc;
 $B echo "1" >> $FSCORE;
fi;
if [ -e /system/etc/calib.cfg_bak ]; then
 $B echo "Display calibration is already optimized.";
elif [ -e /system/etc/calib.cfg ]; then
 $B mv /system/etc/calib.cfg /system/etc/calib.cfg_bak;
 $B mv /system/engine/raw/calib.cfg /system/etc/calib.cfg;
 $B echo "Patching to powersave and optimized display calibration...";
 $B echo "1" >> $FSCORE;
elif [ -e /system/etc/ad_calib.cfg ]; then
 $B mv /system/etc/ad_calib.cfg /system/etc/calib.cfg_bak;
 $B mv /system/engine/raw/calib.cfg /system/etc/calib.cfg;
 $B echo "Patching to powersave and optimized display calibration...";
 $B echo "1" >> $FSCORE;
fi;
if [ -e /data/misc/mtkgps.dat ]; then
 $B rm -f /data/misc/mtkgps.dat;
 $B echo "MTK GPS data cleared.";
 $B echo "1" >> $FSCORE;
fi;
if [ -e /data/misc/epo.dat ]; then
 $B rm -f /data/misc/epo.dat;
 $B echo "EPO data cleared.";
 $B echo "1" >> $FSCORE;
fi;
if [ ! -e /system/etc/gps_fde_bak ]; then
 if [ -e /system/etc/gps.conf ]; then
  $B cp /system/etc/gps.conf /system/etc/gps_fde_bak
 else
  $B touch /system/etc/gps.conf;
 fi;
 $B chmod 777 /system/etc/gps.conf;
 $B echo "Patching GPS config...";
 $B sed -e "s=DEBUG_LEVEL=#=" -i /system/etc/gps.conf;
 $B sed -e "s=ERR_ESTIMATE=#=" -i /system/etc/gps.conf;
 $B sed -e "s=NTP_SERVER=#=" -i /system/etc/gps.conf;
 $B sed -e "s=XTRA_=#=" -i /system/etc/gps.conf;
 $B sed -e "s=DEFAULT=#=" -i /system/etc/gps.conf;
 $B sed -e "s=INTERMEDIATE=#=" -i /system/etc/gps.conf;
 $B sed -e "s=ACCURACY=#=" -i /system/etc/gps.conf;
 $B sed -e "s=SUPL_HOST=#=" -i /system/etc/gps.conf;
 $B sed -e "s=SUPL_PORT=#=" -i /system/etc/gps.conf;
 $B sed -e "s=NMEA=#=" -i /system/etc/gps.conf;
 $B sed -e "s=CAPABILITIES=#=" -i /system/etc/gps.conf;
 $B sed -e "s=SUPL_ES=#=" -i /system/etc/gps.conf;
 $B sed -e "s=USE_EMERGENCY=#=" -i /system/etc/gps.conf;
 $B sed -e "s=SUPL_MODE=#=" -i /system/etc/gps.conf;
 $B sed -e "s=SUPL_VER=#=" -i /system/etc/gps.conf;
 $B sed -e "s=REPORT=#=" -i /system/etc/gps.conf;
 {
  $B echo "   "
  $B echo "   "
  $B echo "### FeraDroid Engine v1.1 | By FeraVolt. 2017 ###"
  $B echo "DEBUG_LEVEL=0"
  $B echo "ERR_ESTIMATE=0"
  $B echo "NTP_SERVER=time.izatcloud.net"
  $B echo "CAPABILITIES=0x37"
  $B echo "DEFAULT_AGPS_ENABLE=TRUE"
  $B echo "DEFAULT_USER_PLANE=TRUE"
  $B echo "INTERMEDIATE_POS=0"
  $B echo "NMEA_PROVIDER=0"
  $B echo "REPORT_POSITION_USE_SUPL_REFLOC=1"
  $B echo "XTRA_SERVER_1=http://xtrapath1.izatcloud.net/xtra2.bin"
  $B echo "XTRA_SERVER_2=http://xtrapath2.izatcloud.net/xtra2.bin"
  $B echo "XTRA_SERVER_3=http://xtrapath3.izatcloud.net/xtra2.bin"
  $B echo "XTRA_VERSION_CHECK=0"
  $B echo "SUPL_ES=0"
  $B echo "USE_EMERGENCY_PDN_FOR_EMERGENCY_SUPL=1"
  $B echo "SUPL_MODE=1"
  $B echo "SUPL_HOST=supl.qxwz.com"
  $B echo "SUPL_PORT=7275"
  $B echo "SUPL_VER=0x20000"
  $B echo "   "
 } >> /system/etc/gps.conf;
 $B chmod 644 /system/etc/gps.conf;
else
 $B echo "GPS config is already patched.";
 $B echo "1" >> $FSCORE;
fi;
$B echo "Tuning Android power-saving...";
setprop power.saving.mode 1;
setprop persist.radio.ramdump 0;
setprop pm.sleep_mode 1;
setprop ro.ril.disable.power.collapse 0;
setprop ro.semc.enable.fast_dormancy false;
setprop ro.ril.fast.dormancy.rule 0;
setprop ro.ril.fast.dormancy 0;
setprop ro.config.hw_power_saving 1;
setprop dev.pm.dyn_samplingrate 1;
setprop persist.radio.add_power_save 1;
setprop ro.com.google.networklocation 0;
setprop ro.ril.def.agps.feature 1;
setprop ro.ril.def.agps.mode 2;
setprop ro.gps.agps_provider 1;
$B echo "1" >> $FSCORE;
FSCR=$($B awk '{ sum += $1 } END { print sum }' $FSCORE);
$B echo "$FSCR" >> $SCORE;
