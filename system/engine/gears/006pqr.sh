#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2015 ###

B=/system/engine/bin/busybox

$B echo "***GPU gear***"
$B echo " "
$B echo " "
$B mount -o remount,rw /system
if [ -e /system/lib/egl/libGLESv2_adreno200.so ]; then
 AV=$(du -k "/system/lib/egl/libGLESv2_adreno200.so" | cut -f1)
 $B sleep 1
 $B echo "You have Adreno GPU onboard"
 if [ ! -h /data/local/tmp/adreno_config.txt ]; then
 $B chmod 777 /system/engine/assets/adreno_config.txt
 $B ln -s /system/engine/assets/adreno_config.txt /data/local/tmp/adreno_config.txt
 fi;
 if [ "$AV" -ne "1712" ]; then
 $B rm /system/lib/egl/libGLES_android.so
 $B sed -i '/0 0 android/d' /system/lib/egl/egl.cfg
 else
 $B echo "You have legacy adreno libs. No HWA for you."
 fi;
 $B mount -t debugfs debugfs /sys/kernel/debug
 $B chmod 666 /dev/kgsl-3d0
 $B chmod 666 /dev/msm_aac_in
 $B chmod 666 /dev/msm_amr_in
 $B chmod 666 /dev/genlock
 $B chmod 777 /dev/graphics/fb0
 $B echo 0 > /sys/kernel/debug/msm_fb/0/vsync_enable
 $B echo "VSYNC off.."
 setprop com.qc.hardware=true
 setprop com.qc.hdmi_out=false
 setprop debug.qc.hardware=true
 setprop debug.qctwa.statusbar 1
 setprop debug.qctwa.perservebuf 1
fi;

$B echo "Tuning system environment.."
setprop debug.sf.hw=1
setprop debug.egl.hw=1
setprop debug.egl.profiler=1
setprop debug.egl.swapinterval=1 
setprop debug.gr.numframebuffers=3
setprop debug.gr.swapinterval=1
setprop debug.mdpcomp.logs=0
setprop debug.mdpcomp.maxlayer=3
setprop debug.mdpcomp.idletime=-1
setprop debug.performance.tuning=1
setprop debug.enabletr true
setprop dev.pm.dyn_samplingrate=1
setprop ro.floatingtouch.available=1
setprop ro.min.fling_velocity=7000
setprop ro.max.fling_velocity 12000
setprop persist.sys.ui.hw=1
setprop video.accelerate.hw=1
setprop windowsmgr.max_events_per_sec=72
setprop windowsmgr.support_rotation_270=true
setprop hwui.render_dirty_regions false
$B echo " "
$B echo " "
$B echo "***Check***"
sync;

