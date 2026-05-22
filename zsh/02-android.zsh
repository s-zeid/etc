unset IS_ANDROID ANDROID_UID ANDROID_AID

if [ -e /system/build.prop ] && [ -e /system/framework/framework.jar ]; then
  IS_ANDROID=1
  export DEVICE_NAME; DEVICE_NAME="$(settings get global device_name 2>/dev/null)"
  export PRODUCT_NAME; PRODUCT_NAME="$(getprop ro.product.product.name 2>/dev/null)"
  export MACHINE_NAME="${MACHINE_NAME:-${DEVICE_NAME:-${PRODUCT_NAME}}}"
  if printf '%s\n' "$LOGNAME" | grep -q '^u[0-9]\+_[ai][0-9]\+$'; then
    ANDROID_UID=${LOGNAME#u}; ANDROID_UID=${ANDROID_UID%%_*}
    ANDROID_AID=${LOGNAME##*_}; ANDROID_AID=${ANDROID_AID#a}
    if [ -n "$ANDROID_UID" ]; then
      PS1_USER="u$ANDROID_UID"
    fi
  fi
fi
