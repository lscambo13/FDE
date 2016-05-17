#!/system/bin/sh
### FeraDroid Engine v0.21 | By FeraVolt. 2016 ###
B=/system/engine/bin/busybox
SDK=$(getprop ro.build.version.sdk)
TIME=$($B date | $B awk '{ print $4 }')
RAM=$($B free -m | $B awk '{ print $2 }' | $B sed -n 2p)
$B echo "[$TIME] 008 - ***Network gear***"
$B mount -o remount,rw /system
$B echo "Writing optimized network parameters to sysctl"
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
$B echo "net.ipv4.tcp_fin_timeout=36" >> /system/etc/sysctl.conf
$B echo "net.ipv4.conf.all.rp_filter=2" >> /system/etc/sysctl.conf
$B echo "net.ipv4.conf.default.rp_filter=2" >> /system/etc/sysctl.conf
$B echo "net.ipv4.conf.all.accept_redirects=0" >> /system/etc/sysctl.conf
$B echo "Executing optimized network parameters via sysctl"
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
$B sysctl -e -w net.ipv4.tcp_fin_timeout=36
$B sysctl -e -w net.ipv4.conf.all.rp_filter=2
$B sysctl -e -w net.ipv4.conf.default.rp_filter=2
$B sysctl -e -w net.ipv4.conf.all.accept_redirects=0
if [ "$RAM" -le "1024" ]; then
$B echo "Set smaller net-buffer sizes.."
setprop net.tcp.buffersize.gprs 4092,8760,11680,4096,8760,11680
setprop net.tcp.buffersize.edge 4093,26280,35040,4096,16384,35040
setprop net.tcp.buffersize.evdo_b 4096,32768,65536,4096,32768,65536
setprop net.tcp.buffersize.umts 4096,32768,65536,4096,32768,65536
setprop net.tcp.buffersize.hspa 4096,32768,65536,4096,32768,65536
setprop net.tcp.buffersize.hsdpa 4096,32768,65536,4096,32768,65536
setprop net.tcp.buffersize.wifi 4096,32768,110208,4096,32768,110208
setprop net.tcp.buffersize.lte 4096,32768,110208,4096,32768,110208
setprop net.tcp.buffersize.default 4096,32768,110208,4096,32768,110208
else
$B echo "Set larger net-buffer sizes.."
setprop net.tcp.buffersize.gprs 6144,8760,11680,6144,8760,11680
setprop net.tcp.buffersize.edge 6144,26280,35040,6144,16384,35040
setprop net.tcp.buffersize.evdo_b 6144,262144,1048576,6144,262144,1048576
setprop net.tcp.buffersize.umts 6144,87380,110208,6144,16384,110208
setprop net.tcp.buffersize.hspa 6144,87380,262144,6144,16384,262144
setprop net.tcp.buffersize.hsdpa 6144,262144,1048576,6144,262144,1048576
setprop net.tcp.buffersize.wifi 262144,524288,1048576,262144,524288,1048576
setprop net.tcp.buffersize.lte 262144,524288,3145728,262144,524288,3145728
setprop net.tcp.buffersize.default 262144,524288,1048576,262144,524288,1048576
fi;
$B echo "Tuning DNS.."
$B echo "nameserver 8.8.8.8" > /system/etc/resolv.conf
$B echo "nameserver 8.8.4.4" >> /system/etc/resolv.conf
$B echo "" >> /system/etc/resolv.conf
sync;
$B mount -o remount,rw /system
if [ -e /system/engine/prop/firstboot ]; then
 $B rm /system/etc/ppp/options
 $B cp /system/engine/assets/options /system/etc/ppp/options
 $B chmod 555 /system/etc/ppp/options
 $B echo "Data compression enabled."
fi;
if [ "$SDK" -le "14" ]; then
 if [ -e /system/xbin/sqlite3 ]; then
  $B echo "Tuning WiFi.."
  /system/xbin/sqlite3 /data/data/com.android.providers.settings/databases/settings.db "INSERT INTO secure (name, value) VALUES ('wifi_country_code', 'JP');"
 fi;
fi;
if [ -e /system/xbin/sqlite3 ]; then
 $B echo "Tuning WiFi scan.."
 /system/xbin/sqlite3 /data/data/com.android.providers.settings/databases/settings.db "update global set value = 0 where name = 'wifi_scan_always_enabled'"
fi;
$B echo "Tuning Android networking settings.."
setprop wifi.supplicant_scan_interval 360
setprop ro.telephony.call_ring.delay 0
setprop ring.delay 0
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
setprop dhcp.wlan0.dns1 8.8.8.8
setprop dhcp.wlan0.dns2 8.8.4.4
setprop ro.ril.enable.amr.wideband 1
setprop ro.wifi.channels 13
setprop persist.wpa_supplicant.debug false
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] 008 - ***Network gear*** - OK"
sync;
