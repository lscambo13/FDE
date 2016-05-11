#!/system/bin/sh
### FeraDroid Engine v0.20 | By FeraVolt. 2016 ###
B=/system/engine/bin/busybox
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] Sleeper daemon"
U=$($B top -n1)
LOAD=$(($B top -bn1 | $B grep "Cpu(s)" | $B sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | $B awk '{print $1}'))
while true; do
 for i in $($B pgrep -l '' | $B grep '\<org\.\|\<app\.\|\<com\.\|\<android\.' | $B awk '{print $1}'); do
  if [ $LOAD -gt "0" ]; then
   kill -9 "$i"
  fi;
 done;
 $B sleep 45
 until [ "$(cat /sys/power/wait_for_fb_sleep)" = "sleeping" ]; do
  $B sleep 12
 done;
done;
