export PATH=~/bin:$PATH
export PATH=~/scripts:$PATH
export PATH=~/opt/bpipe/bin:$PATH
export PATH=~/opt/liteide/bin:$PATH

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

# PyEnv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export PS1="[\u \W]$ "
