#!/system/bin/sh
### FeraDroid Engine v1.1 | By FeraVolt. 2017 ###
B=/system/engine/bin/busybox;
RAM=$($B free -m | $B awk '{ print $2 }' | $B sed -n 2p);
ARCH=$($B grep -Eo "ro.product.cpu.abi(2)?=.+" /system/build.prop 2>/dev/null | $B grep -Eo "[^=]*$" | head -n1);
SDK=$(getprop ro.build.version.sdk);
CORES=$($B grep -c 'processor' /proc/cpuinfo);
FSCORE=/system/engine/prop/fscore;
BG=$((RAM/128));
HZ=$((RAM/4));
HGL=$((RAM/16));
if [ "$CORES" = "0" ]; then
 CORES=1;
fi;
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
if [ "$CORES" -le "4" ]; then
 $B echo "Tuning Android animations..";
 if [ -e /system/xbin/sqlite3 ]; then
  $B echo "REPLACE INTO \"system\" VALUES(26,'window_animation_scale','0.5');REPLACE INTO \"system\" VALUES(27,'transition_animation_scale','0.5');" | sqlite3 /data/data/com.android.providers.settings/databases/settings.db;
 fi;
 content update --uri content://settings/system --bind value:s:0.5 --where 'name="window_animation_scale"';
 content update --uri content://settings/system --bind value:s:0.5 --where 'name="transition_animation_scale"';
 content update --uri content://settings/system --bind value:s:0.75 --where 'name="animator_duration_scale"';
 settings put system window_animation_scale 0.5;
 settings put global window_animation_scale 0.5;
 settings put system transition_animation_scale 0.5;
 settings put global transition_animation_scale 0.5;
 settings put system animator_duration_scale 0.75;
 settings put global animator_duration_scale 0.75;
 $B echo "6" >> $FSCORE;
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
 $B echo "19" >> $FSCORE;
else
 $B echo "GPS config is already patched.";
 $B echo "19" >> $FSCORE;
fi;
if [ -e /system/build.prop_bak ]; then
 $B cp -f /system/build.prop_bak /system/engine/raw/build.prop;
elif [ ! -e /system/build.prop_bak ]; then
 $B cp -f /system/build.prop /system/build.prop_bak;
 $B cp -f /system/build.prop /system/engine/raw/build.prop;
