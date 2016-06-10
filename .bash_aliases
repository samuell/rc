#!/bin/bash

# --------------------------------------------------------------------------------
# Shortcut bindings
# --------------------------------------------------------------------------------
#bind -x '"\C-t":htop'
# --------------------------------------------------------------------------------
# Edit dotfiles
# --------------------------------------------------------------------------------
vs() {
    vim $1;
    . $1;
}
alias ev='vim ~/.vimrc'
alias ei='vim ~/.irods/.irodsEnv'
alias evc='vim ~/.vim/colors/samllight.vim'
alias ea='vs ~/.bash_aliases'
alias eal='vs ~/.bash_aliases_local'
alias eb='vs ~/.bashrc'
alias ebm='vs ~/.bashrc_mods'
alias ebl='vs ~/.bashrc_local'
alias ep='vs ~/.profile'
alias ebp='vs ~/.bash_profile'
alias et='vim ~/.tmux.conf'

# --------------------------------------------------------------------------------
# Various short-hand commands
# --------------------------------------------------------------------------------
# Text editing
alias e='vim'
alias v='vim'
alias n='nano'
# Aptitude
alias aptg='sudo apt-get -y install'
alias aptr='sudo apt-get remove'
alias apts='apt-cache search'
alias aptu='sudo apt-get update'
alias aptug='sudo apt-get update && sudo apt-get upgrade'
alias ubuntu_version='lsb_release -a'
# Git
alias glog='git log --pretty=oneline|tig'
alias gdiff='git diff --no-index --'
alias gcommit='git commit'
alias gpush='git push'
alias gpp='git pull --rebase; git push;'
alias gadd='git add'
alias gb='git branch -av'
alias gd='git diff | tig'
alias dus='du -sh * | sort -h'
alias dusa='du -ash .* | sort -h'
alias t='tig'
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
# tmux
#alias tn='tmux new'
function tn() {
    sess=$(date +%F)
    tmux new-session -d -s $sess
    #tmux split-window -v -l 7;
    #tmux select-pane -U;
    #tmux split-window -h;
    #tmux select-pane -L;
    tmux -2 attach-session -d
}
#alias tns='tmux new -s'
function tns() {
    tmux new-session -d -s "$1";
    #tmux split-window -v -l 7;
    #tmux select-pane -U;
    #tmux split-window -h;
    #tmux select-pane -L;
    tmux -2 attach-session -d
}
alias ta='tmux attach'
alias tas='tmux attach -t'
alias ts='tmux switch'
alias tss='tmux switch -s'
alias tl='tmux list-sessions'
# The ls command
alias ls='ls --color=auto -h'
alias l='ls -1'
alias ll='ls -l'
alias la='ls -1a'
alias ltr='ls -1tr'
alias ltra='ls -1tra'
alias ltrad='ls -1trad'
alias lltr='ls -ltr'
alias lltra='ls -ltra'
alias lltrad='ls -ltrad'
alias last='tail -n 1'
alias llast='ls -1tr | last'
alias slast='llast | xargs less -iS'
alias lslast='llast | xargs less -i'
# Misc
alias s='less -SiR'
alias z='zless -SiR'
alias py='python'
alias p='python'
alias pm='python manage.py'
alias ipy='ipython'
alias igrep='grep -i'
psa() {
	term=$1;
	echo "Now showing processes including $term in name ...";
	/bin/ps aux | grep "$term";
}
alias k='kill -9'
alias R='R --no-save'
padold() {
    mv $1{,.old}
}
padtmp() {
    mv $1{,.tmp}
}
pad() {
    mv $1{,.$2}
}
padrem() {
    mv $1{.$2,}
}
alias vg='vagrant'
alias vgu='vagrant up'
alias vgp='vagrant provision'
alias vgs='vagrant ssh'
alias vgst='vagrant status'
alias vgh='vagrant halt'
alias vgd='vagrant destroy'
alias sm='snakemake'
function gitsshify() {
	echo 'git@github.com:'$1'.git';
}


