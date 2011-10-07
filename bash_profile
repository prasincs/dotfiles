export TERM="xterm-color"
alias ls="ls -G"
PS1="\[\033[01;32m\]\u@\h\[\033[01;34m\] \W \$\[\033[00m\] "
export PATH=$HOME/bin:/usr/local/play-1.2.3:usr/local/bin:/usr/local/share/python:$PATH
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
source /usr/local/share/python/virtualenvwrapper.sh
source $HOME/.bashrc_prasanna
