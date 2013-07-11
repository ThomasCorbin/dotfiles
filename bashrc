# .bashrc

# User specific aliases and functions
#source /etc/bash_completion.d/git
source /etc/bash_completion

#----------------------------------------
#    Skip loading functions and aliases if not an interactive shell
#----------------------------------------
PATH=$HOME/bin:/usr/bin:/bin:/etc
#PATH=$HOME/bin:/usr/ucb:/usr/bin:/bin:/etc
export HOST=$(hostname)
export USER=$(whoami)

[ -z "$PS1" ] && return

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
#rvm list
#which ruby

#[[ -s "$HOME/.lightning/functions.sh" ]] && source "$HOME/.lightning/functions.sh"

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [ ! -x /bin/arch ]; then
    alias arch="uname -sr | sed -e 's/ //'"
fi

#export LOCATE_PATH=/usr/local/lib/locatedb




if [ "$PS1" != "" ]; then
    #
    #  Load aliases.
    #
    if [ -f $HOME/.aliases ]; then
        source $HOME/.aliases
    fi


    #
    #  Load functions.
    #
    export FPATH=$HOME/bin/bfuncs
    if [ -f $HOME/.bfuncs ]; then
        source $HOME/.bfuncs
    fi

    #----------------------------------------
    #    If we're running X, then set prompt command.
    #----------------------------------------
#    if [ X"$DISPLAY" != X ]; then
#        dotitles
#    fi
fi
# echo 'Sourced aliases and bfuncs'

export ARCH=$(arch)

#if [ x"$TERM" = x"linux" ]; then
    eval `dircolors`
#fi


#----------------------------------------
#    SamSix stuff
#----------------------------------------
export S6_TOP=$HOME/dev/sam/nrg/build
export S6_TMPDIR=/tmp/oms
export S6_NRG_DEV_DIR=$HOME/dev/sam/nrg
export NRG_TOOLS_BIN_DIR=$HOME/dev/sam/nrg/tools/bin
#export S6_CONFIG=/home/$USER/dev/SamSix/S6_CONFIG.tc
export S6_DEV_TOP=$HOME/dev/sam/nrg
export OMS_TOP=$HOME/dev/oms
export NRG_TOP=$HOME/dev/sam/nrg
export OMS_DB=omsdb
export PGDATABASE=nrgdb

#export PGHOST=localhost
export PGHOST=localhost
export PGUSER=$USER

export ANT_HOME=~/dev/tools/apache-ant
export NODE_HOME=~/dev/tools/node
export CATALINA_HOME=/var/lib/tomcat6
export TOMCAT_LOGS=/var/log/tomcat6
export GROOVY_HOME=/home/$USER/dev/tools/groovy
export GRADLE_HOME=/home/$USER/dev/tools/gradle


#----------------------------------------
#    Python stuff
#----------------------------------------
if [ -f ~/.pythonrc ]; then
    export PYTHONSTARTUP=~/.pythonrc
fi


#export PROMPT_COMMAND='PS1="\t \w\n$(git branch 2>/dev/null | grep \* | colrm 1 2) \u@\h > "';
#export PROMPT_COMMAND="PS1='\t \w\n(__git_ps1 " (%s)") \u@\h > '";
# unset PROMPT_COMMAND

#... untagged(*) and staged(+) changes
export GIT_PS1_SHOWDIRTYSTATE=1

#... if something is stashed($)
export GIT_PS1_SHOWSTASHSTATE=1

#... untracked files(%)
export GIT_PS1_SHOWUNTRACKEDFILES=1

# PS1='\t \w $(~/.rvm/bin/rvm-prompt)\n$(__git_ps1 " (%s)") \u@\h > '
source ~/.rvm/contrib/ps1_functions
ps1_set --prompt ∫

PS2="c'mon dummy > "
PS3="choose one: "

X11=/usr/X11R6
X11_BIN=$X11/bin

#----------------------------------------
#    This is 'cause when I ssh in from home, it gets screwed up.
#----------------------------------------
MAIL=/var/spool/mail/tc
MH_HOME=/usr/bin/mh

JAVA_HOME=~/misc/jdk1.6.0
JAVA_HOME=~/dev/tools/jdk1.7.0
JAVAFX_HOME=~/dev/tools/jdk1.7.0/jre/lib
export JAVA_HOME
export JAVAFX_HOME
export IDEA_JDK=$JAVA_HOME
export IDEA_HOME=~/dev/tools/idea
export RUBYMINE_JDK=$JAVA_HOME
export RUBYMINE_HOME=~/dev/tools/RubyMine
export JRUBY_OPTS=--1.9
export PATH
# PATH=$(echo $PATH | sed -e 's/::/:/g')
PATH=$(ruby ~/.path)




#----------------------------------------
#    Special bash variables.
#----------------------------------------
#export EXINIT='set noai aw noeb noic nolisp sm noterse'
export FCEDIT=xemacs
export VISUAL=vi
export EDITOR=vi
export XEDITOR=emacs
export HISTSIZE=1500
export HISTTIMEFORMAT="%F %T "
export HISTIGNORE="&:ls:cd:[bf]g:exit"
#export HISTFILE="$HOME/.bash_history_"$(tty| groovy -ne "println line.replace( '/dev/pts/', '')")
export FIGNORE=".o:~"
export PWD
export PAGER=less
export LESS=M


set completion-ignore-case on

no_exit_on_failed_exec=
history_control=ignorespace
notify=
ulimit -c 0
umask 2




CRON_FILE=~/.cron.$HOST.$USER
if [ -r "$CRON_FILE" ]; then
    crontab $CRON_FILE
fi

echo "setting up rvm scripts"
# stty erase ^H
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

#set 'export rvm_pretty_print_flag=1'
export rvm_pretty_print_flag=1

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "/home/tc/.gvm/bin/gvm-init.sh" ]] && source "/home/tc/.gvm/bin/gvm-init.sh"
