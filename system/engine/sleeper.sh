#!/system/bin/sh
### FeraDroid Engine v0.20 | By FeraVolt. 2016 ###
B=/system/engine/bin/busybox
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] Sleeper daemon"
if [ ! "$target_usage" ]; then
 target_usage=0
fi
while true; do
 usage=$($B top -n1)
 for i in $($B pgrep -l '' | $B grep '\<org\.\|\<app\.\|\<com\.\|\<android\.' | $B awk '{print $1}'); do
  if [ "$(IFS=''; $B echo "$usage" | $B grep "$i" | $B awk '{print $(NF-2)}' | $B cut -d'.' -f1)" -gt "$target_usage" ]; then
   kill -9 "$i"
  fi
 done
 $B sleep 60
 until [ "$(cat /sys/power/wait_for_fb_sleep)" = "sleeping" ]; do
  $B sleep 12
 done
done