fi;
$B chmod 777 /system/engine/raw/build.prop;
$B echo "Patching build.prop...";
$B sed -e "s=power.saving.mode=#power.saving.mode=" -i /system/engine/raw/build.prop;
$B sed -e "s=persist.radio.ramdump=#persist.radio.ramdump=" -i /system/engine/raw/build.prop;
$B sed -e "s=pm.sleep_mode=#pm.sleep_mode=" -i /system/engine/raw/build.prop;
$B sed -e "s=ro.ril.disable.power.collapse=#ro.ril.disable.power.collapse=" -i /system/engine/raw/build.prop;
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
$B sed -e "s=persist.logd.size=#persist.logd.size=" -i /system/engine/raw/build.prop;
$B sed -e "s=persist.sys.use_dithering=#persist.sys.use_dithering=" -i /system/engine/raw/build.prop;
$B sed -e "s=persist.sys.scrollingcache=#persist.sys.scrollingcache=" -i /system/engine/raw/build.prop;
$B sed -e "s=persist.sys.dun.override=#persist.sys.dun.override=" -i /system/engine/raw/build.prop;
$B sed -e "s=persist.sys.camera-sound=#persist.sys.camera-sound=" -i /system/engine/raw/build.prop;
$B sed -e "s=hwui.render_dirty_regions=#hwui.render_dirty_regions=" -i /system/engine/raw/build.prop;
$B sed -e "s=debug.hwui.render_dirty_regions=#debug.hwui.render_dirty_regions=" -i /system/engine/raw/build.prop;
$B sed -e "s=ro.media.enc.jpeg.quality=#ro.media.enc.jpeg.quality=" -i /system/engine/raw/build.prop;
$B sed -e "s=ro.floatingtouch.available=#ro.floatingtouch.available=" -i /system/engine/raw/build.prop;
$B sed -e "s=ro.fling.distance.coef=#ro.fling.distance.coef=" -i /system/engine/raw/build.prop;
$B sed -e "s=ro.fling.duration.coef=#ro.fling.duration.coef=" -i /system/engine/raw/build.prop;
$B sed -e "s=persist.sys.strictmode.disable=#persist.sys.strictmode.disable=" -i /system/engine/raw/build.prop;
$B sed -e "s=vidc.debug.level=#vidc.debug.level=" -i /system/engine/raw/build.prop;
$B sed -e "s=ro.camera.sound.forced=#ro.camera.sound.forced=" -i /system/engine/raw/build.prop;
$B sed -e "s=mm.enable.smoothstreaming=#mm.enable.smoothstreaming=" -i /system/engine/raw/build.prop;
$B sed -e "s=mmp.enable.3g2=#mmp.enable.3g2=" -i /system/engine/raw/build.prop;
$B sed -e "s=media.aac_51_output_enabled=#media.aac_51_output_enabled=" -i /system/engine/raw/build.prop;
$B sed -e "s=debug.mdpcomp.logs=#debug.mdpcomp.logs=" -i /system/engine/raw/build.prop;
$B sed -e "s=ro.max.fling_velocity=#ro.max.fling_velocity=" -i /system/engine/raw/build.prop;
$B sed -e "s=ro.min.fling_velocity=#ro.min.fling_velocity=" -i /system/engine/raw/build.prop;
$B sed -e "s=ro.kernel.android.checkjni=#ro.kernel.android.checkjni=" -i /system/engine/raw/build.prop;
$B sed -e "s=ro.config.nocheckin=#ro.config.nocheckin=" -i /system/engine/raw/build.prop;
$B sed -e "s=ro.kernel.checkjni=#ro.kernel.checkjni=" -i /system/engine/raw/build.prop;
$B sed -e "s=profiler.launch=#profiler.launch=" -i /system/engine/raw/build.prop;
$B sed -e "s=profiler.force_disable_err_rpt=#profiler.force_disable_err_rpt=" -i /system/engine/raw/build.prop;
$B sed -e "s=profiler.force_disable_ulog=#profiler.force_disable_ulog=" -i /system/engine/raw/build.prop;
$B sed -e "s=profiler.debugmonitor=#profiler.debugmonitor=" -i /system/engine/raw/build.prop;
$B sed -e "s=profiler.hung.dumpdobugreport=#profiler.hung.dumpdobugreport=" -i /system/engine/raw/build.prop;
$B sed -e "s=logcat.live=#logcat.live=" -i /system/engine/raw/build.prop;
$B sed -e "s=debugtool.anrhistory=#debugtool.anrhistory=" -i /system/engine/raw/build.prop;
$B sed -e "s=touch.pressure.scale=#touch.pressure.scale=" -i /system/engine/raw/build.prop;
$B sed -e "s=ro.vold.umsdirtyratio=#ro.vold.umsdirtyratio=" -i /system/engine/raw/build.prop;
$B sed -e "s=debug.kill_allocating_task=#debug.kill_allocating_task=" -i /system/engine/raw/build.prop;
$B sed -e "s=persist.hwc.dynamicfps=#persist.hwc.dynamicfps=" -i /system/engine/raw/build.prop;
$B sed -e "s=windowsmgr.max_events_per_sec=#windowsmgr.max_events_per_sec=" -i /system/engine/raw/build.prop;
$B sed -e "s=persist.sys.NV_FPSLIMIT=#persist.sys.NV_FPSLIMIT=" -i /system/engine/raw/build.prop;
if [ "$RAM" -le "512" ]; then
 $B sed -e "s=ro.config.low_ram=#ro.config.low_ram=" -i /system/engine/raw/build.prop;
 $B sed -e "s=config.disable_atlas=#config.disable_atlas=" -i /system/engine/raw/build.prop;
