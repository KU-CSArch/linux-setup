# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Path
#PATH=.:$PATH
PATH=$PATH:~/bin:~/bin/common

# Aliases (by Gunjae)
alias cp='cp -i'
alias rm='rm -i'
alias mv='mv -i'
alias p='cd ..'
alias cd..='cd ..'
alias du='du --max-depth=1'
alias dus='du --max-depth=1 -h . | sort -h'
alias chgcc='sudo update-alternatives --config gcc'
alias chg++='sudo update-alternatives --config g++'
alias ydl='~/bin/ydl --prefer-ffmpeg'
alias vncserver='vncserver -localhost no'

# setup for CUDA and GPGPU-Sim
function setup_cuda_gpusim() {
	PATH=$PATH:/usr/local/cuda/bin
	export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/cuda/lib
	export CUDA_INSTALL_PATH=/usr/local/cuda
	export NVIDIA_COMPUTE_SDK_LOCATION=~/workspace/cuda_sdk4
}

# setup for Xilinx Vivado
function setup_vivado() {
	#source /opt/Xilinx/Vivado/2014.4/settings64.sh
	export XILINXD_LICENSE_FILE=2100@203.249.80.222
	#export XILINXD_LICENSE_FILE=1713@ics-lic.usc.edu
	export LM_LICENSE_FILE=$LM_LICENSE_FILE:1715@lic-modelsim.usc.edu
}

# setup for Intel Quartus
function setup_quartus() {
	export ALTERAOCLSDKROOT="/usr/local/altera/15.1/hld"
	export QSYS_ROOTDIR="/usr/local/altera/15.1/quartus/sopc_builder/bin"
	export LM_LICENSE_FILE=$LM_LICENSE_FILE:50001@152.14.88.208
	PATH=$PATH:/usr/local/altera/15.1/quartus/bin
}

# setup for TexLive
function setup_texlive() {
	PATH=$PATH:/usr/local/texlive/$1/bin/x86_64-linux
	#PATH=$PATH:/usr/local/texlive/2017/bin/x86_64-linux
}

# Environments (common)
export SVN_EDITOR=/usr/bin/vim

# Default starting folder (home)
cd
if [ -f /usr/bin/neofetch ]; then
	neofetch
fi
# For tilix
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
	source /etc/profile.d/vte.sh
fi

# LD_LIBRARY_PATH for updated gcc/g++
#LD_LIBRARY_PATH=/usr/lib64:$LD_LIBRARY_PATH
#export LD_LIBRARY_PATH

echo "Gunjae's bash environemt (08/21/2019)"
