#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2016 ###

B=/system/engine/bin/busybox
LOG=/sdcard/Android/FDE.txt
TIME=$($B date | $B awk '{ print $4 }')

$B echo "[$TIME] 008 - ***Network gear***" >> $LOG
$B echo "" >> $LOG
$B echo " Writing optimized network parameters to sysctl" >> $LOG
$B echo "net.ipv4.tcp_congestion_control=cubic" >> /system/etc/sysctl.conf
$B echo "net.ipv4.tcp_rfc1337=1" >> /system/etc/sysctl.conf
$B echo "net.ipv4.tcp_window_scaling=1" >> /system/etc/sysctl.conf
$B echo "net.ipv4.tcp_sack=1" >> /system/etc/sysctl.conf
$B echo "net.ipv4.tcp_fack=1" >> /system/etc/sysctl.conf
$B echo "net.ipv4.ip_no_pmtu_disc=0" >> /system/etc/sysctl.conf
$B echo "net.ipv4.tcp_timestamps=1" >> /system/etc/sysctl.conf
$B echo "net.ipv4.tcp_no_metrics_save=1" >> /system/etc/sysctl.conf
$B echo "net.ipv4.tcp_moderate_rcvbuf=1" >> /system/etc/sysctl.conf
$B echo "net.ipv4.tcp_synack_retries=2" >> /system/etc/sysctl.conf
$B echo "net.ipv4.tcp_fin_timeout=30" >> /system/etc/sysctl.conf
$B echo "net.ipv4.ip_forward=1" >> /system/etc/sysctl.conf
$B echo " Executing optimized network parameters via sysctl" >> $LOG
$B sysctl -e -w net.ipv4.tcp_congestion_control=cubic
$B sysctl -e -w net.ipv4.tcp_rfc1337=1
$B sysctl -e -w net.ipv4.tcp_window_scaling=1
$B sysctl -e -w net.ipv4.tcp_sack=1
$B sysctl -e -w net.ipv4.tcp_fack=1
$B sysctl -e -w net.ipv4.ip_no_pmtu_disc=0
$B sysctl -e -w net.ipv4.tcp_timestamps=1
$B sysctl -e -w net.ipv4.tcp_no_metrics_save=1
$B sysctl -e -w net.ipv4.tcp_moderate_rcvbuf=1
$B sysctl -e -w net.ipv4.tcp_synack_retries=2
$B sysctl -e -w net.ipv4.tcp_fin_timeout=30
$B sysctl -e -w net.ipv4.ip_forward=1

$B echo " Tuning Android networking settings.." >> $LOG
setprop wifi.supplicant_scan_interval 180
sync;

if [ -e /system/xbin/sqlite3 ]; then
 $B echo " Tuning WiFi.." >> $LOG
 /system/xbin/sqlite3 /data/data/com.android.providers.settings/databases/settings.db "INSERT INTO secure (name, value) VALUES ('wifi_country_code', 'JP');"
 wifi_idle_wait=180000
 RV=$(/system/xbin/sqlite3 /data/data/com.android.providers.settings/databases/settings.db "select value from secure where name='wifi_idle_ms'")
 if [ "$RV" = '' ]; then
  /system/xbin/sqlite3 /data/data/com.android.providers.settings/databases/settings.db "insert into secure (name, value) values ('wifi_idle_ms', $wifi_idle_wait )"
 else
  /system/xbin/sqlite3 /data/data/com.android.providers.settings/databases/settings.db "update secure set value=$wifi_idle_wait where name='wifi_idle_ms'"
 fi;
fi;

$B echo "" >> $LOG
$B echo "[$TIME] 008 - ***Network gear*** - OK" >> $LOG
sync;

