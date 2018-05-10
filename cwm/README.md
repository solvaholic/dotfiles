TODO: Is "X windows" the correct name and case?
TODO: Sync content and layout between cwm and xfce README.md's.

# Topic: cwm

Includes configuration files and scripts for the `cwm` window manager.

## `cwm/bootstrap`

Ensures prerequisites are met for running `cwm`:

- We're running an operating system we expect `cwm` to work on.

  These currently include: OpenBSD

- `X` and `cwm` are installed.

## `cwm/setup`

Installs the `cwm` configuration from `$DOTFIELS_ROOT/cwm`.

`cwm/setup` may replace your existing `~/.xinitrc` and `~/.xsession`. It may recommend changes to other configuration files.

## `cwm/.xinitrc`

To start X windows manually from a command line you'll run `startx`.

`startx` will run `~/.xinitrc`. `cwm/.xinitrc` contains instructions for `X` to use the `cwm` window manager.

## `cwm/.xsession`

To start X windows automatically when your computer boots, you'll enable a display manager like `xdm`.

`xdm` (and/or `xenodm`?) (and `gdm` or others?) will run `~/.xsession`. `cwm/.xinitrc` contains instructions for `X` to use the `cwm` window manager.
