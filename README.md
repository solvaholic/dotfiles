# @solvaholic's dotfiles

Your dotfiles are how you personalize your system. These are mine.

Day-to-day I use one login on one laptop. Occasionally I spin up a VM or container for a project, or I need to set up a new laptop to work on. So I wanted a way to back up my dotfiles and to share them across different systems I use.

After trying feebly to solve that myself I remembered: Someone else has probably already solved this. A search and a click led me to https://dotfiles.github.io/ and from there I found [@holman's dotfiles](https://github.com/holman/dotfiles).

I like @holman's modular organization and ease-of-use. And [his narrative about sharing dotfiles](http://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/) makes my :heart: feel good. So here we are.

If you're interested in the philosophy behind why projects like these are
awesome, check out [@holman's post on the
subject](http://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/).

## Topics

Everything's built around topic areas. If you're adding a new area to your
forked dotfiles — say, "Java" — you can simply add a `java` directory and put
files in there. Anything with an extension of `.zsh` will get automatically
included into your shell. Anything with an extension of `.symlink` will get
symlinked without extension into `$HOME` when you run `script/bootstrap`.

## What's inside?

A lot of stuff. Seriously, a lot of stuff. Check them out in the file browser
above and see what components may mesh up with you.
[Fork it](https://github.com/solvaholic/dotfiles/fork), remove what you don't
use, and build on what you do use.

## Components

There's a few special files in the hierarchy.

- **Brewfile**: This is a list of applications for [Homebrew Cask](https://caskroom.github.io) to install. Edit this file before running any initial setup.
- **topic/setup**: Additional setup for the topic's dotfiles. `dotfiles/script/setup` runs each topic's `setup` before linking the topic's `*.symlink`.
- **topic/\*.symlink**: Any file ending in `*.symlink` gets symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `script/setup`.

## Install

```sh
git clone https://github.com/solvaholic/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`.

The main file you'll want to change right off the bat is `zsh/zshrc.symlink`,
which sets up a few paths that'll be different on your particular machine.

`dot` is a simple script that installs some dependencies, sets sane macOS
defaults, and so on. Tweak this script, and occasionally run `dot` from
time to time to keep your environment fresh and up-to-date. You can find
this script in `bin/`.

## Bugs

I want this to work for everyone; that means when you clone it down it should
work for you even though you may not have `rbenv` installed, for example. That
said, I do use this as *my* dotfiles, so there's a good chance I may break
something if I forget to make a check for a dependency.

If you're brand-new to the project and run into any blockers, please
[open an issue](https://github.com/solvaholic/dotfiles/issues) on this repository and I'd love to get it fixed for you!

## Thanks

Thank you @holman for teaching me about these dotfiles projects, and for sharing yours!

From @holman:

> I forked [Ryan Bates](http://github.com/ryanb)' excellent
[dotfiles](http://github.com/ryanb/dotfiles) for a couple years before the
weight of my changes and tweaks inspired me to finally roll my own. But Ryan's
dotfiles were an easy way to get into bash customization, and then to jump ship
to zsh a bit later. A decent amount of the code in these dotfiles stem or are
inspired from Ryan's original project.
