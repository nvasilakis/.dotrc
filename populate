#!/bin/bash

# Function used for debugging output
function e {
  echo "[Output] $1";
}

e 'generating key pair'
ssh-keygen -t rsa -f ~/.ssh/id_rsa -C `whoami`@`uname -n`
e '****************************************'
e 'please add the key NOW to github account'
e '****************************************'
cat ~/.ssh/id_rsa.pub
e '****************************************'
e 'adding pair to ssh agent'
ssh-add ~/.ssh/id_rsa

e 'checking for requirements'
if [ ! -f `which git` ] && [ ! -f `which curl` ]
then
	if [ -x /usr/bin/apt-get ]
	then
		e installing requiements...
		sudo apt-get install git-core curl
	else
		e could not install pre-requisites, please install them manually
		e required: git curl
		exit
	fi
else
	e requirements exist, proceeding to install phase...
fi

e 'Adding Configuration..'
git config --global user.name "nvasilakis"
git config --global user.email "nikos.ailo@gmail.com"
git config --global core.editor "vim"
git config --global color.diff "auto"
git config --global color.status "auto"
git config --global color.branch "auto"
git config --global color.interactive "auto"
git config --global diff.tool vimdiff
git config --global difftool.prompt false

if [ -d ~/.vim ]
then
e 'updating dotfiles...'
        cd ~/.vim
	git clone git@github.com:nvasilakis/immateriia.git .
else
	mkdir -p ~/.vim
e 'creating ~/.vim...'
        cd ~/.vim
	git clone git@github.com:nvasilakis/immateriia.git .
fi

FILES=".vimrc .bashrc .zshrc .irbrc .screenrc .ss .conkyrc" 
for i in $FILES; do 
        echo installing: ~/.vim/$i ~/$i
        rm -rf ~/$i
        ln -s ~/.vim/$i ~/$i
done

e 'installation complete'
e '*****************************************'
e '* update your remote servers by running:*'
e '* ssh-copy-id -i user@remotehost.smt    *'
e '*****************************************'

