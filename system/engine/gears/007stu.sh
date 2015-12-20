#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2015 ###

B=/system/engine/bin/busybox
A=$(cat /sys/class/power_supply/battery/capacity)

if [ "$A" = "100" ] ; then
$B rm -f /data/system/batterystats.bin
fi;

setprop ro.mot.eri.losalert.delay 1000
setprop power.saving.mode 1
setprop ro.vold.umsdirtyratio 20
setprop persist.sys.purgeable_assets 1
setprop pm.sleep_mode 1
setprop ro.ril.disable.power.collapse 0
sync;

