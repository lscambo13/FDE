#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2016 ###

mount -o remount,rw /system
chmod 777 /system/engine/bin/*

if [ -e /engine.sh ] ; then
 touch /system/engine/prop/ferakernel
 echo "1" > /system/engine/prop/ferakernel
 echo "" >> /system/engine/prop/ferakernel
 exit
fi;

if [ -e /system/engine/prop/as ] ; then
 exit
elif [ -e /system/etc/init.qcom.post_boot.sh ] ; then
 echo "" >> /system/etc/init.qcom.post_boot.sh
 echo "/system/engine/bin/sh /system/engine/feradroid.sh" >> /system/etc/init.qcom.post_boot.sh
 echo "" >> /system/etc/init.qcom.post_boot.sh
 exit
elif [ -e /system/xbin/zram.sh ]; then
 rm -f /system/xbin/zram.sh
 touch /system/xbin/zram.sh
 chmod 777 /system/xbin/zram.sh
 echo "#!/system/bin/sh" > /system/xbin/zram.sh
 echo "### FeraDroid Engine v0.19 | By FeraVolt. 2016 ###" >> /system/xbin/zram.sh
 echo "" >> /system/xbin/zram.sh
 echo "/system/engine/bin/sh /system/engine/feradroid.sh" >> /system/xbin/zram.sh
 echo "" >> /system/xbin/zram.sh
 exit
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
 exit
else
 touch /system/etc/init.d/fde
 chmod 777 /system/etc/init.d/fde
 echo "#!/system/bin/sh" > /system/etc/init.d/fde
 echo "### FeraDroid Engine v0.19 | By FeraVolt. 2016 ###" >> /system/etc/init.d/fde
 echo "" >> /system/etc/init.d/fde
 echo "/system/engine/bin/sh /system/engine/feradroid.sh" >> /system/etc/init.d/fde
 echo "" >> /system/etc/init.d/fde
 exit
fi;

touch /system/engine/prop/as
echo "1" > /system/engine/prop/as
echo "" >> /system/engine/prop/as

