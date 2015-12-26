#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2016 ###

mount -o remount,rw /system
chmod 777 /system/engine/bin/*

if [ -e /system/etc/init.qcom.post_boot.sh ] ; then
 echo "" >> /system/etc/init.qcom.post_boot.sh
 echo "/system/engine/bin/sh /system/engine/feradroid.sh" >> /system/etc/init.qcom.post_boot.sh
 echo "" >> /system/etc/init.qcom.post_boot.sh
elif [ -e /system/xbin/zram.sh ]; then
 rm -f /system/xbin/zram.sh
 touch /system/xbin/zram.sh
 chmod 777 /system/xbin/zram.sh
 echo "#!/system/bin/sh" > /system/xbin/zram.sh
 echo "### FeraDroid Engine v0.19 | By FeraVolt. 2016 ###" >> /system/xbin/zram.sh
 echo "" >> /system/xbin/zram.sh
 echo "/system/engine/bin/sh /system/engine/feradroid.sh" >> /system/xbin/zram.sh
 echo "" >> /system/xbin/zram.sh
elif [ -e /system/etc/install-recovery.sh ]; then
 touch /system/etc/install-recovery-2.sh
 chmod 777 /system/etc/install-recovery.sh
 chmod 777 /system/etc/install-recovery-2.sh
 echo "" >> /system/etc/install-recovery.sh
 echo "/system/engine/bin/sh /system/etc/install-recovery-2.sh" >> /system/etc/install-recovery.sh
 echo "#!/system/bin/sh" > /system/etc/install-recovery-2.sh
 echo "### FeraDroid Engine v0.19 | By FeraVolt. 2016 ###" >> /system/etc/install-recovery-2.sh
 echo "" >> /system/etc/install-recovery-2.sh
 echo "/system/engine/bin/sh /system/engine/feradroid.sh" >> /system/etc/install-recovery-2.sh
 echo "" >> /system/etc/install-recovery-2.sh
fi;

