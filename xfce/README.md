TODO: Add support for Linux, to this xfce topic.

# Topic: xfce

Includes configuration files and scripts for the `xfce` window manager.

## References

- X Window System, [X(7)](https://man.openbsd.org/X.7)
- X Display Manager, [xenodm(1)](https://man.openbsd.org/xenodm.1)
- [xfce](https://docs.xfce.org/) window manager
- [_Xfce: The Missing Manual_](http://xfce-the-missing-manual.readthedocs.io/en/latest/)

## `xfce/bootstrap`

Ensures prerequisites are met for running xfce:

- We're running an operating system we expect xfce to work on.

  These currently include: OpenBSD

- X(7) and xfce are installed.

## `xfce/setup`

Installs the xfce configuration from `$DOTFILES_ROOT/xfce`.

`xfce/setup` may replace your existing `~/.xinitrc` and `~/.xsession`. It may recommend changes to other configuration files.

## `xfce/.xinitrc`

To start X manually from a command line you'll run `startx`.

`startx` will run `~/.xinitrc`. `xfce/.xinitrc` contains instructions for X to use xfce as the window manager.

## `xfce/.xsession`

To start X automatically when your computer boots, you'll enable a display manager like xenodm.

xenodm will run `~/.xsession`. `xfce/.xsession` contains instructions for X to use xfce as the window manager.
