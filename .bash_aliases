alias editalias='vim ~/.bash_aliases; source ~/.bash_aliases'
alias hej='echo "Hej!" > hej.txt'
alias brc='vim ~/.bashrc; source ~/.bashrc'
alias ba='vim ~/.bash_aliases;source ~/.bash_aliases'
alias ll='ls -l'
alias l='git log --pretty=oneline|tig'
alias d='git diff|tig'
alias c='git commit'
alias p='git push'
alias gitpp='git pull; git push;'
alias po='git push origin'
alias pom='git push origin master'
alias b='git branch'
alias sublime='/home/samuel/opt/sublime/sublime_text'
galaxy_uppmax() {
    ssh -L 8181:localhost:34598 kalkyl.uppmax.uu.se 'ssh -t -t -L 34598:localhost:8080 $1 "sh /home/samuel/opt/galaxy/run.sh"'
}
alias switchjava='sudo update-alternatives --config java'
topname() {
    top -p $(pgrep -d"," $1);
}
alias py='python'
mkcd() {
    mkdir $1;
    cd $1;
}
alias ..='cd ..'
alias ....='cd ../..'
alias ......='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias apt-get='sudo apt-get'
alias inst='apt-get install'
alias h='history'

## pass options to free ## 
alias meminfo='free -m -l -t'
 
## get top process eating memory
 alias psmem='ps auxf | sort -nr -k 4'
 alias psmem10='ps auxf | sort -nr -k 4 | head -10'
  
## get top process eating cpu ##
  alias pscpu='ps auxf | sort -nr -k 3'
  alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
   
## Get server cpu info ##
   alias cpuinfo='lscpu'

alias cdgtools='cd /home/samuel/opt/galaxy/tools'
