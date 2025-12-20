#################
# Configuration #
#################

# C/C++ Compilers
set -gx CC  clang
set -gx CXX clang++

# Application Preference
set -gx PAGER  less
set -gx EDITOR nvim
set -gx VISUAL nvim

###################
# Command Aliases #
###################

## Modern Coreutils ##

# eza: A modern ls alternative
# -x: Sort the files across the grid instead of down
# --group-directories-first: Dead dove - Do not eat
# --icons=auto: Show icons if connected to a terminal
# --tree: Show the items in a tree hierarchy
alias ls="eza -x --group-directories-first --icons=auto"
abbr -a lst ls --tree

# bat: A modern cat alternative
# theme: Use the Catppuccin Mocha(dark) or Latte(light) themes
#        based on the current system preferences.
alias bat="bat --theme=(\
	defaults read -globalDomain AppleInterfaceStyle &> /dev/null && \
	echo \"Catppuccin Mocha\" || echo \"Catppuccin Latte\")"

# rip: move stuff to trash with trash
alias rip=trash

## Git Abbreviations ##

abbr -a gd git diff
abbr -a gp git push
abbr -a gb git branch
abbr -a gs git status
abbr -a gc git commit

####################################
# XDG Base Directory Specification #
####################################

# XDG Directory Specification
# https://wiki.archlinux.org/title/XDG_Base_Directory#User_directories

set -gx XDG_DATA_HOME   ~/.local/share # ~ /usr/share
set -gx XDG_STATE_HOME  ~/.local/state # ~ /var/lib
set -gx XDG_CACHE_HOME  ~/.cache       # ~ /var/cache
set -gx XDG_CONFIG_HOME ~/.config      # ~ /etc

# Force applications with hardcoded directory values to follow the
# XDG Base Directory specification. Much of this list has been adapted
# from the Arch Linux wiki:
# https://wiki.archlinux.org/title/XDG_Base_Directory#Hardcoded

# less: history files
# removes: ~/.lesshst
set -gx LESSHISTFILE $XDG_STATE_HOME/less/history


set -gx ZDOTDIR $XDG_CONFIG_HOME/zsh
set -gx HISTFILE $XDG_STATE_HOME/bash/history

# node: repl history files
# removes: ~/.node_repl_history & ~/.npm
set -gx NODE_REPL_HISTORY $XDG_STATE_HOME/node/history
set -gx NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc

# rust (cargo/rustup): configuration files
# removes: ~/.cargo & ~/.rustup
set -gx CARGO_HOME  $XDG_DATA_HOME/cargo
set -gx RUSTUP_HOME $XDG_DATA_HOME/rustup

# opam: package database
# removes: ~/.opam
set -gx OPAMROOT $XDG_DATA_HOME/opam

# go: data and cache files
# removes: ~/go
set -gx GOPATH     $XDG_DATA_HOME/go
set -gx GOMODCACHE $XDG_CACHE_HOME/go/mod

# terminfo: terminfo and directories
# set -gx TERMINFO      "$XDG_DATA_HOME/terminfo"
# set -gx TERMINFO_DIRS "$TERMINFO:/usr/share/terminfo"

# java (I only have this for Minecraft): cache files
# removes: ~/.openjfx
set -gx _JAVA_OPTIONS -Djavafx.cachedir=$XDG_CACHE_HOME/openjfx

# opam: package registry
# removes: ~/.opam
set -gx OPAMROOT $XDG_DATA_HOME/opam

# docker: configuration files
# removes: ~/.docker
set -gx DOCKER_CONFIG $XDG_CONFIG_HOME/docker

# nuget: package registry
# removes ~/.nuget/packages
set -gx NUGET_PACKAGES $XDG_CACHE_HOME/NuGetPackages

# wget: hosts file
# removes: ~/.wget-hsts
alias wget="wget --hsts-file $XDG_STATE_HOME/wget/hsts"

####################################
# Package management with Homebrew #
####################################

set -gx HOMEBREW_NO_ENV_HINTS true
set -gx HOMEBREW_AUTO_UPDATE_SECS (math 60 x 60 x 24)
set -gx HOMEBREW_BUNDLE_FILE $XDG_CONFIG_HOME/homebrew/Brewfile

# All Homebrew package installs SHOULD be done by editing the
# Brewfile. This ensures a reproducible environment for the mac.
alias brewi="$EDITOR $HOMEBREW_BUNDLE_FILE && brew bundle install || \
	echo \"Brewfile is unchanged... exiting without installing.\""

###################
# Path Extensions #
###################

set -gx PATH $PATH $XDG_STATE_HOME/arbiter/bin
set -gx PATH $PATH $GOPATH/bin



# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/Users/raklaptudirm/.local/share/opam/opam-init/init.fish' && source '/Users/raklaptudirm/.local/share/opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true
# END opam configuration
