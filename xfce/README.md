TODO: Is "X windows" the correct name and case?
TODO: Sync content and layout between cwm and xfce README.md's.

# Topic: xfce

Includes configuration files and scripts for the `xfce` window manager.

## `xfce/bootstrap`

Ensures prerequisites are met for running `xfce`:

- We're running an operating system we expect `xfce` to work on.

  These currently include: OpenBSD

- `X` and `xfce` are installed.

## `xfce/setup`

Installs the `xfce` configuration from `$DOTFIELS_ROOT/xfce`.

`xfce/setup` may replace your existing `~/.xinitrc` and `~/.xsession`. It may recommend changes to other configuration files.

## `xfce/.xinitrc`

To start X windows manually from a command line you'll run `startx`.

`startx` will run `~/.xinitrc`. `xfce/.xinitrc` contains instructions for `X` to use the `xfce` window manager.

## `xfce/.xsession`

To start X windows automatically when your computer boots, you'll enable a display manager like `xdm`.

`xdm` (and/or `xenodm`?) (and `gdm` or others?) will run `~/.xsession`. `xfce/.xinitrc` contains instructions for `X` to use the `xfce` window manager.
