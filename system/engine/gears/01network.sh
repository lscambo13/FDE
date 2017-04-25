#!/system/bin/sh
### FeraDroid Engine v0.27 | By FeraVolt. 2017 ###
B=/system/engine/bin/busybox;
SDK=$(getprop ro.build.version.sdk);
TIME=$($B date | $B awk '{ print $4 }');
RAM=$($B free -m | $B awk '{ print $2 }' | $B sed -n 2p);
$B echo "[$TIME] ***Network gear***";
$B echo "Writing optimized network parameters to sysctl";
{
 $B echo "net.ipv4.tcp_timestamps=1"
 $B echo "net.ipv4.tcp_rfc1337=1"
 $B echo "net.ipv4.tcp_window_scaling=1"
 $B echo "net.ipv4.tcp_sack=1"
 $B echo "net.ipv4.tcp_fack=1"
 $B echo "net.ipv4.tcp_moderate_rcvbuf=1"
 $B echo "net.ipv4.tcp_synack_retries=3"
 $B echo "net.ipv4.tcp_keepalive_intvl=45"
 $B echo "net.ipv4.tcp_keepalive_probes=9"
 $B echo "net.ipv4.tcp_fin_timeout=45"
 $B echo "net.ipv4.tcp_challenge_ack_limit=9999"
 $B echo "net.ipv4.conf.all.rp_filter=2"
 $B echo "net.ipv4.conf.default.rp_filter=2"
 $B echo "net.ipv4.tcp_tw_reuse=1"
 $B echo "net.ipv4.tcp_no_metrics_save=1"
 $B echo "net.ipv4.tcp_adv_win_scale=2"
 $B echo "net.ipv4.tcp_congestion_control=westwood"
}  >> /system/etc/sysctl.conf;
$B sysctl -e -w net.ipv4.tcp_timestamps=1;
$B sysctl -e -w net.ipv4.tcp_rfc1337=1;
$B sysctl -e -w net.ipv4.tcp_window_scaling=1;
$B sysctl -e -w net.ipv4.tcp_sack=1;
$B sysctl -e -w net.ipv4.tcp_fack=1;
$B sysctl -e -w net.ipv4.tcp_moderate_rcvbuf=1;
$B sysctl -e -w net.ipv4.tcp_synack_retries=3;
$B sysctl -e -w net.ipv4.tcp_keepalive_intvl=45;
$B sysctl -e -w net.ipv4.tcp_keepalive_probes=9;
$B sysctl -e -w net.ipv4.tcp_fin_timeout=45;
$B sysctl -e -w net.ipv4.tcp_challenge_ack_limit=9999;
$B sysctl -e -w net.ipv4.conf.all.rp_filter=2;
$B sysctl -e -w net.ipv4.conf.default.rp_filter=2;
$B sysctl -e -w net.ipv4.tcp_tw_reuse=1;
$B sysctl -e -w net.ipv4.tcp_no_metrics_save=1;
$B sysctl -e -w net.ipv4.tcp_adv_win_scale=2;
$B sysctl -e -w net.ipv4.tcp_congestion_control=westwood;
$B echo "1" > /proc/sys/net/ipv4/tcp_timestamps;
$B echo "1" > /proc/sys/net/ipv4/tcp_rfc1337;
$B echo "1" > /proc/sys/net/ipv4/tcp_window_scaling;
$B echo "1" > /proc/sys/net/ipv4/tcp_sack;
$B echo "1" > /proc/sys/net/ipv4/tcp_fack;
$B echo "1" > /proc/sys/net/ipv4/tcp_moderate_rcvbuf;
$B echo "3" > /proc/sys/net/ipv4/tcp_synack_retries;
$B echo "45" > /proc/sys/net/ipv4/tcp_keepalive_intvl;
$B echo "9" > /proc/sys/net/ipv4/tcp_keepalive_probes;
$B echo "45" > /proc/sys/net/ipv4/tcp_fin_timeout;
$B echo "9999" > /proc/sys/net/ipv4/tcp_challenge_ack_limit;
$B echo "2" > /proc/sys/net/ipv4/conf/all/rp_filter;
$B echo "2" > /proc/sys/net/ipv4/conf/default/rp_filter;
$B echo "1" > /proc/sys/net/ipv4/tcp_tw_reuse;
$B echo "1" > /proc/sys/net/ipv4/tcp_no_metrics_save;
$B echo "2" > /proc/sys/net/ipv4/tcp_adv_win_scale;
$B echo "westwood" > /proc/sys/net/ipv4/tcp_congestion_control;
if [ -e /system/engine/prop/firstboot ]; then
 $B echo "Tuning DNS..";
 $B rm -f /system/etc/resolv.conf;
 $B touch /system/etc/resolv.conf;
 $B chmod 666 /system/etc/resolv.conf
 $B echo "nameserver 208.67.222.222" > /system/etc/resolv.conf;
 $B echo "nameserver 208.67.220.220" >> /system/etc/resolv.conf;
 $B echo "" >> /system/etc/resolv.conf;
 $B rm /system/etc/ppp/options;
 $B cp /system/engine/assets/options/system/etc/ppp/options;
 $B chmod 666 /system/etc/ppp/options;
 $B echo "Data compression enabled.";