fi;
if [ -e /dev/kgsl-3d0 ]; then
 $B sed -e "s=com.qc.hardware=#com.qc.hardware=" -i /system/engine/raw/build.prop;
 $B sed -e "s=debug.qc.hardware=#debug.qc.hardware=" -i /system/engine/raw/build.prop;
 $B sed -e "s=debug.qctwa.statusbar=#debug.qctwa.statusbar=" -i /system/engine/raw/build.prop;
 $B sed -e "s=debug.qctwa.preservebuf=#debug.qctwa.preservebuf=" -i /system/engine/raw/build.prop;
 $B sed -e "s=persist.hwc.mdpcomp.enable=#persist.hwc.mdpcomp.enable=" -i /system/engine/raw/build.prop;
fi;
if [ "$SDK" -le "22" ]; then
 $B sed -e "s=debug.sf.hw=#debug.sf.hw=" -i /system/engine/raw/build.prop;
 $B sed -e "s=debug.egl.hw=#debug.egl.hw=" -i /system/engine/raw/build.prop;
 $B sed -e "s=debug.gr.swapinterval=#debug.gr.swapinterval=" -i /system/engine/raw/build.prop;
 $B sed -e "s=debug.gr.numframebuffers=#debug.gr.numframebuffers=" -i /system/engine/raw/build.prop;
 $B sed -e "s=persist.sys.ui.hw=#persist.sys.ui.hw=" -i /system/engine/raw/build.prop;
 $B sed -e "s=video.accelerate.hw=#video.accelerate.hw=" -i /system/engine/raw/build.prop;
 $B sed -e "s=ro.config.disable.hw_accel=#ro.config.disable.hw_accel=" -i /system/engine/raw/build.prop;
 $B sed -e "s=media.stagefright.enable-http=#media.stagefright.enable-http=" -i /system/engine/raw/build.prop;
 $B sed -e "s=media.stagefright.enable-fma2dp=#media.stagefright.enable-fma2dp=" -i /system/engine/raw/build.prop;
 $B sed -e "s=media.stagefright.enable-qcp=#media.stagefright.enable-qcp=" -i /system/engine/raw/build.prop;
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
 $B echo "dalvik.vm.heapsize=$((HZ+12))m"
 $B echo "dalvik.vm.heapgrowthlimit=$((HGL+9))m"
 $B echo "ro.sys.fw.dex2oat_thread_count=$CORES"
 $B echo "libc.debug.malloc=0"
 $B echo "persist.sys.purgeable_assets=1"
 $B echo "debug.atrace.tags.enableflags=0"
 $B echo "persist.logd.size=0"
 $B echo "persist.sys.scrollingcache=3"
 $B echo "persist.sys.dun.override=0"
 $B echo "persist.sys.camera-sound=0"
 $B echo "hwui.render_dirty_regions=false"
 $B echo "debug.hwui.render_dirty_regions=false"
 $B echo "ro.media.enc.jpeg.quality=100"
 $B echo "ro.floatingtouch.available=1"
 $B echo "ro.fling.distance.coef=2.0"
 $B echo "ro.fling.duration.coef=3.0"
 $B echo "persist.sys.strictmode.disable=true"
 $B echo "vidc.debug.level=0"
 $B echo "ro.camera.sound.forced=0"
 $B echo "mm.enable.smoothstreaming=true"
 $B echo "mmp.enable.3g2=true"
 $B echo "media.aac_51_output_enabled=true"
 $B echo "debug.mdpcomp.logs=0"
 $B echo "ro.max.fling_velocity=20000"
 $B echo "ro.min.fling_velocity=12000"
 $B echo "ro.kernel.android.checkjni=0"
 $B echo "touch.pressure.scale=0.001"
 $B echo "ro.config.nocheckin=1"
 $B echo "ro.kernel.checkjni=0"
 $B echo "profiler.launch=false"
 $B echo "profiler.force_disable_err_rpt=1"
 $B echo "profiler.force_disable_ulog=1"
 $B echo "profiler.debugmonitor=false"
 $B echo "profiler.hung.dumpdobugreport=false"
 $B echo "logcat.live=disable"
 $B echo "debugtool.anrhistory=0"
 $B echo "ro.vold.umsdirtyratio=25"
 $B echo "debug.kill_allocating_task=0"
 $B echo "persist.hwc.dynamicfps=60"
 $B echo "windowsmgr.max_events_per_sec=90"
 $B echo "persist.sys.NV_FPSLIMIT=90"
} >> /system/engine/raw/build.prop;
if [ "$RAM" -le "512" ]; then
 {
  $B echo "ro.config.low_ram=true"
  $B echo "config.disable_atlas=true"
 } >> /system/engine/raw/build.prop;
 $B echo "2" >> $FSCORE;
