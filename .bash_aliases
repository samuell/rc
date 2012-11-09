alias ll='ls -l'
alias l='git log --pretty=oneline|tig'
alias d='git diff|tig'
alias c='git commit'
alias p='git push'
alias po='git push origin'
alias pokd='git push origin kali-dev'
alias b='git branch'
alias pyh='pyh'
alias brc='vim ~/.bashrc; source ~/.bashrc'

cythonize() {
        cython --embed $1.py
            gcc -I/usr/include/python2.7 -o $1 $1.c -lpython2.7
}

alias ppjson='python -c "import sys, json; print json.dumps(
json.load(sys.stdin), sort_keys=True, indent=4)"'
