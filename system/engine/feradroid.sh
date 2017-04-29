#!/system/bin/sh
### FeraDroid Engine v1.1 | By FeraVolt. 2017 ###

ARCH=$(grep -Eo "ro.product.cpu.abi(2)?=.+" /system/build.prop 2>/dev/null | grep -Eo "[^=]*$" | head -n1);
if [ -e /system/engine/prop/firstboot ]; then