fi;
if [ -e /dev/kgsl-3d0 ]; then
 {
  $B echo "com.qc.hardware=true"
  $B echo "debug.qc.hardware=true"
  $B echo "debug.qctwa.statusbar=1"
  $B echo "debug.qctwa.preservebuf=1"
  $B echo "persist.hwc.mdpcomp.enable=true"
 } >> /system/engine/raw/build.prop;
 $B echo "5" >> $FSCORE;
fi;
if [ "$SDK" -le "22" ]; then
 {
  $B echo "debug.sf.hw=1"
  $B echo "debug.egl.hw=1"
  $B echo "debug.gr.swapinterval=1"
  $B echo "debug.gr.numframebuffers=3"
  $B echo "persist.sys.ui.hw=1"
  $B echo "video.accelerate.hw=1"
  $B echo "ro.config.disable.hw_accel=false"
  $B echo "media.stagefright.enable-http=false"
  $B echo "media.stagefright.enable-qcp=false"
  $B echo "media.stagefright.enable-fma2dp=false"
 } >> /system/engine/raw/build.prop;
 $B echo "11" >> $FSCORE;
fi;
if [ "$CORES" -ge "5" ]; then
 $B echo "persist.sys.use_dithering=1" >> /system/engine/raw/build.prop;
else
 $B echo "persist.sys.use_dithering=0" >> /system/engine/raw/build.prop;
fi;
if [ "$SDK" -le "16" ]; then
 if [ "$SDK" -ge "9" ]; then
  if [ -e /system/lib/egl/libGLES_android.so ]; then
   if [ -e /system/lib/egl/libGLESv2_adreno200.so ]; then
    AV=$($B du -k "/system/lib/egl/libGLESv2_adreno200.so" | $B cut -f1);
   else
    AV=0;
   fi;
   if [ "$AV" -eq "1712" ]; then
    $B echo "You have legacy GPU libs. No HWA for you.";
   else
    $B echo "Enabling Project Butter with forced HWA..";
    $B cp -f /system/lib/egl/egl.cfg /system/lib/egl/egl.cfg_bak;
    $B sed -i '/0 0 android/d' /system/lib/egl/egl.cfg;
    $B mv /system/lib/egl/libGLES_android.so /system/lib/egl/bak.bak_so;
	$B sed -e "s=debug.composition.type=#debug.composition.type=" -i /system/engine/raw/build.prop;
	$B echo "debug.composition.type=gpu" >> /system/engine/raw/build.prop;
	$B echo "9" >> $FSCORE;
   fi;
  fi;
 fi;
fi;
$B cp -f /system/engine/raw/build.prop /system/build.prop;
$B chmod 644 /system/build.prop;
$B chmod 644 /system/build.prop_bak;
$B echo "90" >> $FSCORE;

