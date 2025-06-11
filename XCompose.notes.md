Information
-----------

* [Compose(5) man page](https://www.x.org/releases/current/doc/man/man5/Compose.5.xhtml)
* [Default en-US.UTF-8 compose sequences (change `XCOMM` to `#`)](https://github.com/freedesktop/xorg-libX11/blob/master/nls/en_US.UTF-8/Compose.pre)
* [dotXcompose — more sequences](https://github.com/kragen/xcompose)
* [X keysyms (remove `XK_`)](https://gitlab.freedesktop.org/xorg/proto/xorgproto/-/raw/master/include/X11/keysymdef.h)
* [Wikipedia](https://en.wikipedia.org/wiki/Compose_key)


Implementations
---------------

* [ComposeKey extension for Chrome OS](https://chrome.google.com/webstore/detail/composekey/iijdllfdmhbmlmnbcohgbfagfibpbgba/) ([source code](https://github.com/google/extra-keyboards-for-chrome-os/tree/master/composekey)) (supports custom sequences in .XCompose format)
* [WinCompose](https://github.com/SamHocevar/wincompose#readme) ([source code](https://github.com/SamHocevar/wincompose)) (supports custom sequences in .XCompose format)


Notes
-----

* Usually, on Linux, to apply changes to your `.XCompose` file, you must log out
  and back in or reboot.  If your system uses ibus, you may be able to apply
  changes without logging out or rebooting by running `ibus restart`.
  
  To check if your system is using ibus, run `ps x | grep ibus-daemon` and look
  for an `ibus-daemon` process.
