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

eval "$(starship init bash)"

pfetch | lolcat
