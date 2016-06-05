#!/system/bin/sh
### FeraDroid Engine v0.21 | By FeraVolt. 2016 ###
B=/system/engine/bin/busybox
LOG=/sdcard/Android/FDE_log.txt
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] 012 - ***Thread gear***"
sync;
H=$($B pgrep -l '' | $B grep -E "launcher" | $B awk '{print $1}')
S=$($B pgrep -l '' | $B grep -E "systemui" | $B awk '{print $1}')
U=$($B pgrep -l '' | $B grep -E "surfaceflinger" | $B awk '{print $1}')
L=$($B pgrep -l '' | $B grep -E "home" | $B awk '{print $1}')
P=$($B pgrep -l '' | $B grep -E "phone" | $B awk '{print $1}')
D=$($B pgrep -l '' | $B grep -E "dialer" | $B awk '{print $1}')
S=$($B pgrep -l '' | $B grep -E "swap" | $B awk '{print $1}')
E=$($B pgrep -l '' | $B grep -E "server" | $B awk '{print $1}')
T=$($B pgrep -l '' | $B grep -E "trebuchet" | $B awk '{print $1}')
$B echo "Change priority for $H $S $U $L $P"
renice -10 "$H"
renice -9 "$S"
renice -8 "$U"
renice -10 "$L"
renice -10 "$P"
renice -1 "$S"
renice -1 "$E"
renice -10 "$T"
renice -10 "$D"
$B echo "[$TIME] 012 - ***Thread gear*** - OK"
sync;
