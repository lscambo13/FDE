#!/system/bin/sh
### FeraDroid Engine v1.1 | By FeraVolt. 2017 ###
B=/system/engine/bin/busybox;
RAM=$($B free -m | $B awk '{ print $2 }' | $B sed -n 2p);
CORES=$($B grep -c 'processor' /proc/cpuinfo);
FSCORE=/system/engine/prop/fscore;
BG=$((RAM/100));
HZ=$((RAM/4));
HGL=$((RAM/16));
if [ "$HZ" -lt "92" ]; then
 HZ=92;
fi;
if [ "$HGL" = "48" ]; then
 HGL=48;
fi;
mount -o remount,rw /data;
mount -o remount,rw /system;
$B echo "Cleaning trash...";
$B chmod -R 777 /data/tombstones;
$B rm -f /data/tombstones/*;
$B chmod -R 000 /data/tombstones;
$B echo "1" > $FSCORE;
$B echo "Re-calibrating battery...";
dumpsys batteryinfo --reset;
dumpsys batterystats --reset;
$B rm - f /data/system/batterystats.bin;
$B rm - f /data/system/batterystats-checkin.bin;
$B echo "1" > $FSCORE;
if [ -e /sys/devices/platform/i2c-gpio.9/i2c-9/9-0036/power_supply/fuelgauge/fg_reset_soc ]; then
 $B echo "Fuelgauge report reset.";
 $B echo "1" > /sys/devices/platform/i2c-gpio.9/i2c-9/9-0036/power_supply/fuelgauge/fg_reset_soc;
 $B echo "1" >> $FSCORE;
fi;
$B echo "Changing to OpenDNS..";
$B rm -f /system/etc/resolv.conf;
$B touch /system/etc/resolv.conf;
$B chmod 666 /system/etc/resolv.conf
$B echo "nameserver 208.67.222.222" > /system/etc/resolv.conf;
$B echo "nameserver 208.67.220.220" >> /system/etc/resolv.conf;
$B echo "  " >> /system/etc/resolv.conf;
$B rm -f /system/etc/ppp/options;
$B touch /system/etc/ppp/options;
$B chmod 666 /system/etc/ppp/options;
$B echo "bsdcomp" > /system/etc/ppp/options;
$B echo "deflate" >> /system/etc/ppp/options;
$B echo "  " >> /system/etc/ppp/options;
$B echo "2" >> $FSCORE;
$B echo "Data compression enabled.";
if [ -e /system/vendor/etc/msm_irqbalance_little_big.conf ]; then
 $B echo "Tuning MSM IRQ balance..";
 $B rm -f /system/vendor/etc/msm_irqbalance_little_big.conf
 $B cp /system/engine/raw/msm.conf /system/vendor/etc/msm_irqbalance_little_big.conf;
 $B chmod 644 /system/vendor/etc/msm_irqbalance_little_big.conf
 $B echo "1" >> $FSCORE;
fi;
if [ -e /data/misc/mtkgps.dat ]; then
 $B rm -f /data/misc/mtkgps.dat;
 $B echo "MTK GPS data cleared.";
 $B echo "1" >> $FSCORE;
fi;
if [ -e /data/misc/epo.dat ]; then
 $B rm -f /data/misc/epo.dat;
 $B echo "EPO data cleared.";
 $B echo "1" >> $FSCORE;
fi;
if [ ! -e /system/etc/gps_fde_bak ]; then
 if [ -e /system/etc/gps.conf ]; then
  $B cp /system/etc/gps.conf /system/etc/gps_fde_bak
 else
  $B touch /system/etc/gps.conf;
 fi;
 $B chmod 777 /system/etc/gps.conf;
 $B echo "Patching GPS config...";
 $B sed -e "s=DEBUG_LEVEL=#=" -i /system/etc/gps.conf;
 $B sed -e "s=ERR_ESTIMATE=#=" -i /system/etc/gps.conf;
 $B sed -e "s=NTP_SERVER=#=" -i /system/etc/gps.conf;
 $B sed -e "s=XTRA_=#=" -i /system/etc/gps.conf;
 $B sed -e "s=DEFAULT=#=" -i /system/etc/gps.conf;
 $B sed -e "s=INTERMEDIATE=#=" -i /system/etc/gps.conf;
 $B sed -e "s=ACCURACY=#=" -i /system/etc/gps.conf;
 $B sed -e "s=SUPL_HOST=#=" -i /system/etc/gps.conf;
 $B sed -e "s=SUPL_PORT=#=" -i /system/etc/gps.conf;
 $B sed -e "s=NMEA=#=" -i /system/etc/gps.conf;
 $B sed -e "s=CAPABILITIES=#=" -i /system/etc/gps.conf;
 $B sed -e "s=SUPL_ES=#=" -i /system/etc/gps.conf;
 $B sed -e "s=USE_EMERGENCY=#=" -i /system/etc/gps.conf;
 $B sed -e "s=SUPL_MODE=#=" -i /system/etc/gps.conf;
 $B sed -e "s=SUPL_VER=#=" -i /system/etc/gps.conf;
 $B sed -e "s=REPORT=#=" -i /system/etc/gps.conf;
 {
  $B echo "   "
  $B echo "   "
  $B echo "### FeraDroid Engine v1.1 | By FeraVolt. 2017 ###"
  $B echo "DEBUG_LEVEL=0"
  $B echo "ERR_ESTIMATE=0"
  $B echo "NTP_SERVER=time.izatcloud.net"
  $B echo "CAPABILITIES=0x37"
  $B echo "DEFAULT_AGPS_ENABLE=TRUE"
  $B echo "DEFAULT_USER_PLANE=TRUE"
  $B echo "INTERMEDIATE_POS=0"
  $B echo "NMEA_PROVIDER=0"
  $B echo "REPORT_POSITION_USE_SUPL_REFLOC=1"
  $B echo "XTRA_SERVER_1=http://xtrapath1.izatcloud.net/xtra2.bin"
  $B echo "XTRA_SERVER_2=http://xtrapath2.izatcloud.net/xtra2.bin"
  $B echo "XTRA_SERVER_3=http://xtrapath3.izatcloud.net/xtra2.bin"
  $B echo "XTRA_VERSION_CHECK=0"
  $B echo "SUPL_ES=0"
  $B echo "USE_EMERGENCY_PDN_FOR_EMERGENCY_SUPL=1"
  $B echo "SUPL_MODE=1"
  $B echo "SUPL_HOST=supl.qxwz.com"
  $B echo "SUPL_PORT=7275"
  $B echo "SUPL_VER=0x20000"
  $B echo "   "
 } >> /system/etc/gps.conf;
 $B chmod 644 /system/etc/gps.conf;
else
 $B echo "GPS config is already patched.";
 $B echo "1" >> $FSCORE;
fi; 
if [ ! -e /system/build.prop_bak ]; then
 $B cp /system/build.prop /system/engine/raw/build.prop;
 $B cp /system/build.prop /system/build.prop_bak;
 $B chmod 777 /system/engine/raw/build.prop;
 $B echo "Patching build.prop...";
 $B sed -e "s=power.saving.mode=#power.saving.mode=" -i /system/engine/raw/build.prop;
 $B sed -e "s=persist.radio.ramdump=#persist.radio.ramdump=" -i /system/engine/raw/build.prop;
 $B sed -e "s=pm.sleep_mode=#pm.sleep_mode=" -i /system/engine/raw/build.prop;
 $B sed -e "s=ro.ril.disable.power.collapse=#ro.ril.disable.power.collapse=" -i /system/engine/raw/build.prop;
 $B sed -e "s=ro.ril.fast.dormancy=#ro.ril.fast.dormancy=" -i /system/engine/raw/build.prop;
 $B sed -e "s=ro.ril.fast.dormancy.rule=#ro.ril.fast.dormancy.rule=" -i /system/engine/raw/build.prop;
 $B sed -e "s=ro.config.hw_power_saving=#ro.config.hw_power_saving=" -i /system/engine/raw/build.prop;
 $B sed -e "s=dev.pm.dyn_samplingrate=#dev.pm.dyn_samplingrate=" -i /system/engine/raw/build.prop;
 $B sed -e "s=persist.radio.add_power_save=#persist.radio.add_power_save=" -i /system/engine/raw/build.prop;
 $B sed -e "s=ro.com.google.networklocation=#ro.com.google.networklocation=" -i /system/engine/raw/build.prop;
 $B sed -e "s=ro.ril.def.agps.feature=#ro.ril.def.agps.feature=" -i /system/engine/raw/build.prop;
 $B sed -e "s=ro.ril.def.agps.mode=#ro.ril.def.agps.mode=" -i /system/engine/raw/build.prop;
 $B sed -e "s=ro.gps.agps_provider=#ro.gps.agps_provider=" -i /system/engine/raw/build.prop;
 $B sed -e "s=persist.added_boot_bgservices=#persist.added_boot_bgservices=" -i /system/engine/raw/build.prop;
 $B sed -e "s=ro.config.max_starting_bg=#ro.config.max_starting_bg=" -i /system/engine/raw/build.prop;
 $B sed -e "s=ro.sys.fw.bg_apps_limit=#ro.sys.fw.bg_apps_limit=" -i /system/engine/raw/build.prop;
 $B sed -e "s=net.dns1=#net.dns1=" -i /system/engine/raw/build.prop;
 $B sed -e "s=net.dns2=#net.dns2=" -i /system/engine/raw/build.prop;
 $B sed -e "s=wifi.supplicant_scan_interval=#wifi.supplicant_scan_interval=" -i /system/engine/raw/build.prop;
 $B sed -e "s=ro.telephony.call_ring.delay=#ro.telephony.call_ring.delay=" -i /system/engine/raw/build.prop;
 $B sed -e "s=ring.delay=#ring.delay=" -i /system/engine/raw/build.prop;
 $B sed -e "s=ro.ril.enable.3g.prefix=#ro.ril.enable.3g.prefix=" -i /system/engine/raw/build.prop;
 $B sed -e "s=ro.ril.enable.sdr=#ro.ril.enable.sdr=" -i /system/engine/raw/build.prop;
 $B sed -e "s=ro.ril.enable.gea3=#ro.ril.enable.gea3=" -i /system/engine/raw/build.prop;
 $B sed -e "s=ro.ril.enable.a52=#ro.ril.enable.a52=" -i /system/engine/raw/build.prop;
 $B sed -e "s=ro.ril.enable.a53=#ro.ril.enable.a53=" -i /system/engine/raw/build.prop;
 $B sed -e "s=ro.ril.hep=#ro.ril.hep=" -i /system/engine/raw/build.prop;
 $B sed -e "s=ro.ril.enable.amr.wideband=#ro.ril.enable.amr.wideband=" -i /system/engine/raw/build.prop;
 $B sed -e "s=persist.cust.tel.eons=#persist.cust.tel.eons=" -i /system/engine/raw/build.prop;
 $B sed -e "s=persist.eons.enabled=#persist.eons.enabled=" -i /system/engine/raw/build.prop;
 $B sed -e "s=persist.wpa_supplicant.debug=#persist.wpa_supplicant.debug=" -i /system/engine/raw/build.prop;
 $B sed -e "s=net.tethering.noprovisioning=#net.tethering.noprovisioning=" -i /system/engine/raw/build.prop;
 $B sed -e "s=tether_dun_required=#tether_dun_required=" -i /system/engine/raw/build.prop;
 $B sed -e "s=ro.audio.flinger_standbytime_ms=#ro.audio.flinger_standbytime_ms=" -i /system/engine/raw/build.prop;
 $B sed -e "s=ro.HOME_APP_ADJ=#ro.HOME_APP_ADJ=" -i /system/engine/raw/build.prop;
 $B sed -e "s=ro.HOME_APP_MEM=#ro.HOME_APP_MEM=" -i /system/engine/raw/build.prop;
 $B sed -e "s=MIN_HIDDEN_APPS=#MIN_HIDDEN_APPS=" -i /system/engine/raw/build.prop;
 $B sed -e "s=MIN_RECENT_TASKS=#MIN_RECENT_TASKS=" -i /system/engine/raw/build.prop;
 $B sed -e "s=APP_SWITCH_DELAY_TIME=#APP_SWITCH_DELAY_TIME=" -i /system/engine/raw/build.prop;
 $B sed -e "s=MIN_CRASH_INTERVAL=#MIN_CRASH_INTERVAL=" -i /system/engine/raw/build.prop;
 $B sed -e "s=ACTIVITY_INACTIVE_RESET_TIME=#ACTIVITY_INACTIVE_RESET_TIME=" -i /system/engine/raw/build.prop;
 $B sed -e "s=CPU_MIN_CHECK_DURATION=#CPU_MIN_CHECK_DURATION=" -i /system/engine/raw/build.prop;
 $B sed -e "s=GC_TIMEOUT=#GC_TIMEOUT=" -i /system/engine/raw/build.prop;
 $B sed -e "s=PROC_START_TIMEOUT=#PROC_START_TIMEOUT=" -i /system/engine/raw/build.prop;
 $B sed -e "s=SERVICE_TIMEOUT=#SERVICE_TIMEOUT=" -i /system/engine/raw/build.prop;
 $B sed -e "s=dalvik.vm.checkjni=#dalvik.vm.checkjni=" -i /system/engine/raw/build.prop;
 $B sed -e "s=dalvik.vm.check-dex-sum=#dalvik.vm.check-dex-sum=" -i /system/engine/raw/build.prop;
 $B sed -e "s=dalvik.vm.debug.alloc=#dalvik.vm.debug.alloc=" -i /system/engine/raw/build.prop;
 $B sed -e "s=dalvik.vm.deadlock-predict=#dalvik.vm.deadlock-predict=" -i /system/engine/raw/build.prop;
 $B sed -e "s=dalvik.vm.heapsize=#dalvik.vm.heapsize=" -i /system/engine/raw/build.prop;
 $B sed -e "s=dalvik.vm.heapgrowthlimit=#dalvik.vm.heapgrowthlimit=" -i /system/engine/raw/build.prop;
 $B sed -e "s=ro.sys.fw.dex2oat_thread_count=#ro.sys.fw.dex2oat_thread_count=" -i /system/engine/raw/build.prop;
 $B sed -e "s=libc.debug.malloc=#libc.debug.malloc=" -i /system/engine/raw/build.prop;
 $B sed -e "s=persist.sys.purgeable_assets=#persist.sys.purgeable_assets=" -i /system/engine/raw/build.prop;
 $B sed -e "s=debug.atrace.tags.enableflags=#debug.atrace.tags.enableflags=" -i /system/engine/raw/build.prop;
 if [ "$RAM" -le "1024" ]; then
  $B sed -e "s=net.tcp.buffersize.default=#net.tcp.buffersize.default=" -i /system/engine/raw/build.prop;
  $B sed -e "s=net.tcp.buffersize.wifi=#net.tcp.buffersize.wifi=" -i /system/engine/raw/build.prop;
  $B sed -e "s=net.tcp.buffersize.umts=#net.tcp.buffersize.umts=" -i /system/engine/raw/build.prop;
  $B sed -e "s=net.tcp.buffersize.hsdpa=#net.tcp.buffersize.hsdpa=" -i /system/engine/raw/build.prop;
  $B sed -e "s=net.tcp.buffersize.hspa=#net.tcp.buffersize.hspa=" -i /system/engine/raw/build.prop;
  $B sed -e "s=net.tcp.buffersize.hsupa=#net.tcp.buffersize.hsupa=" -i /system/engine/raw/build.prop;
  $B sed -e "s=net.tcp.buffersize.edge=#net.tcp.buffersize.edge=" -i /system/engine/raw/build.prop;
  $B sed -e "s=net.tcp.buffersize.gprs=#net.tcp.buffersize.gprs=" -i /system/engine/raw/build.prop;
  $B sed -e "s=dalvik.vm.heaptargetutilization=#dalvik.vm.heaptargetutilization=" -i /system/engine/raw/build.prop;
 fi;
 {
  $B echo "   "
  $B echo "   "
  $B echo "### FeraDroid Engine v1.1 | By FeraVolt. 2017 ###"
  $B echo "bp_patch=v1.1"
  $B echo "ro.feralab.engine=1.1"
  $B echo "power.saving.mode=1"
  $B echo "persist.radio.ramdump=0"
  $B echo "pm.sleep_mode=1"
  $B echo "ro.ril.disable.power.collapse=0"
  $B echo "ro.semc.enable.fast_dormancy=false"
  $B echo "ro.ril.fast.dormancy=0"
  $B echo "ro.ril.fast.dormancy.rule=0"
  $B echo "ro.config.hw_power_saving=1"
  $B echo "dev.pm.dyn_samplingrate=1"
  $B echo "persist.radio.add_power_save=1"
  $B echo "ro.com.google.networklocation=0"
  $B echo "ro.ril.def.agps.feature=1"
  $B echo "ro.ril.def.agps.mode=1"
  $B echo "ro.gps.agps_provider=1"
  $B echo "persist.added_boot_bgservices=$CORES"
  $B echo "ro.config.max_starting_bg=$((CORES+1))"
  $B echo "ro.sys.fw.bg_apps_limit=$BG"
  $B echo "net.dns1=208.67.222.222"
  $B echo "net.dns2=208.67.220.220"
  $B echo "wifi.supplicant_scan_interval=300000"
  $B echo "ro.telephony.call_ring.delay=0"
  $B echo "ring.delay=0"
  $B echo "ro.ril.enable.3g.prefix=1"
  $B echo "ro.ril.enable.sdr=1"
  $B echo "ro.ril.enable.gea3=1"
  $B echo "ro.ril.enable.a52=0"
  $B echo "ro.ril.enable.a53=1"
  $B echo "ro.ril.hep=1"
  $B echo "ro.ril.enable.amr.wideband=1"
  $B echo "persist.cust.tel.eons=1"
  $B echo "persist.eons.enabled=true"
  $B echo "persist.wpa_supplicant.debug=false"
  $B echo "net.tethering.noprovisioning=true"
  $B echo "tether_dun_required=0"
  $B echo "ro.audio.flinger_standbytime_ms=300"
  $B echo "ro.HOME_APP_ADJ=0"
  $B echo "ro.HOME_APP_MEM=2439"
  $B echo "MIN_HIDDEN_APPS=false"
  $B echo "MIN_RECENT_TASKS=false"
  $B echo "APP_SWITCH_DELAY_TIME=false"
  $B echo "MIN_CRASH_INTERVAL=false"
  $B echo "ACTIVITY_INACTIVE_RESET_TIME=false"
  $B echo "CPU_MIN_CHECK_DURATION=false"
  $B echo "GC_TIMEOUT=false"
  $B echo "PROC_START_TIMEOUT=false"
  $B echo "SERVICE_TIMEOUT=false"
  $B echo "dalvik.vm.checkjni=false"
  $B echo "dalvik.vm.check-dex-sum=false"
  $B echo "dalvik.vm.debug.alloc=0"
  $B echo "dalvik.vm.deadlock-predict=off"
  $B echo "dalvik.vm.heapsize=$((HZ+9))m"
  $B echo "dalvik.vm.heapgrowthlimit=$((HGL+3))m"
  $B echo "ro.sys.fw.dex2oat_thread_count=$CORES"
  $B echo "libc.debug.malloc=0"
  $B echo "persist.sys.purgeable_assets=1"
  $B echo "debug.atrace.tags.enableflags=0"
 } >> /system/engine/raw/build.prop;
 if [ "$RAM" -le "1024" ]; then
  {
   $B echo "net.tcp.buffersize.default=4096,87380,110208,4096,16384,110208"
   $B echo "net.tcp.buffersize.wifi=4095,87380,110208,4096,16384,110208"
   $B echo "net.tcp.buffersize.umts=4095,87380,110208,4096,16384,110208"
   $B echo "net.tcp.buffersize.hsdpa=4096,32768,65536,4096,32768,65536"
   $B echo "net.tcp.buffersize.hspa=4096,32768,65536,4096,32768,65536"
   $B echo "net.tcp.buffersize.hsupa=4096,32768,65536,4096,32768,65536"
   $B echo "net.tcp.buffersize.edge=4093,26280,35040,4096,16384,35040"
   $B echo "net.tcp.buffersize.gprs=4092,8760,11680,4096,8760,11680"
   $B echo "dalvik.vm.heaptargetutilization=0.9"
  } >> /system/engine/raw/build.prop;
 fi;
 if [ "$RAM" -le "512" ]; then
  {
   $B echo "ro.config.low_ram=true"
   $B echo "config.disable_atlas=true"
  } >> /system/engine/raw/build.prop;
 fi;
 $B cp -f /system/engine/raw/build.prop /system/build.prop;
 $B chmod 644 /system/build.prop;
else
 $B echo "Build.prop is already patched by FDE to $(getprop bp_patch)";
fi;
$B echo "62" >> $FSCORE;

