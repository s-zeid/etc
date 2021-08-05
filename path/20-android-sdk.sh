if [ -d "$HOME/opt/android-sdk" ]; then
 export ANDROID_SDK="$HOME/opt/android-sdk"
 export ANDROID_HOME="$ANDROID_SDK"
fi

if [ -d "$HOME/opt/android-sdk/cmdline-tools" ]; then
 cmdline_tools_version=$(
  ls "$HOME/opt/android-sdk/cmdline-tools" | sort -V | tail -n 1 2>/dev/null
 )
 if [ -n "$cmdline_tools_version" ]; then
  PATH="$PATH":$HOME/opt/android-sdk/cmdline-tools/"$cmdline_tools_version"
 fi
 unset cmdline_tools_version
else
 if [ -d "$HOME/opt/android-sdk/tools" ]; then
  PATH="$PATH:$HOME/opt/android-sdk/tools"
 fi
 
 if [ -d "$HOME/opt/android-sdk/tools/bin" ]; then
  PATH="$PATH:$HOME/opt/android-sdk/tools/bin"
 fi
fi

if [ -d "$HOME/opt/android-sdk/build-tools" ]; then
 build_tools_version=$(
  ls "$HOME/opt/android-sdk/build-tools" | sort -V | tail -n 1 2>/dev/null
 )
 if [ -n "$build_tools_version" ]; then
  PATH="$PATH":$HOME/opt/android-sdk/build-tools/"$build_tools_version"
 fi
 unset build_tools_version
fi

if [ -d "$HOME/opt/android-ndk" ]; then
 export ANDROID_NDK="$HOME/opt/android-ndk"
 PATH="$PATH:$HOME/opt/android-ndk"
fi
