#!/system/bin/sh
### FeraDroid Engine v1.1 | By FeraVolt. 2017 ###
B=/system/engine/bin/busybox;
SDK=$(getprop ro.build.version.sdk);
$B echo "Writing optimized network parameters...";
$B echo "Speed & security..";
{
 $B echo "net.ipv4.tcp_timestamps=1"
 $B echo "net.ipv4.tcp_window_scaling=1"
 $B echo "net.ipv4.tcp_sack=1"
 $B echo "net.ipv4.tcp_fack=1"
 $B echo "net.ipv4.tcp_moderate_rcvbuf=1"
 $B echo "net.ipv4.tcp_synack_retries=3"
 $B echo "net.ipv4.tcp_keepalive_intvl=45"
 $B echo "net.ipv4.tcp_keepalive_probes=9"
 $B echo "net.ipv4.tcp_fin_timeout=45"
 $B echo "net.ipv4.tcp_challenge_ack_limit=1000"
 $B echo "net.ipv4.conf.all.rp_filter=2"
 $B echo "net.ipv4.conf.default.rp_filter=2"
 $B echo "net.ipv4.tcp_no_metrics_save=1"
}  >> /system/etc/sysctl.conf;
$B echo "Fixing CVE-2016-5696 vulnerability..";
$B sysctl -e -w net.ipv4.tcp_timestamps=1;
$B sysctl -e -w net.ipv4.tcp_window_scaling=1;
$B sysctl -e -w net.ipv4.tcp_sack=1;
$B sysctl -e -w net.ipv4.tcp_fack=1;
$B sysctl -e -w net.ipv4.tcp_moderate_rcvbuf=1;
$B sysctl -e -w net.ipv4.tcp_synack_retries=3;
$B sysctl -e -w net.ipv4.tcp_keepalive_intvl=45;
$B sysctl -e -w net.ipv4.tcp_keepalive_probes=9;
$B sysctl -e -w net.ipv4.tcp_fin_timeout=45;
$B sysctl -e -w net.ipv4.tcp_challenge_ack_limit=1000;
$B sysctl -e -w net.ipv4.conf.all.rp_filter=2;
$B sysctl -e -w net.ipv4.conf.default.rp_filter=2;
$B sysctl -e -w net.ipv4.tcp_no_metrics_save=1;
$B sysctl -e -w net.ipv4.tcp_congestion_control=htcp;
$B sysctl -e -w net.ipv4.tcp_congestion_control=westwood;
$B echo "1" > /proc/sys/net/ipv4/tcp_timestamps;
$B echo "1" > /proc/sys/net/ipv4/tcp_window_scaling;
$B echo "1" > /proc/sys/net/ipv4/tcp_sack;
$B echo "1" > /proc/sys/net/ipv4/tcp_fack;
$B echo "1" > /proc/sys/net/ipv4/tcp_moderate_rcvbuf;
$B echo "3" > /proc/sys/net/ipv4/tcp_synack_retries;
$B echo "54" > /proc/sys/net/ipv4/tcp_keepalive_intvl;
$B echo "9" > /proc/sys/net/ipv4/tcp_keepalive_probes;
$B echo "45" > /proc/sys/net/ipv4/tcp_fin_timeout;
$B echo "1000" > /proc/sys/net/ipv4/tcp_challenge_ack_limit;
$B echo "2" > /proc/sys/net/ipv4/conf/all/rp_filter;
$B echo "2" > /proc/sys/net/ipv4/conf/default/rp_filter;
$B echo "1" > /proc/sys/net/ipv4/tcp_no_metrics_save;
$B echo "htcp" > /proc/sys/net/ipv4/tcp_congestion_control;
$B echo "westwood" > /proc/sys/net/ipv4/tcp_congestion_control;
$B echo "Optimizing WiFi..";
settings put global wifi_idle_ms 300000;
settings put secure wifi_idle_ms 300000;
settings put secure wifi_watchdog_on 0;
settings put secure wifi_watchdog_poor_network_test_enabled 0;
$B echo "Tethering fix..";
settings put global tether_dun_required 0;
$B echo "Reduce tx queue for all net interfaces.."
for z in /sys/class/net/*; do
  $B echo "100" > "${z}"/tx_queue_len;
done;
sync;
$B sleep 1;

