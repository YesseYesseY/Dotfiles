#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias idapy='python -ic"base = 0x0000000140000000"'
alias msbuild-release='msbuild /p:Configuration=Release'
PS1='[\u@\h \W]\$ '

export PATH=~/msvc/bin/x64:~/Apps:$PATH
export MANPAGER='nvim +Man! -c ":set nu rnu"'
