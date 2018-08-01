# aliases
alias ll='ls -l'
alias la='ls -a'
alias l='ls -F'
alias h=history
alias pu=pushd
alias po=popd
alias a=alias
alias cx='chmod a+x'
alias fin='find . -type f -print  | fgrep -v /.git/ | fgrep -v .class | fgrep -v /.m2/ > xref.all'
alias vf=cd
alias xrags=xargs

alias git_head='git symbolic-ref --short HEAD'

alias exgrep='grep -I --exclude-dir=.git --exclude-dir=.m2 --exclude-dir=target --exclude=*.tgz --exclude=*.class --exclude=*.jar --exclude-dir=testdata --exclude-dir=toolchain'

# alias vvbtlinux43='vncserver -geometry 1450x980 :2'
# alias vvb='vncserver -geometry 1900x1050  :1'
# alias vv='vncserver -geometry 1900x1000  :1'
alias vvlenovo='vncserver -geometry 1300x680 :3'
alias vvmac='vncserver -geometry 2500x1460 :3'
# alias ff='/scratch/apsherma/bin/firefox/firefox'

alias unsethttp='unset http_proxy ; unset https_proxy'

# needs bash v4
# https://superuser.com/questions/857250/how-to-update-bash-on-mac-os-x-yosemite
PROMPT_DIRTRIM=3
# put pwd in prompt 
# https://www.gnu.org/software/bash/manual/html_node/Controlling-the-Prompt.html#Controlling-the-Prompt
PS1='[\w]\$ ' 


# Maximum number of history lines in memory
export HISTSIZE=50000
# Maximum number of history lines on disk
export HISTFILESIZE=50000
# Ignore duplicate lines
## export HISTCONTROL=ignoredups:erasedups
# When the shell exits, append to the history file 
#  instead of overwriting it
shopt -s histappend

export VISUAL=vi

# https://gist.github.com/phette23/5270658
# put this in your .bash_profile
## if [ $ITERM_SESSION_ID ]; then
##  export PROMPT_COMMAND='echo -ne "\033];${PWD##*/}\007"; ':"$PROMPT_COMMAND";
## fi
# Piece-by-Piece Explanation:
# the if condition makes sure we only screw with $PROMPT_COMMAND if we're in an iTerm environment
# iTerm happens to give each session a unique $ITERM_SESSION_ID we can use, $ITERM_PROFILE is an option too
# the $PROMPT_COMMAND environment variable is executed every time a command is run
# see: ss64.com/bash/syntax-prompt.html
# we want to update the iTerm tab title to reflect the current directory (not full path, which is too long)
# echo -ne "\033;foo\007" sets the current tab title to "foo"
# see: stackoverflow.com/questions/8823103/how-does-this-script-for-naming-iterm-tabs-work
# the two flags, -n = no trailing newline & -e = interpret backslashed characters, e.g. \033 is ESC, \007 is BEL
# see: ss64.com/bash/echo.html for echo documentation
# we set the title to ${PWD##*/} which is just the current dir, not full path
# see: stackoverflow.com/questions/1371261/get-current-directory-name-without-full-path-in-bash-script
# then we append the rest of $PROMPT_COMMAND so as not to remove what was already there
# voilà!


# https://superuser.com/questions/292652/change-iterm2-window-and-tab-titles-in-zsh
# $1 = type; 0 - both, 1 - tab, 2 - title
# rest = text
setTerminalText () {
    # echo works in bash & zsh
    local mode=$1 ; shift
    echo -ne "\033]$mode;$@\007"
}
stt_both  () { setTerminalText 0 $@; }
stt_tab   () { setTerminalText 1 $@; }
stt_title () { setTerminalText 2 $@; }
set_title () { setTerminalText 2 $@; }
# put set_title in machine .bashrc

