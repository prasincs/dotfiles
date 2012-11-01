#!/bin/bash
DIR=$(cd $(dirname $0) && pwd )

function check_arg_num {
  if [ $1 -ne $2 ]; then
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


link_file zsh/zshrc $HOME/.zshrc
link_dir xmonad $HOME/.xmonad
