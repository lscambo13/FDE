#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2016 ###

B=/system/engine/bin/busybox
LOG=/sdcard/Android/FDE.txt
SDK=$(getprop ro.build.version.sdk)
TIME=$($B date | $B awk '{ print $4 }')

$B echo "" >> $LOG
$B echo "[$TIME] 008 - ***Network gear***" >> $LOG
$B mount -o remount,rw /system
$B echo "Writing optimized network parameters to sysctl" >> $LOG
$B echo "net.ipv4.tcp_congestion_control=cubic" >> /system/etc/sysctl.conf
$B echo "net.ipv4.tcp_rfc1337=1" >> /system/etc/sysctl.conf
$B echo "net.ipv4.tcp_window_scaling=1" >> /system/etc/sysctl.conf
$B echo "net.ipv4.tcp_sack=1" >> /system/etc/sysctl.conf
$B echo "net.ipv4.tcp_fack=1" >> /system/etc/sysctl.conf
$B echo "net.ipv4.ip_no_pmtu_disc=0" >> /system/etc/sysctl.conf
$B echo "net.ipv4.tcp_timestamps=0" >> /system/etc/sysctl.conf
$B echo "net.ipv4.tcp_no_metrics_save=1" >> /system/etc/sysctl.conf
$B echo "net.ipv4.tcp_moderate_rcvbuf=1" >> /system/etc/sysctl.conf
$B echo "net.ipv4.tcp_synack_retries=2" >> /system/etc/sysctl.conf
$B echo "net.ipv4.tcp_fin_timeout=30" >> /system/etc/sysctl.conf
$B echo "net.ipv4.conf.all.rp_filter=2" >> /system/etc/sysctl.conf
$B echo "net.ipv4.conf.default.rp_filter=2" >> /system/etc/sysctl.conf
$B echo "net.ipv4.tcp_synack_retries=2" >> /system/etc/sysctl.conf
$B echo "Executing optimized network parameters via sysctl" >> $LOG
$B sysctl -e -w net.ipv4.tcp_congestion_control=cubic
$B sysctl -e -w net.ipv4.tcp_rfc1337=1
$B sysctl -e -w net.ipv4.tcp_window_scaling=1
$B sysctl -e -w net.ipv4.tcp_sack=1
$B sysctl -e -w net.ipv4.tcp_fack=1
$B sysctl -e -w net.ipv4.ip_no_pmtu_disc=0
$B sysctl -e -w net.ipv4.tcp_timestamps=0
$B sysctl -e -w net.ipv4.tcp_no_metrics_save=1
$B sysctl -e -w net.ipv4.tcp_moderate_rcvbuf=1
$B sysctl -e -w net.ipv4.tcp_synack_retries=2
$B sysctl -e -w net.ipv4.tcp_fin_timeout=30
$B sysctl -e -w net.ipv4.conf.all.rp_filter=2
$B sysctl -e -w net.ipv4.conf.default.rp_filter=2
$B sysctl -e -w net.ipv4.tcp_synack_retries=2

$B echo "Tuning Android networking settings.." >> $LOG
setprop wifi.supplicant_scan_interval 900
setprop ro.ril.enable.3g.prefix 1
setprop ro.ril.enable.sdr 1
setprop ro.ril.enable.gea3 1
setprop ro.ril.enable.a52 0
setprop ro.ril.enable.a53 1
setprop ro.ril.hsxpa 3
setprop ro.ril.gprsclass 12
setprop ro.ril.hep 1
setprop ro.ril.hsdpa.category 8
setprop ro.ril.hsupa.category 6
setprop net.dns1 8.8.8.8
setprop net.dns2 8.8.4.4
setprop net.rmnet0.dns1 8.8.8.8
setprop net.rmnet0.dns2 8.8.4.4
setprop ro.ril.enable.amr.wideband 1
$B echo "nameserver 8.8.8.8" > /system/etc/resolv.conf
$B echo "nameserver 8.8.4.4" >> /system/etc/resolv.conf
$B echo "" >> /system/etc/resolv.conf
sync;

if [ "$SDK" -le "14" ]; then
 if [ -e /system/xbin/sqlite3 ]; then
  $B echo "Tuning WiFi.." >> $LOG
  /system/xbin/sqlite3 /data/data/com.android.providers.settings/databases/settings.db "INSERT INTO secure (name, value) VALUES ('wifi_country_code', 'JP');"
 fi;
fi;

TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] 008 - ***Network gear*** - OK" >> $LOG
sync;

