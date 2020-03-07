neofetch

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# Path to your oh-my-zsh installation.
export ZSH="/home/robovoid/.oh-my-zsh"
PATH=/usr/local/texlive/2019/bin/x86_64-linux:$PATH
ZSH_THEME="powerlevel10k/powerlevel10k"

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
	zsh-autosuggestions
    zsh-syntax-highlighting
	sudo
	vi-mode
    python
	pip
	pipenv
	zsh-z
)

source $ZSH/oh-my-zsh.sh

# User configuration

# set default editor to nvim
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim

# Alias
alias zshconfig="vim ~/.zshrc"
alias q="exit"

#alias
alias update="source ~/.zshrc"
alias brimg="python3 /home/robovoid/Codes/learning-python/basic-scripts/wallpaper_bulk_rename.py"
alias telegram="~/Stuffs/Telegram/Telegram"
alias telegram-update="~/Stuffs/Telegram/Updater"
alias usage="du -h -d1"
alias nvimrc="nvim ~/.config/nvim/init.vim"
alias R="ranger"
alias vim=nvim
alias vi=nvim
alias qt5tools="/usr/lib64/qt5/bin/designer"
alias joplin="~/.joplin/Joplin.AppImage"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


