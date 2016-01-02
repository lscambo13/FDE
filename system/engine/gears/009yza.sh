#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2016 ###

B=/system/engine/bin/busybox
LOG=/sdcard/Android/FDE.txt
TIME=$($B date | $B awk '{ print $4 }')

$B echo "[$TIME] 009 - ***VM gear***" >> $LOG
$B echo "" >> $LOG
$B echo "Tuning LMK.." >> $LOG
if [ -e /sys/module/lowmemorykiller/parameters/cost ]; then
 $B chmod 644 /sys/module/lowmemorykiller/parameters/cost
 $B echo "16" > /sys/module/lowmemorykiller/parameters/cost
 $B echo "LMK cost fine-tuning.." >> $LOG
fi;
if [ -e /sys/module/lowmemorykiller/parameters/fudgeswap ]; then
 $B chmod 644 /sys/module/lowmemorykiller/parameters/fudgeswap
 $B echo "1024" > /sys/module/lowmemorykiller/parameters/fudgeswap
 $B echo "FudgeSwap supported. Tuning.." >> $LOG
fi;
if [ -e /sys/module/lowmemorykiller/parameters/debug_level ]; then
 $B echo "0" > /sys/module/lowmemorykiller/parameters/debug_level
 $B echo "LMK debugging disabled" >> $LOG
fi;

$B echo "Tuning Android proc.." >> $LOG
setprop MAX_SERVICE_INACTIVITY false
setprop MIN_HIDDEN_APPS false
setprop CONTENT_APP_IDLE_OFFSET false
setprop EMPTY_APP_IDLE_OFFSET false
setprop ACTIVITY_INACTIVE_RESET_TIME false
setprop MIN_RECENT_TASKS false
setprop APP_SWITCH_DELAY_TIME false
setprop PROC_START_TIMEOUT false
setprop CPU_MIN_CHECK_DURATION false
setprop GC_TIMEOUT false
setprop SERVICE_TIMEOUT false
setprop MIN_CRASH_INTERVAL false

