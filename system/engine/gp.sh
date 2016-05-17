#!/system/bin/sh
### FeraDroid Engine v0.21 | By FeraVolt. 2016 ###
pm enable com.google.android.gms/.checkin.CheckinService
pm enable com.google.android.gms/.checkin.EventLogService
pm enable com.google.android.gms/.update.SystemUpdateService
pm enable com.google.android.gms/.update.SystemUpdateService$ActiveReceiver
pm enable com.google.android.gms/.update.SystemUpdateService$Receiver
pm enable com.google.android.gms/.update.SystemUpdateService$SecretCodeReceiver
pm enable com.google.android.gsf/.update.SystemUpdateActivity
pm enable com.google.android.gsf/.update.SystemUpdatePanoActivity
pm enable com.google.android.gsf/.update.SystemUpdateService
pm enable com.google.android.gsf/.update.SystemUpdateService$Receiver
pm enable com.google.android.gsf/.update.SystemUpdateService$SecretCodeReceiver
pm disable com.google.android.gms/.common.stats.GmsCoreStatsService
pm disable com.google.android.gms/.ads.settings.AdsSettingsActivity
pm disable com.google.android.gms/com.google.android.gms.ads.config.GServicesChangedReceiver
pm disable com.google.android.gms/.ads.jams.SystemEventReceiver
pm disable com.google.android.gms/.ads.config.FlagsReceiver
pm disable com.google.android.gms/.ads.social.DoritosReceiver
pm disable com.google.android.gms/.ads.adinfo.AdvertisingInfoContentProvider
pm disable com.google.android.gms/.ads.GservicesValueBrokerService
pm disable com.google.android.gms/.ads.identifier.service.AdvertisingIdNotificationService
pm disable com.google.android.gms/.ads.jams.NegotiationService
pm disable com.google.android.gms/.ads.pan.PanService
pm disable com.google.android.gms/.ads.social.GcmSchedulerWakeupService
pm disable com.google.android.gms/.ads.AdRequestBrokerService
pm disable com.google.android.gms/.ads.identifier.service.AdvertisingIdService
pm disable com.google.android.gms/.ads.measurement.GmpConversionTrackingBrokerService
pm disable com.google.android.gms/.measurement.service.MeasurementBrokerService
pm disable com.google.android.gms/.perfprofile.uploader.PerfProfileCollectorService
pm disable com.google.android.gms/.perfprofile.uploader.RequestPerfProfileCollectionService
pm disable com.google.android.gms/.usagereporting.settings.UsageReportingActivity
pm disable com.google.android.gms/com.google.android.contextmanager.systemstate.SystemStateReceiver
pm disable com.google.android.gms/.analytics.AnalyticsReceiver
pm disable com.google.android.gms/.analytics.internal.GServicesChangedReceiver
pm disable com.google.android.gms/.common.analytics.CoreAnalyticsReceiver
pm disable com.google.android.gms/com.google.android.libraries.social.mediamonitor.MediaMonitor
pm disable com.google.android.gms/com.google.android.contextmanager.service.ContextManagerService
pm disable com.google.android.gms/.analytics.AnalyticsService
pm disable com.google.android.gms/.analytics.internal.PlayLogReportingService
pm disable com.google.android.gms/.analytics.service.AnalyticsService
pm disable com.google.android.gms/.analytics.service.PlayLogMonitorIntervalService
pm disable com.google.android.gms/.analytics.service.RefreshEnabledStateService
pm disable com.google.android.gms/.auth.be.proximity.authorization.userpresence.UserPresenceService
pm disable com.google.android.gms/.common.analytics.CoreAnalyticsIntentService
pm disable com.google.android.gms/.backup.stats.BackupStatsService
pm disable com.google.android.gms/.deviceconnection.service.DeviceConnectionAsyncService
pm disable com.google.android.gms/.deviceconnection.service.DeviceConnectionServiceBroker
pm disable com.google.android.gms/.wallet.service.analytics.AnalyticsIntentService
pm disable com.google.android.gms/com.google.android.libraries.social.mediamonitor.MediaMonitorIntentService
pm disable com.google.android.gms/.auth.trustagent.trustlet.GeofenceLogsService
pm disable com.google.android.gms/.clearcut.service.ClearcutLoggerIntentService
if [ -e /system/xbin/sqlite3 ]; then
 /system/xbin/sqlite3 /data/data/com.google.android.gsf/databases/gservices.db "update main set value = 'false' where name = 'perform_market_checkin' and value = 'true'"
 /system/xbin/sqlite3 /data/data/com.google.android.gsf/databases/gservices.db "update main set value = 0 where name = 'market_force_checkin' and value = -1"
 /system/xbin/sqlite3 /data/data/com.google.android.gsf/databases/gservices.db "update main set value = 0 where name = 'checkin_interval'"
 /system/xbin/sqlite3 /data/data/com.google.android.gsf/databases/gservices.db "update main set value = 'false' where name = 'checkin_dropbox_upload' and value = 'true'"
 /system/xbin/sqlite3 /data/data/com.google.android.gsf/databases/gservices.db "update main set value = 'false' where name = 'checkin_dropbox_upload:snet' and value = 'true'"
 /system/xbin/sqlite3 /data/data/com.google.android.gsf/databases/gservices.db "update main set value = 'false' where name = 'checkin_dropbox_upload:snet_gcore' and value = 'true'"
 /system/xbin/sqlite3 /data/data/com.google.android.gsf/databases/gservices.db "update main set value = 'false' where name = 'checkin_dropbox_upload:snet_idle' and value = 'true'"
 /system/xbin/sqlite3 /data/data/com.google.android.gsf/databases/gservices.db "update main set value = 'false' where name = 'checkin_dropbox_upload:snet_launch_service' and value = 'true'"
 /system/xbin/sqlite3 /data/data/com.google.android.gsf/databases/gservices.db "update main set value = 'false' where name = 'checkin_dropbox_upload:SYSTEM_RECOVERY_KMSG' and value = 'true'"
 /system/xbin/sqlite3 /data/data/com.google.android.gsf/databases/gservices.db "update main set value = 'false' where name = 'checkin_dropbox_upload:event_log' and value = 'true'"
 /system/xbin/sqlite3 /data/data/com.google.android.gsf/databases/gservices.db "update main set value = 'false' where name = 'checkin_dropbox_upload:SYSTEM_RECOVERY_LOG' and value = 'true'"
 /system/xbin/sqlite3 /data/data/com.google.android.gsf/databases/gservices.db "update main set value = 'false' where name = 'ads:jams:is_enabled' and value = 'true'"
 /system/xbin/sqlite3 /data/data/com.google.android.gsf/databases/gservices.db "update main set value = 'false' where name = 'analytics.service_enabled' and value = 'true'"
 /system/xbin/sqlite3 /data/data/com.google.android.gsf/databases/gservices.db "update main set value = '127.0.0.1' where name = 'url:feedback_url'"
 /system/xbin/sqlite3 /data/data/com.google.android.gsf/databases/gservices.db "update main set value = 0 where name = 'market_force_checkin' and value = 1"
 /system/xbin/sqlite3 /data/data/com.google.android.gsf/databases/gservices.db "update main set value = 0 where name = 'secure:bandwidth_checkin_stat_interval'"
 /system/xbin/sqlite3 /data/data/com.google.android.gsf/databases/gservices.db "update main set value = 0 where name = 'secure:send_action_app_error'"
 /system/xbin/sqlite3 /data/data/com.google.android.gsf/databases/gservices.db "update main set value = 0 where name = 'send_action_app_error'"
 /system/xbin/sqlite3 /data/data/com.google.android.gsf/databases/gservices.db "update saved_secure set value = '0' where name = 'send_action_app_error'"
 /system/xbin/sqlite3 /data/data/com.google.android.gsf/databases/gservices.db "update saved_global set value = '0' where name = 'send_action_app_error'"
fi;
