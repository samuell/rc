#!/bin/bash

# --------------------------------------------------------------------------------
# Shortcut bindings
# --------------------------------------------------------------------------------
#bind -x '"\C-t":htop'
# --------------------------------------------------------------------------------
# Edit dotfiles
# --------------------------------------------------------------------------------
alias vim="bind -r '\\C-s' && stty stop '' -ixoff && vim"
vs() {
    vim +10000 $1;
    . $1;
}
alias ev='vim ~/.vimrc'
alias ei='vim ~/.irods/.irodsEnv'
alias evc='vim ~/.vim/colors/samllight.vim'
alias ea='vs ~/.bash_aliases'
alias sb='source ~/.bashrc'
alias eg='vim ~/.gitconfig'
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
alias aptr='sudo apt-get -y remove'
alias apts='apt-cache search'
alias aptu='sudo apt-get update'
alias aptug='sudo apt-get update && sudo apt-get upgrade -y'
alias ubuntu_version='lsb_release -a'
# Git
alias glog='git log --pretty=oneline|tig'
alias gdiff='git diff --no-index --'
alias gwdiff='git diff --word-diff --no-index --'
alias gcm='git commit -m'
alias gcam='git commit -am'
alias gcaa='git commit -a --amend'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gpush='git push'
alias gpp='git pull --rebase; git push;'
alias gadd='git add'
alias gb='git branch -av'
alias gd='git diff | tig'
alias dus='du -sh * | sort -h | tee dus.$(date +%Y%m%d.%H%M%S)'
alias dush='for f in ./.*; do du -sh $f; done | sort -h | tee dush.$(date +%Y%m%d.%H%M%S)'
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
    tmux new-session -s "$1";
    #tmux split-window -v -l 7;
    #tmux select-pane -U;
    #tmux split-window -h;
    #tmux select-pane -L;
    #tmux -2 attach-session -d
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
alias elast='llast | xargs vim'
alias vlast='llast | xargs vim'
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
alias th='thunar . &'
alias ..='cd ..'
alias ....='cd ../..'
alias ......='cd ../../..'
mkcd() {
    mkdir -p $1;
    cd $1;
}

# --------------------------------------------------------------------------------
# Go(lang) stuff
# --------------------------------------------------------------------------------
alias gocov='go test -coverprofile=.cover.out; \
    go tool cover -html=.cover.out -o coverage.html; \
    brave-browser coverage.html; \
    sleep 1; \
    rm .cover.out coverage.html;'

function goprof() {
    # USAGE:
    # goprof myapp.go --param1 val1 --param2 val2

    # Receive params
    gofile=$1;
    p1=$2;
    p2=$3;
    p3=$4;
    p4=$5;
    p5=$6;

    # Define paths for all temporary files
    now=$(date +%Y%m%d_%H%M%S);
    prefix="perftest_"$now"_"
    perftestbin=$prefix${gofile%.go}"_bin";
    pproffile=$prefix${gofile%.go}".pprof";
    slowfuncsfile=$prefix"slowfuncs.log";
    tmppprofpathfile=$prefix"tmppprofpath.txt"

    # Make sure Dave Cheney's profile lib is installed
    # (see http://dave.cheney.net/2013/07/07/introducing-profile-super-simple-profiling-for-go-programs)
    if ! go list github.com/pkg/profile;
    then
        go get -u github.com/pkg/profile
    else
        echo "github.com/pkg/profile already installed!"
    fi

    # Inject the necessary calls to the profile library installed above
    if grep -q "profile" $gofile;
    then
        echo "Seems like profile code already exists in $gofile, so not modifying it.";
    else
        lineno=$(($(grep -n "import (" $gofile | cut -f1 -d:) + 1));
        sed -i "${lineno}i \"github.com/pkg/profile\"" $gofile;
        lineno=$(($(grep -n "main()" $gofile | cut -f1 -d:) + 1));
        sed -i "${lineno}i defer profile.Start(profile.CPUProfile).Stop()" $gofile;
        gofmt -w $gofile;
    fi;

    # Build the go file with the instrumentation code inserted
    go build -o $perftestbin $gofile;

    # Run the instrumented binary, which will write a pprof file to /tmp/profile... somewhere.
    # We grab the path reported and save it to a file
    # (so we don't need to start a bash sub-shell, which does not work with profiling)
    ./$perftestbin $p1 $p2 $p3 $p4 $p5 2>&1 > ${perftestbin}_output.log | grep -oP "/tmp/profile[0-9]*/cpu.pprof" | head -n 1 > $tmppprofpathfile

    # Get the temporary pprof file path into a variable and copy it to local folder
    tmppproffile=$(cat $tmppprofpathfile);
    echo "Found temporary pprof file in $tmppproffile";
    cp $tmppproffile $pproffile;

    # Generate the (cumulatively) slowest functions listing
    go tool pprof --text --functions --cum $perftestbin $pproffile > $slowfuncsfile;
    echo "Wrote the slowest (cumulative) functions to $slowfuncsfile ...";

    # Open up the slowest functions file in less
    less -S $slowfuncsfile
}

