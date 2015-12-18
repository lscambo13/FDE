#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2015 ###

B=/system/engine/bin/busybox

$B echo "***Network gear***"
$B echo " "
$B echo " "

$B sysctl -e -w net.ipv4.tcp_congestion_control = cubic

$B echo " "
$B echo " "
$B echo "***Check***"
sync;

