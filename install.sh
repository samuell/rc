#!/bin/bash
cd ~
ln -sr rc/.??* .
touch ~/.bash_aliases_local

if [[ -z $(grep bashrc_mods ~/.bashrc) ]]; then
    echo 'if [[ -f ~/.bashrc_mods ]]; then' >> ~/.bashrc
    echo '    source ~/.bashrc_mods;' >> ~/.bashrc
    echo 'fi;' >> ~/.bashrc
else
    echo "~/.bashrc_mods already linked from ~/.bashrc so skipping!"
fi

# Install some essential utilities
sudo apt install git tig tmux neovim tree htop
