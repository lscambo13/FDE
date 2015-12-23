#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2016 ###

chmod 777 /system/engine/bin/*

if [ -e /system/etc/init.qcom.post_boot.sh ] ; then
 echo "" >> /system/etc/init.qcom.post_boot.sh
 echo "/system/engine/bin/sh /system/engine/feradroid.sh" >> /system/etc/init.qcom.post_boot.sh
 echo "" >> /system/etc/init.qcom.post_boot.sh
elif [ -e /system/etc/install-recovery.sh ]; then
 touch /system/etc/install-recovery-2.sh
 echo "" >> /system/etc/install-recovery.sh
 echo "/system/engine/bin/sh /system/etc/install-recovery-2.sh" >> /system/etc/install-recovery.sh
 echo "#!/system/bin/sh" >> /system/etc/install-recovery-2.sh
 echo "### FeraDroid Engine v0.19 | By FeraVolt. 2015 ###" >> /system/etc/install-recovery-2.sh
 echo "" >> /system/etc/install-recovery-2.sh
 echo "/system/engine/bin/sh /system/engine/feradroid.sh" >> /system/etc/install-recovery-2.sh
 echo "" >> /system/etc/install-recovery-2.sh
fi;

