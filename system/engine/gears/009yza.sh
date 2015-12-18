#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2015 ###

B=/system/engine/bin/busybox

$B echo "***Network gear***"
$B echo " "
$B echo " "

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

$B echo " "
$B echo " "
$B echo "***Check***"
sync;

