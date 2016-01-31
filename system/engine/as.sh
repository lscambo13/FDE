#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2016 ###

mount -o remount,rw /system
chmod 755 /system/engine/bin/*

if [ -e /system/etc/init.qcom.post_boot.sh ] ; then
 rm -f /system/etc/init.d/999fde
fi;
if [ -e /engine.sh ] ; then
 rm -f /system/etc/init.d/999fde
fi;
if [ -e /system/etc/hw_config.sh ] ; then
 rm -f /system/etc/init.d/999fde
fi;
if [ -e /system/xbin/zram.sh ]; then
 rm -f /system/etc/init.d/999fde
fi;
if [ -e /system/xbin/install-recovery-2.sh ]; then
 rm -f /system/etc/init.d/999fde
fi;
if [ -e /init.gt-s5660.rc ]; then
 rm -f /system/etc/init.d/999fde
fi;

if [ -e /engine.sh ] ; then
 touch /system/engine/prop/ferakernel
 echo "1" > /system/engine/prop/ferakernel
 echo "" >> /system/engine/prop/ferakernel
 touch /system/etc/fde
 chmod 755 /system/etc/fde
 echo "1" > /system/etc/fde
 echo "" >> /system/etc/fde
 exit
fi;

if [ -e /system/etc/fde ] ; then
 exit
elif [ -e /system/etc/init.qcom.post_boot.sh ] ; then
 chmod 755 /system/etc/init.qcom.post_boot.sh
 echo "" >> /system/etc/init.qcom.post_boot.sh
 echo "/system/engine/feradroid.sh" >> /system/etc/init.qcom.post_boot.sh
 echo "" >> /system/etc/init.qcom.post_boot.sh
 touch /system/etc/fde
 chmod 755 /system/etc/fde
 echo "1" > /system/etc/fde
 echo "" >> /system/etc/fde
 exit
elif [ -e /system/etc/hw_config.sh ] ; then
 chmod 755 /system/etc/hw_config.sh
 echo "" >> /system/etc/hw_config.sh
 echo "/system/engine/feradroid.sh" >> /system/etc/hw_config.sh
 echo "" >> /system/etc/hw_config.sh
 touch /system/etc/fde
 chmod 755 /system/etc/fde
 echo "1" > /system/etc/fde
 echo "" >> /system/etc/fde
 exit
elif [ -e /system/xbin/zram.sh ]; then
 rm -f /system/xbin/zram.sh
 touch /system/xbin/zram.sh
 chmod 755 /system/xbin/zram.sh
 echo "#!/system/bin/sh" > /system/xbin/zram.sh
 echo "### FeraDroid Engine v0.19 | By FeraVolt. 2016 ###" >> /system/xbin/zram.sh
 echo "" >> /system/xbin/zram.sh
 echo "/system/engine/feradroid.sh" >> /system/xbin/zram.sh
 echo "" >> /system/xbin/zram.sh
 touch /system/etc/fde
 chmod 755 /system/etc/fde
 echo "1" > /system/etc/fde
 echo "" >> /system/etc/fde
 exit
elif [ -e /system/etc/install-recovery.sh ]; then
 touch /system/etc/install-recovery-2.sh
 chmod 755 /system/etc/install-recovery.sh
 chmod 755 /system/etc/install-recovery-2.sh
 echo "" >> /system/etc/install-recovery.sh
 echo "/system/etc/install-recovery-2.sh" >> /system/etc/install-recovery.sh
 echo "#!/system/bin/sh" > /system/etc/install-recovery-2.sh
 echo "### FeraDroid Engine v0.19 | By FeraVolt. 2016 ###" >> /system/etc/install-recovery-2.sh
 echo "" >> /system/etc/install-recovery-2.sh
 echo "/system/engine/feradroid.sh" >> /system/etc/install-recovery-2.sh
 echo "" >> /system/etc/install-recovery-2.sh
 touch /system/etc/fde
 chmod 755 /system/etc/fde
 echo "1" > /system/etc/fde
 echo "" >> /system/etc/fde
 exit
fi;

