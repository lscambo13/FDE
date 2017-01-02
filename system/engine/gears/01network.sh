#!/system/bin/sh
### FeraDroid Engine v0.22 | By FeraVolt. 2017 ###
B=/system/engine/bin/busybox
SDK=$(getprop ro.build.version.sdk)
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] ***Network gear***"
$B mount -o remount,rw /system
$B echo "Writing optimized network parameters to sysctl"
$B echo "net.ipv4.tcp_timestamps=0" >> /system/etc/sysctl.conf
$B echo "net.ipv4.tcp_rfc1337=1" >> /system/etc/sysctl.conf
$B echo "net.ipv4.tcp_window_scaling=1" >> /system/etc/sysctl.conf
$B echo "net.ipv4.tcp_sack=1" >> /system/etc/sysctl.conf
$B echo "net.ipv4.tcp_fack=1" >> /system/etc/sysctl.conf
$B echo "net.ipv4.ip_no_pmtu_disc=0" >> /system/etc/sysctl.conf
$B echo "net.ipv4.tcp_moderate_rcvbuf=1" >> /system/etc/sysctl.conf
$B echo "net.ipv4.tcp_synack_retries=2" >> /system/etc/sysctl.conf
$B echo "net.ipv4.tcp_keepalive_intvl=30" >> /system/etc/sysctl.conf
$B echo "net.ipv4.tcp_keepalive_probes=6" >> /system/etc/sysctl.conf
$B echo "net.ipv4.tcp_fin_timeout=30" >> /system/etc/sysctl.conf
$B echo "net.ipv4.conf.all.rp_filter=2" >> /system/etc/sysctl.conf
$B echo "net.ipv4.conf.default.rp_filter=2" >> /system/etc/sysctl.conf
$B echo "net.ipv4.fwmark_reflect=1" >> /system/etc/sysctl.conf
$B echo "net.ipv4.tcp_tw_reuse=1" >> /system/etc/sysctl.conf
$B echo "net.ipv4.tcp_tw_recycle=1" >> /system/etc/sysctl.conf
$B echo "net.ipv4.tcp_congestion_control=westwood" >> /system/etc/sysctl.conf
$B echo "Executing optimized network parameters via sysctl"
$B sysctl -e -w net.ipv4.tcp_timestamps=0
$B sysctl -e -w net.ipv4.tcp_rfc1337=1
$B sysctl -e -w net.ipv4.tcp_window_scaling=1
$B sysctl -e -w net.ipv4.tcp_sack=1
$B sysctl -e -w net.ipv4.tcp_fack=1
$B sysctl -e -w net.ipv4.ip_no_pmtu_disc=0
$B sysctl -e -w net.ipv4.tcp_moderate_rcvbuf=1
$B sysctl -e -w net.ipv4.tcp_synack_retries=2
$B sysctl -e -w net.ipv4.tcp_keepalive_intvl=30
$B sysctl -e -w net.ipv4.tcp_keepalive_probes=6
$B sysctl -e -w net.ipv4.tcp_fin_timeout=30
$B sysctl -e -w net.ipv4.conf.all.rp_filter=2
$B sysctl -e -w net.ipv4.conf.default.rp_filter=2
$B sysctl -e -w net.ipv4.fwmark_reflect=1
$B sysctl -e -w net.ipv4.tcp_tw_reuse=1
$B sysctl -e -w net.ipv4.tcp_tw_recycle=1
$B sysctl -e -w net.ipv4.tcp_congestion_control=westwood
$B echo "Applying optimized network parameters via sysfs"
$B echo 0 > /proc/sys/net/ipv4/tcp_timestamps
$B echo 1 > /proc/sys/net/ipv4/tcp_rfc1337
$B echo 1 > /proc/sys/net/ipv4/tcp_window_scaling
$B echo 1 > /proc/sys/net/ipv4/tcp_sack
$B echo 1 > /proc/sys/net/ipv4/tcp_fack
$B echo 0 > /proc/sys/net/ipv4/ip_no_pmtu_disc
$B echo 1 > /proc/sys/net/ipv4/tcp_moderate_rcvbuf
$B echo 2 > /proc/sys/net/ipv4/tcp_synack_retries
$B echo 30 > /proc/sys/net/ipv4/tcp_keepalive_intvl
$B echo 6 > /proc/sys/net/ipv4/tcp_keepalive_probes
$B echo 30 > /proc/sys/net/ipv4/tcp_fin_timeout
$B echo 2 > /proc/sys/net/ipv4/conf/all/rp_filter
$B echo 2 > /proc/sys/net/ipv4/conf/default/rp_filter
$B echo 1 > /proc/sys/net/ipv4/fwmark_reflect
$B echo 1 > /proc/sys/net/ipv4/tcp_tw_reuse
$B echo 1 > /proc/sys/net/ipv4/tcp_tw_recycle
$B mount -o remount,rw /system
$B echo "Tuning DNS.."
$B echo "nameserver 8.8.8.8" > /system/etc/resolv.conf
$B echo "nameserver 8.8.4.4" >> /system/etc/resolv.conf
$B echo "" >> /system/etc/resolv.conf
if [ -e /system/engine/prop/firstboot ]; then
 $B rm /system/etc/ppp/options
 $B cp /system/engine/assets/options /system/etc/ppp/options
 $B chmod 555 /system/etc/ppp/options
 $B echo "Data compression enabled."
fi;
if [ "$SDK" -le "14" ]; then
 if [ -e /system/xbin/sqlite3 ]; then
  $B echo "Tuning WiFi channels.."
  /system/xbin/sqlite3 /data/data/com.android.providers.settings/databases/settings.db "INSERT INTO secure (name, value) VALUES ('wifi_country_code', 'JP');"
 fi;
fi;
if [ -e /system/xbin/sqlite3 ]; then
 $B echo "Tuning WiFi scan.."
 /system/xbin/sqlite3 /data/data/com.android.providers.settings/databases/settings.db "update global set value = 0 where name = 'wifi_scan_always_enabled'"
fi;
if [ -e /system/xbin/sqlite3 ]; then
 $B echo "Tuning WiFi idle.."
 ID=$(/system/xbin/sqlite3 /data/data/com.android.providers.settings/databases/settings.db "select value from secure where name='wifi_idle_ms'")
 if [ "$ID" -eq "" ]; then
  /system/xbin/sqlite3 /data/data/com.android.providers.settings/databases/settings.db "insert into secure (name, value) values ('wifi_idle_ms', 15000 )"
 else
  /system/xbin/sqlite3 /data/data/com.android.providers.settings/databases/settings.db "update secure set value=15000 where name='wifi_idle_ms'"
 fi;
fi;
$B echo "Tuning Android networking settings.."
setprop wifi.supplicant_scan_interval 15000
setprop ro.telephony.call_ring.delay 0
setprop ring.delay 0
setprop ro.ril.enable.3g.prefix 1
setprop ro.ril.enable.sdr 1
setprop ro.ril.enable.gea3 1
setprop ro.ril.enable.a52 0
setprop ro.ril.enable.a53 1
setprop ro.ril.hep 1
setprop net.dns1 8.8.8.8
setprop net.dns2 8.8.4.4
setprop ro.ril.enable.amr.wideband 1
setprop persist.cust.tel.eons 1
setprop persist.eons.enabled true
setprop persist.wpa_supplicant.debug false
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] ***Network gear*** - OK"
sync;
