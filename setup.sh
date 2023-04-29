<<<<<<< HEAD
#!/bin/sh

#### adapted from https://github.com/mackiedrew/linux-setup-script/blob/master/setup.sh


#### Gather User Data ####
echo -n 'Enter your GIT name: '
read git_name
echo -n 'Enter your GIT email: '
read git_email
echo -n 'Enter your GitHub username: '
read git_user

#### Housekeeping ####
cwd=$(pwd)

apt-get update
apt-get install -f
source ~/.bashrc

#### Power ####
# gsettings set org.cinnamon.settings-daemon.plugins.power time-critical 900
# gsettings set org.cinnamon.settings-daemon.plugins.power percentage-critical 10

#### Text Editors ####
apt-get install -y vim
apt-get install -f
apt-get install -y rsync
apt-get install -f
apt-get install -y wget
apt-get install -f
apt-get install -y python3-pip
apt-get install -f
apt-get install -y yt-dlp
apt-get install -f


#### GIT ####
apt-get install -y git
apt-get install -fy
git config --global user.name $git_name
git config --global user.email $git_email
git config --global user.name $git_user
git config --global push.default matching
git config --global core.editor "vim"

#### Programs



#### Install Gitter ####
# wget -c https://update.gitter.im/linux64/gitter_3.1.0_amd64.deb
# dpkg -i gitter_3.1.0_amd64.deb
# rm gitter*.deb
# cd $cwd

#### JavaScript ####
# apt-get install -y npm
# apt-get install -f
# apt-get install -y nodejs
# apt-get install -f
# ln -s /usr/bin/nodejs /usr/bin/node
# apt-get install -y gulp

#### NPM Modules ####
# npm i -g yarn
# npm i -g gulp
# npm i -g eslint
# npm i -g eslint-plugin-babel
# npm i -g babel-eslint
# npm i -g eslint-config-airbnb
# npm i -g eslint-plugin-jsx-a11y
# npm i -g eslint-plugin-react
# npm i -g eslint-plugin-import
# npm i -g create-react-app

#### Node School ####
# ./node_school.sh

#### Insttall Meteor ####
# curl https://install.meteor.com/ | sh

#### Python Install ####
# apt-get install -y python3-pip
# apt-get install -f
# apt-get install -y python3-venv
# apt-get install -f

#### Graphics Tools ####
# apt-get install -y inkscape
# apt-get install -f
# apt-get install -y gimp
# apt-get install -f

#### Install Anki ####
# wget -c https://apps.ankiweb.net/downloads/current/anki-2.0.39-amd64.tar.bz2
# tar xjf anki-2.0.39-amd64.tar.bz2
# cd anki-2.0.39
# sudo make install
# cd ..
# rm -r ./anki*
# cd $cwd
# apt-get install -f

#### Install Slack ####
# wget -c https://downloads.slack-edge.com/linux_releases/slack-desktop-2.4.2-amd64.deb
# dpkg -i slack-desktop-2.4.2-amd64.deb
# rm slack*.deb
# cd $cwd

#### Easy Installs ####
# apt-get install -y xclip
# apt-get install -f
# apt-get install -y trash-cli
# apt-get install -f
# apt-get install -y vlc-nox
# apt-get install -f
# apt-get install -y audacity
# apt-get install -f
# apt-get install -y gparted
# apt-get install -f
# apt-get install -y p7zip-full
# apt-get install -f

#### Configure Backup ####
# apt-get install -y rsync
# apt-get install -f
# echo "rsync -zrvh ~/../ /media/mackie/Home\ Backup" >> ~/.bashrc

#### Virtual Machine ####
# apt-get install -y virtualbox
# apt-get install -f
# apt-get install -y virtualbox-qt
# apt-get install -f

#### Setup Aliases ####
# cd $cwd
# cp -v -f ./aliases.txt ~/
# mv ~/aliases.txt ~/.aliases
# echo "source ~/.aliases" >> ~/.bashrc
# source ~/.bashrc

#### Change Bash Prompt ####
# echo "export PS1=\"\[\033[38;5;26m\]⛴  \[\033[38;5;254m\]\w\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\] > \[$(tput sgr0)\]\"" >> ~/.bashrc
# source ~/.bashrc
=======
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
>>>>>>> 54a3e9568e54060f45e2664aa6d027a2df41d8c8