# --------------------------------------------------------------------------------
# Directory browsing and handling
# --------------------------------------------------------------------------------
c() {
    cd "$1";
    ls -ltra --color=always | tail -n 25;
    echo " ";
    pwd;
}
alias ..='cd ..'
alias ....='cd ../..'
alias ......='cd ../../..'
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
us() {
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
	if [[ ! $1 ]]; then
		echo "Usage: bookmark BOOKMARKNAME";
	else
		name=$1;
		dir=$(basename $(pwd));
		echo "alias c$name='c $dir'" >> ~/.bash_aliases_local
		source ~/.bash_aliases_local
	fi
}
bookmarks() {
    cat ~/.bash_aliases_local | grep "alias c"
}
source ~/.bash_aliases_local
alias installflash='sudo apt-get install pepperflashplugin-nonfree'
alias updateflash='sudo update-pepperflashplugin-nonfree --install'
ogvtoavi_mjpeg() {
    infile=$1
    outfile=$1"_mjpeg.avi"
    avconv -i "$infile" -vcodec mjpeg -acodec mp2 "$outfile"
}
ogvtoavi_h264() {
    infile=$1
    outfile=$1"_h264.avi"
    avconv -i "$infile" -vcodec h264 -acodec mp2 "$outfile"
}
extractaudio() {
    infile=$1
    avconv -i "$infile" "$infile.wav"
}
function lf() {
    ls -1tr | tail -n 1;
}
alias cutt='cut -c -$COLUMNS'
div() { 
    echo "=========================================================================="
    echo " $1"
    echo "=========================================================================="
}
ogvtoavi_mjpeg() {
    infile=$1
    outfile=$1"_mjpeg.avi"
    avconv -i "$infile" -vcodec mjpeg -acodec mp2 "$outfile"
}
ogvtoavi_h264() {
    infile=$1
    outfile=$1"_h264.avi"
    avconv -i "$infile" -vcodec h264 -acodec mp2 "$outfile"
}
extractogvaudio() {
    infile=$1
    avconv -i "$infile" -vn -c:a copy "$infile.ogg"
}
function lf() {
    ls -1tr | tail -n 1;
}
alias now='date +%Y%m%d_%H%M%S';
function swap_audio_of_video() {
    if [[ ! -z "$1" && ! -z "$2" && ! -z "$3" ]]; then
		videofile=$1;
		audiofile=$2;
		outfile=$3;
		avconv -i $videofile -i $audiofile -c:v copy -c:a copy -map 0:1 -map 1:0 $outfile;
	else
		echo "Usage: <input-video> <input-audio> <output-video>"
	fi;
}
ogv_to_mp4() {
	avconv -i $1 \
	 -c:v libx264 -preset veryslow -qp 0 \
	 -vf scale="720:trunc(ow/a/2)*2" \
	 -c:a libmp3lame -qscale:a 3 -af 'volume=1.5' -ac 2 \
	 $1.mp4
}
p12_to_pem() {
	openssl pkcs12 -in $1 -out $1'.crt.pem' -clcerts -nokeys
	openssl pkcs12 -in $1 -out $1'.key.pem' -nocerts -nodes
}
exif_posingmaps() {
    if [[ -z $1 ]]; then
        echo "Usage exif_openposingcal <IMAGEFILE>";
    else
        # Take imagefile as first argument
        imagefile=$1

        # Extract longitude position
        longpos=$(exif -m $imagefile | grep ^Longitude | grep -oP "[0-9]+.*" | sed -r 's/,[\ ]+/ /g');
        # Extract whether East (E) or West (W)
        eorw_raw=$(exif -m $imagefile | grep "East or West Longitude")
        eorw=${eorw_raw#East or West Longitude}

        # Extract latitude position
        latpos=$(exif -m $imagefile | grep ^Latitude | grep -oP "[0-9]+.*" | sed -r 's/,[\ ]+/ /g');
        # Extract whether North (N) or South (S)
        nosw_raw=$(exif -m $imagefile | grep "North or South Latitude")
        nosw=${nosw_raw#North or South Latitude}

        # Assemble URL
        url="https://www.google.se/maps/place/"$longpos"%20"$eorw"%20"$latpos"%20"$nosw
        # Replace spaces with url-safe counterpart
        url=$(echo $url | sed 's/ /%20/g' | sed 's/,/./g');

        # Open URL in browser ...
        echo "Extracted position: $longpos $eorw, $latpos $nosw";
        echo "Opening URL in browser: "$url;
        exo-open --launch WebBrowser $url &
    fi;
}
dh() {
cat <<EOM
General commands:
    events    Get real time events from the server
    info      Display system-wide information
    login     Register or Login to the docker registry server
    version   Show the docker version information

Commands for working with images:
    build     Build an image from a Dockerfile
    history   Show the history of an image
    images    List images
    import    Create a new filesystem image from the contents of a tarball
    load      Load an image from a tar archive
    pull      Pull an image or a repository from the docker registry server
    push      Push an image or a repository to the docker registry server
    rmi       Remove one or more images
    save      Save an image to a tar archive
    search    Search for an image in the docker index
    tag       Tag an image into a repository

Commands for working with containers (instances of images):
    attach    Attach to a running container
    commit    Create a new image from a container's changes
    diff      Inspect changes on a container's filesystem
    cp        Copy files/folders from the containers filesystem to the host path
    export    Stream the contents of a container as a tar archive
    inspect   Return low-level information on a container
    kill      Kill a running container
    logs      Fetch the logs of a container
    port      Lookup the public-facing port which is NAT-ed to PRIVATE_PORT
    pause     Pause all processes within a container
    ps        List containers
    ps -a     List all containers (including stopped ones)
    restart   Restart a running container
    rm        Remove one or more containers
    run       Run a command in a new container
    start     Start a stopped container
    stop      Stop a running container
    top       Lookup the running processes of a container
    unpause   Unpause a paused container
    wait      Block until a container stops, then print its exit code
EOM
}

