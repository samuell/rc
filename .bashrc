export PATH=~/bin:$PATH
export PATH=~/scripts:$PATH
export PATH=~/opt/bpipe/bin:$PATH

HISTFILESIZE=10000

if [[ $SHELL = "/bin/bash" ]]; then
	source /etc/bash_completion;
fi;
source ~/.bashrc_local;
source ~/.bash_aliases;
source ~/.bash_aliases_local;

export GOROOT=~/opt/go
export GOPATH=~/code/go
export PATH=~/opt/go/bin:$PATH
export PATH=~/go/bin:$PATH
