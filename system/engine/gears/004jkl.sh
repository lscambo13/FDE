#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2015 ###

B=/system/engine/bin/busybox
SQ=/system/engine/bin/sqlite3

for i in \
`$B find /data -iname "*.db"`; 
do \
	$SQ $i 'VACUUM;'; 
done;

for i in \
`$B find /data -iname "*.db"`; 
do \
	$SQ $i 'REINDEX;'; 
done;
sync;

