AUTOMOUNT=true
PROPFILE=false
POSTFSDATA=false
LATESTARTSERVICE=true
REPLACE="
"

set_permissions() {
  set_perm_recursive  $MODPATH  0  0  0755  0644
  set_perm_recursive  $MODPATH/service.sh  0  0  0755  0777
  set_perm_recursive  $MODPATH/system/etc/fde.ai  0  0  0755  0777
}


