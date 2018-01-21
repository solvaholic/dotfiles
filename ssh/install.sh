# To be called from script/install

if [ -z "$dotfiles_root" ]; then
  printf "\n\$dotfiles_root is not defined. Call this script via .dotfiles' \`script/install\` or \`bin/dot\`.\n\n"
else
  # If ~/.ssh/config does NOT already exist, then copy over the example.
  if [ ! -f "$HOME/.ssh/config" ]; then
    printf "\n~/.ssh/config does not exist. Copying the examples...\n"
    printf "> cp \"$dotfiles_root/ssh/ssh_config_examples\" \"$HOME/.ssh/config\"\n"
    cp "$dotfiles_root/ssh/ssh_config_examples" "$HOME/.ssh/config"
    # Let the user know what configs have been installed.
    printf "\nYour new ~/.ssh/config defines the following sites:\n"
    grep "^Host " "$HOME/.ssh/config"
    printf "\n\nPlease verify the settings for those sites.\n"
  fi
fi
