# Source this file in ~/.zshrc to use the functions

## Aliases

alias myip="curl http://ipecho.net/plain; echo"


## Functions
function host_grep {
    grep -A1 $1 ~/.ssh/config
}

function search_port {
    lsof -i -P | grep $@
}


# function Extract for common file formats
# Obtained from here: https://github.com/xvoland/Extract/blob/master/extract.sh
function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
 else
    if [ -f "$1" ] ; then
        NAME=${1%.*}
        #mkdir $NAME && cd $NAME
        case "$1" in
          *.tar.bz2)   tar xvjf ./"$1"    ;;
          *.tar.gz)    tar xvzf ./"$1"    ;;
          *.tar.xz)    tar xvJf ./"$1"    ;;
          *.lzma)      unlzma ./"$1"      ;;
          *.bz2)       bunzip2 ./"$1"     ;;
          *.rar)       unrar x -ad ./"$1" ;;
          *.gz)        gunzip ./"$1"      ;;
          *.tar)       tar xvf ./"$1"     ;;
          *.tbz2)      tar xvjf ./"$1"    ;;
          *.tgz)       tar xvzf ./"$1"    ;;
          *.zip)       unzip ./"$1"       ;;
          *.Z)         uncompress ./"$1"  ;;
          *.7z)        7z x ./"$1"        ;;
          *.xz)        unxz ./"$1"        ;;
          *.exe)       cabextract ./"$1"  ;;
          *)           echo "extract: '$1' - unknown archive method" ;;
        esac
    else
        echo "'$1' - file does not exist"
    fi
fi
}

function cmd_stats {
    history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n10
}


function setjdk() {
    export JAVA_HOME=$(/usr/libexec/java_home -v $1)
}


# DESCRIPTION:
#   * h highlights with color specified keywords when you invoke it via pipe
#   * h is just a tiny wrapper around the powerful 'ack' (or 'ack-grep'). you need 'ack' installed to use h. ack website: http://beyondgrep.com/
# INSTALL:
#   * put something like this in your .bashrc:
#     . /path/to/h.sh
#   * or just copy and paste the function in your .bashrc
# TEST ME:
#   * try to invoke:
#     echo "abcdefghijklmnopqrstuvxywz" | h   a b c d e f g h i j k l
# GITHUB
#   * https://github.com/paoloantinori/hhighlighter

h() {

    _usage() {
	echo "usage: YOUR_COMMAND | h [-idn] args...
	-i : ignore case
	-d : disable regexp
	-n : invert colors"
    }

    local _OPTS

    # detect pipe or tty
    if test -t 0; then
	_usage
	return
    fi

    # manage flags
    while getopts ":idnQ" opt; do
	case $opt in
	    i) _OPTS+=" -i " ;;
	    d)  _OPTS+=" -Q " ;;
	    n) n_flag=true ;;
	    Q)  _OPTS+=" -Q " ;;
	    # let's keep hidden compatibility with -Q for original ack users
	    \?) _usage
		return ;;
	esac
    done

    shift $(($OPTIND - 1))

    # check maximum allowed input
    if (( ${#@} > 12)); then
	echo "Too many terms. h supports a maximum of 12 groups. Consider relying on regular expression supported patterns like \"word1\\|word2\""
	exit -1
    fi;

    # set zsh compatibility
    [[ -n $ZSH_VERSION ]] && setopt localoptions && setopt ksharrays && setopt ignorebraces

    local _i=0

    if [ -z $n_flag ]; then
	#inverted-colors-last scheme
	_COLORS=( "underline bold red" "underline bold green" "underline bold yellow" "underline bold blue" "underline bold magenta" "underline bold cyan" "bold on_red" "bold on_green" "bold black on_yellow" "bold on_blue" "bold on_cyan" "bold on_magenta" )
    else
	#inverted-colors-first scheme
	_COLORS=( "bold on_red" "bold on_green" "bold black on_yellow" "bold on_blue" "bold on_magenta" "bold on_cyan" "bold black on_white" "underline bold red" "underline bold green" "underline bold yellow" "underline bold blue" "underline bold magenta" )
    fi

    local ACK=ack
    if ! which $ACK >/dev/null 2>&1; then
	ACK=ack-grep
	if ! which $ACK >/dev/null 2>&1; then
	    echo "Could not find ack or ack-grep"
	    exit -1
	fi
    fi

    # build the filtering command
    for keyword in "$@"
    do
	local _COMMAND=$_COMMAND"$ACK $_OPTS --noenv --flush --passthru --color --color-match=\"${_COLORS[$_i]}\" '$keyword' |"
	_i=$_i+1
    done
    #trim ending pipe
    _COMMAND=${_COMMAND%?}
    #echo "$_COMMAND"
    cat - | eval $_COMMAND
}