fi;
$B echo "Optimizing WiFi..";
settings put secure wifi_idle_ms 300000;
settings put global wifi_idle_ms 300000;
settings put secure wifi_watchdog_on 0;
settings put secure wifi_watchdog_poor_network_test_enabled 0;
if [ "$SDK" -le "21" ]; then
 $B echo "Disable Bandwidth restrictions.";
 setprop persist.bandwidth.enable 0;
 setprop ro.use_data_netmgrd false;
 setprop persist.data.netmgrd.qos.enable false;
 ndc bandwidth disable;
else
 setprop ro.use_data_netmgrd true;
 setprop persist.data.netmgrd.qos.enable true;
 setprop persist.data.mode concurrent;
 setprop persist.data.iwlan.enable true;
fi;
$B echo "Tethering fix..";
settings put global tether_dun_required 0;
$B echo "Tuning Android networking settings..";
setprop net.dns1 208.67.222.222;
setprop net.dns2 208.67.220.220;
setprop wifi.supplicant_scan_interval 300000;
setprop ro.telephony.call_ring.delay 0;
setprop ring.delay 0;
setprop ro.ril.enable.3g.prefix 1;
setprop ro.ril.enable.sdr 1;
setprop ro.ril.enable.gea3 1;
setprop ro.ril.enable.a52 0;
setprop ro.ril.enable.a53 1;
setprop ro.ril.hep 1;
setprop ro.ril.enable.amr.wideband 1;
setprop persist.cust.tel.eons 1;
setprop persist.eons.enabled true;
setprop persist.wpa_supplicant.debug false;
if [ "$RAM" -le "1024" ]; then
 setprop net.tcp.buffersize.default 4096,87380,110208,4096,16384,110208;
 setprop net.tcp.buffersize.wifi 4095,87380,110208,4096,16384,110208;
 setprop net.tcp.buffersize.umts 4095,87380,110208,4096,16384,110208;
 setprop net.tcp.buffersize.hsdpa 4096,32768,65536,4096,32768,65536;
 setprop net.tcp.buffersize.hspa 4096,32768,65536,4096,32768,65536;
 setprop net.tcp.buffersize.hsupa 4096,32768,65536,4096,32768,65536;
 setprop net.tcp.buffersize.edge 4093,26280,35040,4096,16384,35040;
 setprop net.tcp.buffersize.gprs 4092,8760,11680,4096,8760,11680;
fi;
TIME=$($B date | $B awk '{ print $4 }');
$B echo "[$TIME] ***Network gear*** - OK";
sync;
