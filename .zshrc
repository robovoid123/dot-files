# Path to your oh-my-zsh installation.
export ZSH="/home/void/.oh-my-zsh"
ZSH_THEME="spaceship"
BAT_THEME="ansi-dark"

# path to scripts
PATH=$HOME/.local/bin/:~/.scripts/:$PATH

# colors
#autoload -U colors && colors
#PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit

# Include hidden files in autocomplete:
_comp_options+=(globdots)

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char


# Zsh plugins
plugins=(
	git
    extract
	zsh-autosuggestions
    zsh-syntax-highlighting
    python
	sudo
	vi-mode
    colored-man-pages
	zsh-z
    tmux
)

source $ZSH/oh-my-zsh.sh


# User configuration

# set default editor to nvim
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim
export TERMINAL=/usr/bin/alacritty

# Alias
alias zshconfig="vim ~/.zshrc"
alias q="exit"

#alias
alias update="source ~/.zshrc"
alias usage="du -h -d1"
alias nvimrc="nvim ~/.config/nvim/init.vim"
alias R="ranger"
alias vim=nvim
alias vi=nvim
alias py="python3"
alias ls="exa --icons"
alias cat=bat
alias sudo=doas

# fnm
export PATH=/home/void/.fnm:$PATH
eval "`fnm env`"
