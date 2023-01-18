__profile_d_main() {
  if __is_gnome; then
    if which qt5ct >/dev/null 2>&1; then
      export QT_QPA_PLATFORMTHEME=qt5ct
    elif which qt6ct >/dev/null 2>&1; then
      export QT_QPA_PLATFORMTHEME=qt6ct
    else
      local gtk_theme
      gtk_theme=$(dconf read /org/gnome/desktop/interface/gtk-theme 2>/dev/null)
      if printf '%s\n' "$gtk_theme" | grep -q -i -e 'adwaita'; then
        local qt_libs
        for qt_libs in "$(find_qt_libs 5)" "$(find_qt_libs 6)"; do
          if [ x"$qt_libs" != x"" ]; then
            if [ -e "$qt_libs/plugins/styles/adwaita.so" ]; then
              export QT_STYLE_OVERRIDE=Adwaita
              break
            fi
          fi
        done
      fi
    fi
  fi
  
  unset -f __is_gnome
  unset -f __find_qt_libs
}


__is_gnome() {
  local desktop
  for desktop in $(printf '%s\n' "$XDG_CURRENT_DESKTOP" | tr ':' ' ' | tr 'A-Z' 'a-z'); do
    if [ x"$desktop" = x"gnome" ]; then
      return 0
    fi
  done 
  return 1
}


__find_qt_libs() {
  local version; version=$1
  if [ x"$version" = x"" ]; then
    echo "__find_qt_libs(): version argument is required" >&2
    return 2
  fi
  local i
  for i in \
    /usr/lib64/*/"qt$version" \
    /usr/lib64/"qt$version" \
    /usr/lib/*/"qt$version" \
    /usr/lib/"qt$version" \
  ; do
    if [ -d "$i" ]; then
      printf '%s\n' "$i"
      return 0
    fi
  done
  return 1
}


__profile_d_main; unset -f __profile_d_main
