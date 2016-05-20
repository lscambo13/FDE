#!/system/bin/sh
### FeraDroid Engine v0.21 | By FeraVolt. 2016 ###
B=/system/engine/bin/busybox
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] Sleeper daemon"
U=$($B top -n1)
while true; do
 if [[ "$(cat /sys/power/wait_for_fb_sleep)" = "sleeping" ]]; then
  sync;
  $B sleep 1
  $B echo 3 > /proc/sys/vm/drop_caches
  $B sleep 1
  sync;
  for i in $($B pgrep -l '' | $B grep '\<org\.\|\<app\.\|\<com\.\|\<android\.' | grep -v -i -e 'android\|launcher\|systemui\|phone\|push'  | $B awk '{print $1}'); do
   a=$($B echo $U | $B grep $i | $B awk '{print $25}' | $B cut -d',' -f1)
   if [ "$a" -gt "0" ]; then
    kill -9 "$i"
   fi;
  done;
  until [[ "$(cat /sys/power/wait_for_fb_wake)" = "awake" ]]; do
   $B sleep 9
  done;
 fi;
done;
