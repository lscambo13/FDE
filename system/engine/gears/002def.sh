#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2015 ###

B=/system/engine/bin/busybox
A=$(cat /sys/class/power_supply/battery/capacity)

if [ "$A" == "100" ] ; then
$B rm -f /data/system/batterystats.bin
fi;

