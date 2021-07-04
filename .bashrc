#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Just gonna steal the same aliases as zshrc
if [ -f ~/.aliasrc ]; then 
	. ~/.aliasrc 
fi

PS1='[\u@\h \W]\$ '

# Bash insulter

if [ -f /etc/bash.command-not-found ]; then
    . /etc/bash.command-not-found
fi

eval "$(starship init bash)"

pfetch | lolcat
