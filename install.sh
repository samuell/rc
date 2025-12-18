#!/bin/bash
echo "--------------------------------------------------------------------------------"
echo "Linking dotfiles ..."
echo "--------------------------------------------------------------------------------"
cd ~
ln -sr rc/.??* .
touch ~/.bash_aliases_local

echo "--------------------------------------------------------------------------------"
echo "Linking ~/.bashrc_mods file ..."
echo "--------------------------------------------------------------------------------"
if [[ -z $(grep bashrc_mods ~/.bashrc) ]]; then
    echo 'if [[ -f ~/.bashrc_mods ]]; then' >> ~/.bashrc
    echo '    source ~/.bashrc_mods;' >> ~/.bashrc
    echo 'fi;' >> ~/.bashrc
else
    echo "~/.bashrc_mods already linked from ~/.bashrc so skipping!"
fi

echo "--------------------------------------------------------------------------------"
echo "Sourcing ~/.bashrc ..."
echo "--------------------------------------------------------------------------------"
source ~/.bashrc

# Install some essential utilities
echo "--------------------------------------------------------------------------------"
echo "Installing apt packages ..."
echo "--------------------------------------------------------------------------------"
sudo apt install git tig tmux tree htop bash-completion wget fuse3 rsync unzip

echo "--------------------------------------------------------------------------------"
echo "Installing NeoVim as AppImage ..."
echo "--------------------------------------------------------------------------------"
if [[ ! -f ~/bin/nvim ]]; then
    mkdir -p ~/bin
    cd ~/bin && wget https://github.com/neovim/neovim/releases/download/v0.11.5/nvim-linux-x86_64.appimage
    mv nvim-linux-x86_64.appimage nvim
    chmod u+x nvim
fi

echo "--------------------------------------------------------------------------------"
echo "Installing vim plug ..."
echo "--------------------------------------------------------------------------------"
autoload_dir=~/.config/nvim/autoload
if [[ ! -f ${autoload_dir}/plug.vim ]]; then
    mkdir -p ${autoload_dir}
    cd ${autoload_dir} && https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
    echo "vim.plug already installed, so skipping!"
fi
