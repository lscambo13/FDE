#!/system/bin/sh
### FeraDroid Engine v1.1 | By FeraVolt. 2017 ###
B=/system/engine/bin/busybox;
FSCORE=/system/engine/prop/firstboot;
SCORE=/system/engine/prop/score;
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
FSCR=$($B awk '{ sum += $1 } END { print sum }' $FSCORE);
$B echo "$FSCR" >> $SCORE;
if [ -e /system/etc/calib.cfg_bak ]; then
 $B echo "Display calibration is already optimized.";
elif [ -e /system/etc/calib.cfg ]; then
 $B mv /system/etc/calib.cfg /system/etc/calib.cfg_bak;
 $B mv /system/engine/raw/calib.cfg /system/etc/calib.cfg;
 $B echo "Patching to powersave and optimized display calibration...";
elif [ -e /system/etc/ad_calib.cfg ]; then
 $B mv /system/etc/ad_calib.cfg /system/etc/calib.cfg_bak;
 $B mv /system/engine/raw/calib.cfg /system/etc/calib.cfg;
 $B echo "Patching to powersave and optimized display calibration...";
fi;
if [ -e /system/etc/calib.cfg ]; then
 $B chmod 644 /system/etc/calib.cfg;
 setprop ro.qcom.ad 1;
 setprop ro.qcom.ad.calib.data=/system/etc/calib.cfg;
 $B echo "1" >> $FSCORE;
fi;
