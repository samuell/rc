#!/bin/bash

# --------------------------------------------------------------------------------
# Edit dotfiles
# --------------------------------------------------------------------------------
vs() {
    vim $1;
    source $1;
}
alias ev='vim ~/.vimrc'
alias evc='vim ~/.vim/colors/samllight.vim'
alias ea='vs ~/.bash_aliases'
alias ez='vs ~/.zshrc'
alias eal='vs ~/.bash_aliases_local'
alias eb='vs ~/.bashrc'
alias ep='vs ~/.profile'

# --------------------------------------------------------------------------------
# Various short-hand commands
# --------------------------------------------------------------------------------
# Aptitude
alias aptg='sudo apt-get install'
alias aptr='sudo apt-get remove'
alias apts='apt-cache search'
alias aptu='sudo apt-get update'
alias aptug='sudo apt-get upgrade'
alias ubuntu_version='lsb_release -a'
# Git
alias glog='git log --pretty=oneline|tig'
alias gdiff='git diff|tig'
alias gcommit='git commit'
alias gpush='git push'
alias gpp='git pull --rebase origin master; git push origin master;'
alias gadd='git add'
alias dus='{ for f in *; do du -sh $f; done; }|sort -h'
# SSH
alias sshpass='ssh -o PubkeyAuthentication=no'
alias scppass='scp -o PubkeyAuthentication=no'
# Screen
alias sl='screen -ls'
alias sms='screen -mS'
alias sr='screen -r'
alias sdr='screen -dr'
ks() {
    screen -X -S $1 quit
}
# The ls command
alias ls='ls --color=auto -h'
alias l='ls -l'
alias ll='ls -l'
# Misc
alias s='less -S'
alias py='python'
alias ipy='ipython'
alias R='R --no-save'

# --------------------------------------------------------------------------------
# Directory browsing and handling
# --------------------------------------------------------------------------------
c() {
    cd $1;
    ls -l;
    echo " ";
    pwd;
}
alias ..='c ..'
alias ....='c ../..'
alias ......='c ../../..'
mkcd() {
    mkdir -p $1;
    cd $1;
}


# --------------------------------------------------------------------------------
# Resource utilization stuff
# --------------------------------------------------------------------------------
# Switch between frequency schemes
alias lo='sudo cpufreq-set -r -d 1.20GHz -u 1.20GHz'
alias hi='sudo cpufreq-set -r -d 1.20GHz -u 2.60GHz'
alias max='sudo cpufreq-set -r -d 2.20GHz -u 2.20GHz'
alias ccinfo='sudo cpufreq-info 2>&1|grep current|less'
# pass options to free 
alias meminfo='free -m -l -t'
# get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
# get top process eating cpu
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
# Get server cpu info
alias cpuinfo='lscpu'
# Directory sizes
alias dirsizes='{ for f in `find -maxdepth 1 -type d`; do du -sh $f; done; }|sort -h'
alias logmemusage='sar -r 1'

# --------------------------------------------------------------------------------
# Switch keyboard layout
# --------------------------------------------------------------------------------
alias kb='setxkbmap'
alias se='setxkbmap se'
function us() {
    echo "Setting keyboard map to US";
    setxkbmap 'us';
    xmodmap -e 'keycode 108 = Mode_switch';
    xmodmap -e 'remove mod1 = Mode_switch';
    xmodmap -e 'keycode 34 = bracketleft braceleft aring Aring';
    xmodmap -e 'keycode 48 = apostrophe quotedbl adiaeresis Adiaeresis';
    xmodmap -e 'keycode 47 = semicolon colon odiaeresis Odiaeresis';
}


# --------------------------------------------------------------------------------
# Create test file
# --------------------------------------------------------------------------------
alias hej='echo "Hej!" > hej.txt'


# --------------------------------------------------------------------------------
# Misc advanced stuff
# --------------------------------------------------------------------------------
alias switchjava='sudo update-alternatives --config java'
topname() {
    top -p $(pgrep -d"," $1);
}
cythonize() {
    cython --embed $1.pyx
    gcc -I/usr/include/python2.7 -O3 -o $1 $1.c -lpython2.7
}
alias cppsearchpaths="`gcc -print-prog-name=cc1plus` -v"
alias csearchpaths="`gcc -print-prog-name=cc1` -v"
alias ...='echo … | xsel --clipboard'
alias chnscc='cd ~/code/farmbio/hnscc'
function killpids() {
  ps aux | grep $1 | awk '{ print $2 }' | xargs kill -9;
}
dlmp3() {
    for f in $(curl -s $1 | grep -oP "(http|https|ftp|www).*\.(mp3|wav|m4a|ogg|mp4)" | sort | uniq);
        do curl -sOL $f; 
    done;
}
time3() {
    if [[ ! -z "$2" ]]; then
        procs=$2;
        export GOMAXPROCS=$procs;
    fi;
    cmd=$1;
    echo "Benchmarking command: $cmd"
    echo "GOMAXPROCS: $GOMAXPROCS"
    t1=$({ time ./$cmd > output.txt; } 2>&1 |grep real|grep -oP "\d\.\d+")
    echo "Time 1: $t1"
    sleep 1
    t2=$({ time ./$cmd > output.txt; } 2>&1 |grep real|grep -oP "\d\.\d+")
    echo "Time 2: $t2"
    sleep 1
    t3=$({ time ./$cmd > output.txt; } 2>&1 |grep real|grep -oP "\d\.\d+")
    echo "Time 3: $t3"
    sleep 1
    echo "Average (3 samples): "`echo "scale=3; ($t1 + $t2 + $t3)/3.0"|bc`;
}
install_vundle() {
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/vundle
    echo "Now open vim and execute: :PluginInstall !"
}
bookmark() {
    name=$1;
    dir=$(pwd);
    echo "alias c$name='c $dir'" >> ~/.bash_aliases_local
    source ~/.bash_aliases_local
}
bookmarks() {
    cat ~/.bash_aliases_local | grep "alias c"
}
source ~/.bash_aliases_local
alias installflash='sudo apt-get install pepperflashplugin-nonfree'
alias updateflash='sudo update-pepperflashplugin-nonfree --install'
