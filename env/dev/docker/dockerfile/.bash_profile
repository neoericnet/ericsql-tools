# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs

PATH=$HOME/bin:$PATH:.

export PATH

alias cdb="cdbin $HOME/bin"
alias cdb="cd /soft/mysql/source/build"
alias cdd="cd /data/mysql/"

alias cddm="cd /data/mysql/mysqldemo"

alias cdsm="cd /soft/mysql/source/mysql"
alias cdsmt="cd /soft/mysql/source/mysql-tools"
alias cdbm="cd /soft/mysql/source/build/mysql"

export CLION_HOME=/soft/mysql/dev/clion/clion2019
export PATH=$CLION_HOME/bin:$PATH:.
alias cdc="cd $CLION_HOME"

alias cdmut="cd /soft/mysql/source/mysql/unittest/gunit/"

alias cddmgr="cd /data/mysql/mgrdemo"
alias cddm1="cd /data/mysql/mgrdemo/s1"
alias cddm2="cd /data/mysql/mgrdemo/s2"
alias cddm3="cd /data/mysql/mgrdemo/s3"


alias cddrpl="cd /data/mysql/rpldemo"
alias cddr1="cd /data/mysql/rpldemo/s1"
alias cddr2="cd /data/mysql/rpldemo/s2"

umask 000
