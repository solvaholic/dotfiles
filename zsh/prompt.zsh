export GIT_PS1_SHOWDIRTYSTATE=Yes
source $HOME/.dotfiles/zsh/git-prompt.sh
PS1='[%n@%m %c$(__git_ps1 " (%s)")]%% '
