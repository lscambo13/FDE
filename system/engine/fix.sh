#!/system/bin/sh
### FeraDroid Engine v20 | By FeraVolt. 2016 ###
B=/system/engine/bin/busybox
zipalign="yes"
clear
sleep 1
id=`id`; id=`echo ${id#*=}`; id=`echo ${id%%\(*}`; id=`echo ${id%%gid*}`
if [ "$id" != "0" ] && [ "$id" != "root" ]; then
	sleep 1
	echo "You are NOT running this script as root"
	exit 69
elif [ ! "`which zipalign`" ]; then
	zipalign=
	sleep 1
	echo "Zipalign binary was NOT found."
	echo ""
fi 2>/dev/null
$B mount -o remount,rw /data 2>/dev/null
$B mount -o remount,rw /system 2>/dev/null
$B mount -o remount,rw `$B mount | grep system | awk '{print $1,$3}' | sed -n 1p` 2>/dev/null
rm /data/fixaligntemp 2>/dev/null
START=`$B date +%s`
BEGAN=`date`
TOTAL=`cat /d*/system/packages.xml | grep -E "^<package.*serId" | wc -l`
INCREMENT=3
PROGRESS=0
PROGRESS_BAR=""
sync
cat /d*/system/packages.xml | grep -E "^<package.*serId" | while read pkgline; do
	if [ ! -f "/data/fixaligntemp" ]; then ALIGNED=0; FAILED=0; ALREADY=0; SKIPPED=0; fi
	PKGNAME=`echo $pkgline | sed 's%.* name="\(.*\)".*%\1%' | cut -d '"' -f1`
	CODEPATH=`echo $pkgline | sed 's%.* codePath="\(.*\)".*%\1%' |  cut -d '"' -f1`
	DATAPATH=/d*/d*/$PKGNAME
	PKGUID=`echo $pkgline | sed 's%.*serId="\(.*\)".*%\1%' | cut -d '"' -f1`
	PROGRESS=$(($PROGRESS+1))
	PERCENT=$(( $PROGRESS * 100 / $TOTAL ))
	if [ "$PERCENT" -eq "$INCREMENT" ]; then
		INCREMENT=$(( $INCREMENT + 3 ))
		PROGRESS_BAR="$PROGRESS_BAR="
	fi
	clear
	echo ""
	echo -n "                                        >"
	echo -e "\r       $PROGRESS_BAR>"
	echo "       \"Fix Alignment\"                    "
	echo -n "                                        >"
	echo -e "\r       $PROGRESS_BAR>"
	echo ""
	echo "       Processing Apps - $PERCENT% ($PROGRESS of $TOTAL)"
	echo " Fix Aligning $PKGNAME"
	echo ""
	if [ -e "$CODEPATH" ]; then
		if [ "$zipalign" ]; then
			if [ "$($B basename $CODEPATH )" = "framework-res.apk" ] || [ "$($B basename $CODEPATH )" = "com.htc.resources.apk" ]; then
				echo " NOT ZipAligning (Problematic) $CODEPATH"
				SKIPPED=$(($SKIPPED+1))
			else
				zipalign -c 4 $CODEPATH
				ZIPCHECK=$?
				if [ "$ZIPCHECK" -eq 1 ]; then
					echo " ZipAligning $CODEPATH"
					zipalign -f 4 $CODEPATH /cache/$($B basename $CODEPATH )
					rc="$?"
					if [ "$rc" -eq 0 ]; then
						if [ -e "/cache/$($B basename $CODEPATH )" ]; then
							$B cp -f -p /cache/$($B basename $CODEPATH ) $CODEPATH
							ALIGNED=$(($ALIGNED+1))
						else
							echo " ZipAligning $CODEPATH Failed (No Output File!)"
							FAILED=$(($FAILED+1))
						fi
					else echo "ZipAligning $CODEPATH Failed (rc: $rc!)"
						FAILED=$(($FAILED+1))
					fi
					if [ -e "/cache/$($B basename $CODEPATH )" ]; then $B rm /cache/$($B basename $CODEPATH ); fi
				else
					echo " ZipAlign already completed on $CODEPATH "
					ALREADY=$(($ALREADY+1))
				fi
				echo "$ALIGNED $FAILED $ALREADY $SKIPPED" > /data/fixaligntemp
			fi
		fi
		APPDIR=`$B dirname $CODEPATH`
		if [ "$APPDIR" = "/system/app" ] || [ "$APPDIR" = "/vendor/app" ] || [ "$APPDIR" = "/system/framework" ]; then
			$B chown 0 $CODEPATH
			$B chown :0 $CODEPATH
			$B chmod 644 $CODEPATH
		elif [ "$APPDIR" = "/data/app" ]; then
			$B chown 1000 $CODEPATH
			$B chown :1000 $CODEPATH
			$B chmod 644 $CODEPATH
		elif [ "$APPDIR" = "/data/app-private" ]; then
			$B chown 1000 $CODEPATH
			$B chown :$PKGUID $CODEPATH
			$B chmod 640 $CODEPATH
		fi
		if [ -d "$DATAPATH" ]; then
			$B chmod 755 $DATAPATH
			$B chown $PKGUID $DATAPATH
			$B chown :$PKGUID $DATAPATH
			DIRS=`$B find $DATAPATH -mindepth 1 -type d`
			for file in $DIRS; do
				PERM=755
				NEWUID=$PKGUID
				NEWGID=$PKGUID
				FNAME=`$B basename $file`
				case $FNAME in
							lib)$B chmod 755 $file
								NEWUID=1000
								NEWGID=1000
								PERM=755;;
				   shared_prefs)$B chmod 771 $file
								PERM=660;;
					  databases)$B chmod 771 $file
								PERM=660;;
						  cache)$B chmod 771 $file
								PERM=600;;
						  files)$B chmod 771 $file
								PERM=775;;
							  *)$B chmod 771 $file
								PERM=771;;
				esac
				$B chown $NEWUID $file
				$B chown :$NEWGID $file
				$B find $file -type f -maxdepth 2 ! -perm $PERM -exec $B chmod $PERM {} ';'
				$B find $file -type f -maxdepth 1 ! -user $NEWUID -exec $B chown $NEWUID {} ';'
				$B find $file -type f -maxdepth 1 ! -group $NEWGID -exec $B chown :$NEWGID {} ';'
			done
		fi
		echo " Fixed Permissions"
	fi 2>/dev/null
