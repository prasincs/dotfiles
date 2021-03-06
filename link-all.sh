#!/bin/bash
DIR=$(cd $(dirname $0) && pwd )

function check_arg_num {
  if [ ! "$1" = "$2" ]; then
    echo "Need 2 args";
    exit
  fi

}

function link_file {
  check_arg_num $# 2
  if [ ! -L $2 ]; then
    ln -s $DIR/$1 $2
  else
    echo "$2 already exists... not linking"
  fi
}

function link_dir {
  check_arg_num $# 2
  if [ ! -d $2 ]; then
    ln -s $DIR/$1 $2
  else
    echo "$2 already exists.. not linking"
  fi
}

if []


ln -s $DIR/tmux/tmux.conf $HOME/.tmux.conf
ln -s $DIR/tmux/tmux.shared $HOME/.tmux.shared
link_file zsh/zshrc $HOME/.zshrc
#link_dir xmonad $HOME/.xmonad
#link_dir irssi $HOME/.irssi
#link_file xsession $HOME/.xsession
#link_file emacs $HOME/.emacs
link_file gitconfig $HOME/.gitconfig
link_file gitignore_global $HOME/.gitignore_global
for f in `ls $DIR/bin/*`; do
  echo $f
  ln -s $f $HOME/bin/$(basename $f)
done
