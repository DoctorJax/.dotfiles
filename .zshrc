# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zshhistory
setopt appendhistory

# Basic auto/tab complete:
autoload -Uz compinit && compinit -d "$XDG_CACHE_HOME"/zcompdump-"$ZSH_VERSION"
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
zmodload zsh/complist
compinit -d "$XDG_CACHE_HOME"/zcompdump-"$ZSH_VERSION"
_comp_options+=(globdots)

# Custom ZSH Binds
bindkey '^ ' autosuggest-accept

# Load aliases and shortcuts if existent.
[ -f "$HOME/.aliasrc" ] && source "$HOME/.aliasrc"

# Load plugins.
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# For vim keybindings
bindkey -v
bindkey "^?" backward-delete-char

# Bash Insulter
if [ -f /etc/bash.command-not-found ]; then
    . /etc/bash.command-not-found
fi

# Commands before prompt
pfetch | lolcat

# For Starship prompt instead
eval "$(starship init zsh)"

# For fzf keybindings and completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
