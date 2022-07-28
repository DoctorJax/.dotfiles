# XDG path variables
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# Cleaning up home directory using variables
export LESSHISTFILE="$XDG_CACHE_HOME"/less_history
export CALCHISTFILE="$XDG_CACHE_HOME"/calc_history
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export CCACHE_DIR="${XDG_CACHE_HOME}"/ccache
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export __GL_SHADER_DISK_CACHE_PATH="$XDG_CACHE_HOME"/nv
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export MPLAYER_HOME="$XDG_CONFIG_HOME"/mplayer
export GOPATH="$XDG_DATA_HOME"/go

# QT theming
export QT_QPA_PLATFORMTHEME="qt5ct"