$B echo "Optimizing GP services.." >> $LOG
$B killall -9 com.google.android.gms
$B killall -9 com.google.android.gms.persistent
$B killall -9 com.google.process.gapps
$B killall -9 com.google.android.gsf
$B killall -9 com.google.android.gsf.persistent
pm disable com.google.android.gms/.ads.settings.AdsSettingsActivity
pm disable com.google.android.gms/com.google.android.location.places.ui.aliaseditor.AliasEditorActivity
pm disable com.google.android.gms/com.google.android.location.places.ui.aliaseditor.AliasEditorMapActivity
pm disable com.google.android.gms/com.google.android.location.settings.ActivityRecognitionPermissionActivity
pm disable com.google.android.gms/com.google.android.location.settings.GoogleLocationSettingsActivity
pm disable com.google.android.gms/com.google.android.location.settings.LocationHistorySettingsActivity
pm disable com.google.android.gms/com.google.android.location.settings.LocationSettingsCheckerActivity
pm disable com.google.android.gms/.usagereporting.settings.UsageReportingActivity
pm disable com.google.android.gms/.ads.adinfo.AdvertisingInfoContentProvider
pm disable com.google.android.gms/com.google.android.location.reporting.service.ReportingContentProvider
pm disable com.google.android.gms/com.google.android.location.internal.LocationContentProvider
pm enable com.google.android.gms/.common.stats.net.contentprovider.NetworkUsageContentProvider
pm disable com.google.android.gms/com.google.android.gms.ads.config.GServicesChangedReceiver
pm disable com.google.android.gms/com.google.android.contextmanager.systemstate.SystemStateReceiver
pm disable com.google.android.gms/.ads.jams.SystemEventReceiver
pm disable com.google.android.gms/.ads.config.FlagsReceiver
pm disable com.google.android.gms/.ads.social.DoritosReceiver
pm disable com.google.android.gms/.analytics.AnalyticsReceiver
pm disable com.google.android.gms/.analytics.internal.GServicesChangedReceiver
pm disable com.google.android.gms/.common.analytics.CoreAnalyticsReceiver
pm enable com.google.android.gms/.common.stats.GmsCoreStatsServiceLauncher
pm disable com.google.android.gms/com.google.android.location.internal.AnalyticsSamplerReceiver
pm disable com.google.android.gms/.checkin.CheckinService\$ActiveReceiver
pm disable com.google.android.gms/.checkin.CheckinService\$ClockworkFallbackReceiver
pm disable com.google.android.gms/.checkin.CheckinService\$ImposeReceiver
pm disable com.google.android.gms/.checkin.CheckinService\$SecretCodeReceiver
pm disable com.google.android.gms/.checkin.CheckinService\$TriggerReceiver
pm disable com.google.android.gms/.checkin.EventLogService\$Receiver
pm disable com.google.android.gms/com.google.android.location.reporting.service.ExternalChangeReceiver
pm disable com.google.android.gms/com.google.android.location.reporting.service.GcmRegistrationReceiver
pm disable com.google.android.gms/com.google.android.location.copresence.GcmRegistrationReceiver
pm disable com.google.android.gms/com.google.android.location.copresence.GservicesBroadcastReceiver
pm disable com.google.android.gms/com.google.android.location.internal.LocationProviderEnabler
pm disable com.google.android.gms/com.google.android.location.internal.NlpNetworkProviderSettingsUpdateReceiver
pm disable com.google.android.gms/com.google.android.location.network.ConfirmAlertActivity\$LocationModeChangingReceiver
pm disable com.google.android.gms/com.google.android.location.places.ImplicitSignalsReceiver
pm disable com.google.android.gms/com.google.android.libraries.social.mediamonitor.MediaMonitor
pm disable com.google.android.gms/.location.copresence.GcmBroadcastReceiver
pm disable com.google.android.gms/.location.reporting.service.GcmBroadcastReceiver
pm disable com.google.android.gms/.social.location.GservicesBroadcastReceiver
pm disable com.google.android.gms/.update.SystemUpdateService\$Receiver
pm disable com.google.android.gms/.update.SystemUpdateService\$OtaPolicyReceiver
pm disable com.google.android.gms/.update.SystemUpdateService\$SecretCodeReceiver
pm disable com.google.android.gms/.update.SystemUpdateService\$ActiveReceiver
pm disable com.google.android.gms/com.google.android.contextmanager.service.ContextManagerService
pm enable com.google.android.gms/.ads.AdRequestBrokerService
pm disable com.google.android.gms/.ads.GservicesValueBrokerService
pm disable com.google.android.gms/.ads.identifier.service.AdvertisingIdNotificationService
pm enable com.google.android.gms/.ads.identifier.service.AdvertisingIdService
pm disable com.google.android.gms/.ads.jams.NegotiationService
pm disable com.google.android.gms/.ads.pan.PanService
pm disable com.google.android.gms/.ads.social.GcmSchedulerWakeupService
pm disable com.google.android.gms/.analytics.AnalyticsService
pm disable com.google.android.gms/.analytics.internal.PlayLogReportingService
pm disable com.google.android.gms/.analytics.service.AnalyticsService
pm disable com.google.android.gms/.analytics.service.PlayLogMonitorIntervalService
pm disable com.google.android.gms/.analytics.service.RefreshEnabledStateService
pm disable com.google.android.gms/.auth.be.proximity.authorization.userpresence.UserPresenceService
pm disable com.google.android.gms/.common.analytics.CoreAnalyticsIntentService
pm enable com.google.android.gms/.common.stats.GmsCoreStatsService
pm disable com.google.android.gms/.backup.BackupStatsService
pm disable com.google.android.gms/.deviceconnection.service.DeviceConnectionAsyncService
pm disable com.google.android.gms/.deviceconnection.service.DeviceConnectionServiceBroker
pm disable com.google.android.gms/.wallet.service.analytics.AnalyticsIntentService
pm enable com.google.android.gms/.checkin.CheckinService
pm enable com.google.android.gms/.checkin.EventLogService
pm disable com.google.android.gms/com.google.android.location.internal.AnalyticsUploadIntentService
pm disable com.google.android.gms/com.google.android.location.reporting.service.DeleteHistoryService
pm disable com.google.android.gms/com.google.android.location.reporting.service.DispatchingService
pm disable com.google.android.gms/com.google.android.location.reporting.service.InternalPreferenceServiceDoNotUse
pm disable com.google.android.gms/com.google.android.location.reporting.service.LocationHistoryInjectorService
pm disable com.google.android.gms/com.google.android.location.reporting.service.ReportingAndroidService
pm disable com.google.android.gms/com.google.android.location.reporting.service.ReportingSyncService
pm disable com.google.android.gms/com.google.android.location.activity.HardwareArProviderService
pm disable com.google.android.gms/com.google.android.location.fused.FusedLocationService
pm disable com.google.android.gms/com.google.android.location.fused.service.FusedProviderService
pm disable com.google.android.gms/com.google.android.location.geocode.GeocodeService
pm disable com.google.android.gms/com.google.android.location.geofencer.service.GeofenceProviderService
pm enable com.google.android.gms/com.google.android.location.internal.GoogleLocationManagerService
pm disable com.google.android.gms/com.google.android.location.places.PlaylogService
pm enable com.google.android.gms/com.google.android.location.places.service.GeoDataService
pm enable com.google.android.gms/com.google.android.location.places.service.PlaceDetectionService
pm disable com.google.android.gms/com.google.android.libraries.social.mediamonitor.MediaMonitorIntentService
pm disable com.google.android.gms/.config.ConfigService
pm enable com.google.android.gms/.stats.PlatformStatsCollectorService
pm enable com.google.android.gms/.usagereporting.service.UsageReportingService
pm enable com.google.android.gms/.update.SystemUpdateService
pm enable com.google.android.gms/com.google.android.location.network.ConfirmAlertActivity
pm enable com.google.android.gms/com.google.android.location.network.LocationProviderChangeReceiver
pm enable com.google.android.gms/com.google.android.location.internal.server.GoogleLocationService
pm enable com.google.android.gms/com.google.android.location.internal.PendingIntentCallbackService
pm enable com.google.android.gms/com.google.android.location.network.NetworkLocationService
pm enable com.google.android.gms/com.google.android.location.util.PreferenceService
pm disable com.google.android.gsf/.update.SystemUpdateActivity
pm disable com.google.android.gsf/.update.SystemUpdatePanoActivity
pm disable com.google.android.gsf/com.google.android.gsf.checkin.CheckinService\$Receiver
pm disable com.google.android.gsf/com.google.android.gsf.checkin.CheckinService\$SecretCodeReceiver
pm disable com.google.android.gsf/com.google.android.gsf.checkin.CheckinService\$TriggerReceiver
pm disable com.google.android.gsf/.checkin.EventLogService\$Receiver
pm disable com.google.android.gsf/.update.SystemUpdateService\$Receiver
pm disable com.google.android.gsf/.update.SystemUpdateService\$SecretCodeReceiver
pm disable com.google.android.gsf/.checkin.CheckinService
pm disable com.google.android.gsf/.checkin.EventLogService
pm disable com.google.android.gsf/.update.SystemUpdateService

if [ -e /system/xbin/sqlite3 ]; then
$B echo "Optimizing DataBases.." >> $LOG
for i in \
$($B find /data -iname "*.db") 
do \
 /system/xbin/sqlite3 "$i" 'VACUUM;'
 /system/xbin/sqlite3 "$i" 'REINDEX;'
done;
for i in \
$($B find /sdcard -iname "*.db")
do \
 /system/xbin/sqlite3 "$i" 'VACUUM;'
 /system/xbin/sqlite3 "$i" 'REINDEX;'
done;
fi;

$B echo "" >> $LOG
$B echo "[$TIME] 009 - ***VM gear*** - OK" >> $LOG
sync;

