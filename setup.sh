#!/bin/bash

ln -s ~/tot/vim ~/.vim
ln -s ~/tot/inputrc ~/.inputrc
ln -s ~/tot/ideavimrc  ~/.ideavimrc
ln -s ~/tot/bash_profile ~/.bash_profile
ln -s ~/tot/zshrc ~/.zshrc
ln -s ~/tot/tmux.conf ~/.tmux.conf
ln -s ~/tot/vscodesettings.json ~/.vscodesettings.json

echo "Aliases created"

source ~/.bash_profile

echo "Profile sourced"
