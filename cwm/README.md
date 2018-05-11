# Topic: cwm

Includes configuration files and scripts for the `cwm` window manager.

## References

- X Window System, [X(7)](https://man.openbsd.org/X.7)
- X Display Manager, [xenodm(1)](https://man.openbsd.org/xenodm.1)
- [cwm(1)](https://man.openbsd.org/cwm.1) window manager

## `cwm/bootstrap`

Ensures prerequisites are met for running cwm(1):

- We're running an operating system we expect cwm to work on.

  These currently include: OpenBSD

- X(7) and cwm are installed.

## `cwm/setup`

Installs the cwm configuration from `$DOTFIELS_ROOT/cwm`.

`cwm/setup` may replace your existing `~/.xinitrc` and `~/.xsession`. It may recommend changes to other configuration files.

## `cwm/.xinitrc`

To start X manually from a command line you'll run `startx`.

`startx` will run `~/.xinitrc`. `cwm/.xinitrc` contains instructions for X to use cwm as the window manager.

## `cwm/.xsession`

To start X automatically when your computer boots, you'll enable a display manager like xenodm.

xenodm will run `~/.xsession`. `cwm/.xsession` contains instructions for X to use cwm as the window manager.