alias gobuildsmall='go build -ldflags "-s"'

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
alias dirsizes='{ for f in `find -maxdepth 1 -type d`; do du -sh "$f"; done; }|sort -h'
alias logmemusage='sar -r 1'

# --------------------------------------------------------------------------------
# Switch keyboard layout
# --------------------------------------------------------------------------------
alias kb='setxkbmap'
alias se='setxkbmap se'
us() {
    echo "Setting keyboard map to US";
    setxkbmap -layout us -option caps:escape;
    #xmodmap -e "remove Lock = Caps_Lock" # Gives an error message, so uncommented for now
    xmodmap -e 'keycode 108 = Mode_switch';
    xmodmap -e 'remove mod1 = Mode_switch';
    xmodmap -e 'keycode 34 = bracketleft braceleft aring Aring';
    xmodmap -e 'keycode 48 = apostrophe quotedbl adiaeresis Adiaeresis';
    xmodmap -e 'keycode 47 = semicolon colon odiaeresis Odiaeresis';
}
usoyster() {
    echo "Setting keyboard map to US, mapping ESC to CapsLock too, and doing fixes for the oyster keyboard";
    setxkbmap -layout us -option caps:escape;
    xmodmap -e "remove Lock = Caps_Lock"
    xmodmap -e 'keycode 108 = Mode_switch';
    xmodmap -e 'remove mod1 = Mode_switch';
    xmodmap -e 'keycode 34 = bracketleft braceleft aring Aring';
    xmodmap -e 'keycode 48 = apostrophe quotedbl adiaeresis Adiaeresis';
    xmodmap -e 'keycode 47 = semicolon colon odiaeresis Odiaeresis';
    # Specific for Oyster split keyboard
    xmodmap -e 'keycode 94 = Alt_L'
    xmodmap -e 'keycode 64 = Super_L'
    xmodmap -e 'clear mod1'
    #xmodmap -e 'add mod1 = Super_L'
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
alias ...='echo … | xsel --clipboard'
alias chnscc='cd ~/proj/farmbio/hnscc'
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
        echo "Please provide a bookmark name (will be prepended with 'c.'):";
        read name;
	else
		name=$1;
    fi
    dir=$(pwd);
    echo "alias c.$name='c $dir'" >> ~/.bash_aliases_local
    source ~/.bash_aliases_local
}
alias bm='bookmarks'
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
alias col="awk -F'\t' '{ print \$1 \"\t\" \$2 \"\t\" \$3 \"\t\" \$4 \"\t\" \$5 \"\t\" \$6 \"\t\" \$7 \"\t\" \$8 \"\t\" \$9 }'"
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

Image commands:
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

