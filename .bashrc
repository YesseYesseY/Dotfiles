#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias gamescope1440='gamescope --force-grab-cursor -w 2560 -h 1440'
PS1='[\u@\h \W]\$ '

export PATH=~/msvc/bin/x64:$PATH
