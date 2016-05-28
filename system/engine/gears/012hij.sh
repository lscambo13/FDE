#!/system/bin/sh
### FeraDroid Engine v0.21 | By FeraVolt. 2016 ###
B=/system/engine/bin/busybox
LOG=/sdcard/Android/FDE.txt
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] 012 - ***Thread gear***"
sync;
H=$($B pgrep -l '' | $B grep -E "launcher" | $B awk '{print $1}')
S=$($B pgrep -l '' | $B grep -E "systemui" | $B awk '{print $1}')
U=$($B pgrep -l '' | $B grep -E "surfaceflinger" | $B awk '{print $1}')
L=$($B pgrep -l '' | $B grep -E "home" | $B awk '{print $1}')
$B echo "Change priority for $H, $S, $U, $L"
renice -18 "$H"
renice -18 "$S"
renice -18 "$U"
renice -18 "$L"
$B echo "[$TIME] 012 - ***Thread gear*** - OK"
sync;
