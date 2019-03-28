SKIPMOUNT=false
PROPFILE=false
POSTFSDATA=false
LATESTARTSERVICE=true
REPLACE="
"

print_modname() {
 ui_print "*******************************"
 ui_print "         ***FeraLab***"
 ui_print "   FDE.AI by FeraVolt  2019"
 ui_print "*******************************"
}

on_install() {
  ui_print "- Extracting module files"
  unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2
}

set_permissions() {
  set_perm_recursive $MODPATH 0 0 0755 0644
  set_perm_recursive $MODPATH/service.sh 0 0 0755 0777
  set_perm_recursive $MODPATH/system/etc/fde.ai 0 0 0755 0777
}