Container commands:
    attach    Attach to a running container
    commit    Create a new image from a container's changes
    cp        Copy files/folders from the containers filesystem to the host path
    diff      Inspect changes on a container's filesystem
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
alias fixbrokendesktop='rm -rf ~/.cache/sessions'
alias godate='echo "Mon Jan 2 15:04:05 -0700 MST 2006"'
alias mapesctocapslock='/usr/bin/setxkbmap -option "caps:escape"'
alias fixoysterkb="xmodmap -e 'keysym 0x3c = Alt_L'" # Find out hex codes for keys with the xev command
alias fsqli='fsql -interactive'
alias ct='column -t'
alias compiletex='latexmk -pdf -pdflatex="pdflatex --shell-escape" -pvc'
alias t1='tree -L 1'
alias t2='tree -L 2'
alias t3='tree -L 3'
alias t4='tree -L 4'
alias t5='tree -L 5'
alias t6='tree -L 6'
alias t7='tree -L 7'
function colt() {
    column -t $1 | less -Sri
}

alias awkcsv="gawk -vFPAT='[^,]*|\"[^\"]*"
alias findlatest='find . -printf "%T@ %Tc %p\n" | sort -n'

function dot2pdf() {
    f=$1;
    dot -Tpdf $f -o ${f%.dot}.pdf
}
function stamp() {
    old=$1;
    pre=${old%.*};
    ext=${old#*.};
    stamp=$(date +%Y%m%d-%H%M%S);
    new=$pre"-"$stamp"."$ext;
    echo "Creating date-stamped file: $new ..."
    cp $old $new;
}

function cleanup-docker() {
    # remove exited containers:
    docker ps --filter status=dead --filter status=exited -aq | xargs -r sudo docker rm -v

    # remove unused images:
    docker images --no-trunc | grep '<none>' | awk '{ print $3 }' | xargs -r sudo docker rmi

    # remove unused volumes:
    sudo find '/var/lib/docker/volumes/' -mindepth 1 -maxdepth 1 -type d | grep -vFf <(
        docker ps -aq | xargs docker inspect | jq -r '.[] | .Mounts | .[] | .Name | select(.)'
    ) | xargs -r sudo rm -fr
}

function latexabbrvs() {
    texfile=$1;
    echo "\begin{itemize}";
    for a in $(grep -oP "[A-Z]{2,}?\s" $texfile | sort | uniq); do
        echo "    \item $a: ";
    done;
    echo "\end{itemize}"
}

alias mergepdfs='echo "Usage: pdftk file1.pdf file2.pdf cat output mergedfile.pdf"'

# Vim Wiki stuff
alias w='f; cd wiki;'
alias wt='j; cd wiki; { echo "## Wiki"; echo; for f in $(ls | sed "s/.md//"); do echo "- [${f^}]($f)"; done } > index.md; git pull --rebase; typora index.md; git add *.md; git commit -m "Update wiki" *; git push;'
alias wv='j; cd wiki; { echo "## Wiki"; echo; for f in $(ls | sed "s/.md//"); do echo "- [${f^}]($f)"; done } > index.md; git pull --rebase; vim index.md; git add *.md; git commit -m "Update wiki" *; git push;'
alias ellipsis='echo …'

function pdf_to_png() {
    f=$1;
    p=$2;
    pdftoppm $f ${f%.pdf}-p$p -png -f $p -singlefile -ry 64 -rx 64
}
function pdfp1_to_png() {
    f=$1;
    pdftoppm $f ${f%.pdf} -png -f 1 -singlefile -ry 64 -rx 64
}
function pdfp1_to_png_large() {
    f=$1;
    pdftoppm $f ${f%.pdf} -png -f 1 -singlefile -ry 150 -rx 150
}
function pdfp1_to_png_200dpi() {
    f=$1;
    pdftoppm $f ${f%.pdf} -png -f 1 -singlefile -ry 200 -rx 200
}

alias ad='ansible-doc'
function ads() {
    plugin=$1;
    ansible-doc $plugin | s;
}
alias adl='ansible-doc -l'
alias adls='ansible-doc -l | s'
alias py=python

findlike() {
    likewhat=$1
    find -name "*$likewhat*"
}

alias update-display='eval $(tmux showenv -s DISPLAY)'

alias cleantex='rm *.{aux,bbl,blg,out,fls,log,fdb_latexmk}'
function png2ico() {
    convert \
        $1 \
        -flatten -colors 256 \
        -background transparent \
        $2;
}

function extractpdfpages() {
    pdffile=$1
    p1=$2
    p2=$3
    outfile=$4
    if [[ $pdffile == '' || $p1 == '' || $p2 == '' || $outfile == '' ]]; then
        echo "Usage: extractpdfpages PDFFILE P1 P2 OUTFILE";
        return;
    fi;
    pdftk $pdffile cat $p1-$p2 output $4
}

alias cr='crystal'

alias ts.cli='tmux split-pane -v -p 20'

alias jn='jupyter notebook'
alias go2='~/go2/bin/go tool go2go'
alias encrypt-file='gpg -c'
alias decrypt-file='gpg'
alias dfh='df -h'

function filedate() {
    stat $1 | grep Modify | grep -oP "20[0-9][0-9]\-[0-9][0-9]\-[0-9][0-9]\ [0-9][0-9]:[0-9][0-9]:[0-9][0-9]" | sed 's/ /-/' | sed 's/://g'
}
function fit2gpx() {
    f=$1;
    gpsbabel -i garmin_fit -o gpx -f $f -F ${f%.fit}.gpx;
}

alias pypi-release='rm -rf dist build & python -m build -s -w . && python -m twine upload dist/*'

alias cleanlatex='rm *.{blg,bbl,aux,log}'
function buildlatex() {
    if [[ -z $1 ]]; then
        echo "Usage: buildlatex somefile.tex";
        return;
    fi;
    texfile=$1;
    pdflatex $texfile \
        && bibtex ${texfile%.tex}.aux \
        && pdflatex $texfile \
        && pdflatex $texfile;
}

alias emf2png='libreoffice --headless --convert-to png '
alias clean-epub-html="sed -r 's/<[/]?(span|div)[^>]*>//g' | sed -r 's/<p[^>]*>/<p>/g' | grep -oP '<p.*' | sed -r 's/([a-zåäö])-([a-zåäö])/\1\2/g'"
function fixres() {
	modeline=$(cvt 2560 1080 60 | tail -n 1 | cut -d" " -f 2-)
	mode=$(echo $modeline | cut -d" " -f 1)
	echo "Mode: $mode, Mode Line: $modeline"
	echo "Now adding new mode ..."
	xrandr --newmode $modeline
	echo "Now trying to add mode ..."
	xrandr --addmode HDMI-1 $mode
    xrandr --output HDMI-1 --mode $mode
    # Turn off laptop screen
    xrandr --output eDP-1 --off
}

alias pip-install-local='pip install -e'

alias ipypdb='ipython --pdb'

alias cleanswp="find -name '*.swp' | xargs rm"

# Open multiple files side-by-side
alias vim='vim -O'

alias sq3=sqlite3

alias ki='touch .kopiaignore'

function update_garmin() {
    cd /media/$USER/GARMIN/GARMIN/REMOTESW
    rm -f EPO.BIN.OLD
    mv EPO.BIN{,.OLD}
    echo "Updating Garmin EPO.BIN ..."
    wget https://github.com/StevenMaude/epo-bin/raw/epo-bin/EPO.BIN
    echo "Done!"
}
alias brave8181='brave-browser --proxy-server="socks5://localhost:8181"'

function git_creation_date() {
    git log --follow --format=%ad --date default $1 | tail -1
}

alias capitalize='python3 -c "import sys; print(sys.stdin.read().title())"'