done
sync
echo $line
STOP=`$B date +%s`
ENDED=`date`
RUNTIME=`$B expr $STOP - $START`
HOURS=`$B expr $RUNTIME / 3600`
REMAINDER=`$B expr $RUNTIME % 3600`
MINS=`$B expr $REMAINDER / 60`
SECS=`$B expr $REMAINDER % 60`
RUNTIME=`$B printf "%02d:%02d:%02d\n" "$HOURS" "$MINS" "$SECS"`
if [ "$zipalign" ]; then
	ALIGNED=`awk '{print $1}' /data/fixaligntemp`
	FAILED=`awk '{print $2}' /data/fixaligntemp`
	ALREADY=`awk '{print $3}' /data/fixaligntemp`
	SKIPPED=`awk '{print $4}' /data/fixaligntemp`
	sleep 1
	rm /data/fixaligntemp
	echo " Done ZipAligning all data and system apps.."
	echo ""
	sleep 1
 	echo " $TOTAL Apps were processed"
 	echo ""
 	echo " $ALIGNED Apps were zipaligned"
	echo " $FAILED Apps were NOT zipaligned due to error"
	echo " $SKIPPED Apps were skipped"
	echo " $ALREADY Apps were already zipaligned"
 	sleep 1
	echo ""
	echo $line
fi
sleep 1
echo " Fixed Permissions For ALL $TOTAL Apps"
echo ""
