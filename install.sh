#!/bin/sh

echo "Going to link up all the nice dot-files for you..."

CURRENT_DIR=$(pwd)

if [ -e ~/bin ] 
then
    unlink ~/bin
fi

if [ -e ~/img ] 
then
    unlink ~/img
fi

if [ ! -e ~/.lein ]
then
    mkdir ~/.lein
fi

if [ -e ~/.lein/profiles.clj ] 
then
    unlink ~/.lein/profiles.clj
fi

if [ -e ~/.zshrc ] 
then
    unlink ~/.zshrc
fi

if [ ! -e ~/.oh-my-zsh ]
then
    echo "You need to have OH-MY-ZSH installed to continue!"
    exit 300
fi

if [ ! -e ~/.config ]
then
    mkdir ~/.config
fi

if [ -e ~/.config/kitty ]
then
    mv ~/.config/kitty ~/.config/kitty-old
fi
#if [ -e ~/.emacs.d ] 
#then
#    unlink ~/.emacs.d
#fi
#if [ -e ~/.emacs.d.old ] 
#then
#    rm -r ~/.emacs.d.old
#fi
#if [ -e ~/.emacs.d ] 
#then
#    mv ~/.emacs.d ~/.emacs.d.old
#fi



ln -sv ${CURRENT_DIR}/kitty ~/.config/kitty
ln -sv ${CURRENT_DIR}/bin ~/bin
ln -sv ${CURRENT_DIR}/img ~/img
#ln -sv ${CURRENT_DIR}/.emacs.d ~/.emacs.d
ln -sv ${CURRENT_DIR}/.lein/profiles.clj ~/.lein/profiles.clj
ln -sv ${CURRENT_DIR}/git-template ~/.git-template
cp zsh-themes/ix.zsh-theme ~/.oh-my-zsh/themes

for file in .*
do
    if [[ ${file} != ".git" && ${file} != "." && ${file} != ".." && ${file} != ".emacs.d" && ${file} != ".lein" && ${file} != "zsh" ]]
    then	
	ln -svf ${CURRENT_DIR}/${file} ~/${file}
    fi
done

mkdir -p ~/.config/karabiner
cp karabiner.json ~/.config/karabiner

echo "# Here is where you put local customisations" > ~/.bashrc_workstation

echo "source ~/.bashrc"
source ~/.bashrc
