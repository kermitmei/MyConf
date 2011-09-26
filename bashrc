# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# Put your fun stuff here.

if [ $USER == "root" ]
then
    alias sps='PS1="\[\033[01;31m\]\[\033[01;34m\]#\[\033[00m\] "'
    alias dps='PS1="\[\033[01;31m\]\h\[\033[01;34m\] \W #\[\033[00m\] "'
else
    alias sps='PS1="\[\033[01;32m\]\[\033[01;34m\]\$\[\033[00m\] "'
    alias dps='PS1="\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] "'
fi


alias rtmp='find . -maxdepth 2 -name "*~" -exec rm -rf {} +;'
alias ptmp='find . -maxdepth 2 -name "*~" -print;'
alias l='ls -lh'
alias la='ls -alh'
alias wcpp='find . \( -iname "*.h" -o -iname "*.cpp" -o -iname "*.c" \) -print0|xargs -0 wc -l'

alias etagscpp='find . \( -iname "*.h" -o -iname "*.cpp" -o -iname "*.c" \) -print0|xargs -0 etags --append'
alias etagsc='find . \( -iname "*.h" -o -iname "*.c" \) -print0|xargs -0 etags --append'
alias etagspy='find . \( -iname "*.py" -o -iname "*.pyw" \) -print0|xargs -0 etags --append'

alias cdksrc='cd /home/ksrc'

function cx() { 
    touch "$@";
    chmod 755 "$@";
}

function cxpl() { 
    touch "$@";
    chmod 755 "$@";
    echo "#!/usr/bin/env perl" > $@
}

function cxpy() { 
    touch "$@";
    chmod 755 "$@";
    echo "#!/usr/bin/env python" > $@
}

function cxsh() { 
    touch "$@";
    chmod 755 "$@";
    echo "#!/usr/bin/env sh" > $@
}

function getgitarchive() {
    CUR_DT=`date +%h%d_%H%M`
    git archive master --prefix=Yin5BV2.0/|bzip2 -9 > ~/Yin5BV2.0_$CUR_DT.tar.bz2
}


export PATH=~/bin:/sbin:$PATH
export EDITOR=/usr/bin/nemacs
sps
