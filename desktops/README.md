The desktops topic includes sub-topics for window managers and desktop
environments for UNIX-like systems.

Each topic should include:

`bootstrap` - Ensure any software dependencies are met.

`setup` - Enable and configure this item using the configurations 
  present in your .dotfiles directory. Automatically back up any 
  configuration files that will be modified.

For example, if you want to enable and configure cwm:

  .dotfiles/desktops/cwm/bootstrap
  .dotfiles/desktops/cwm/setup

Those steps will ensure X and cwm are installed and then apply the 
relevant configurations from your .dotfiles directory. If `setup` 
will modify any existing configurations, it will automatically back 
them up first.
