#!/system/bin/sh
### FeraDroid Engine v20 | By FeraVolt. 2016 ###
B=/system/engine/bin/$B
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] Fix.."
ZIPALIGNDB=/data/zipalign.db
if [ ! -f $ZIPALIGNDB ]; then
	touch $ZIPALIGNDB;
fi;
for DIR in /system/app /data/app; do
	cd $DIR
	for APK in *.apk; do
		if [ $APK -ot $ZIPALIGNDB ] && [ $(grep "$DIR/$APK" $ZIPALIGNDB|wc -l) -gt 0 ]; then
			echo "Already checked: $DIR/$APK"
		else
			ZIPCHECK=`/system/xbin/zipalign -c -v 4 $APK | grep FAILED | wc -l`
			if [ $ZIPCHECK == "1" ]; then
				echo "Now aligning: $DIR/$APK"
				/system/engine/bin/zipalign -v -f 4 $APK /sdcard/download/$APK;
				$B mount -o rw,remount /system
				cp -f -p /sdcard/download/$APK $APK
				grep "$DIR/$APK" $ZIPALIGNDB > /dev/null || echo $DIR/$APK >> $ZIPALIGNDB
			else
				echo "Already aligned: $DIR/$APK"
				grep "$DIR/$APK" $ZIPALIGNDB > /dev/null || echo $DIR/$APK >> $ZIPALIGNDB
			fi;
		fi;
	done;
done;
touch $ZIPALIGNDB;
$B chmod 644 /system/app/*
