#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2015 ###

B=/system/engine/bin/busybox

if [ ! -h /data/local/tmp/adreno_config.txt ]; then
 $B chmod 777 /system/engine/assets/adreno_config.txt
 $B ln -s /system/engine/assets/adreno_config.txt /data/local/tmp/adreno_config.txt
fi;
sync;

