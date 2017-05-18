#!/system/bin/sh
### FeraDroid Engine v1.1 | By FeraVolt. 2017 ###
B=/system/engine/bin/busybox;

if [ -e /system/etc/calib.cfg ]; then
 $B chmod 644 /system/etc/calib.cfg;
 $B echo "Assertive display detected. Calibrating...";
 setprop ro.qcom.ad 1;
 setprop ro.qcom.ad.calib.data=/system/etc/calib.cfg;
 $B echo "1" >> $FSCORE;
fi;
