# aliases
alias a=alias
alias cl=clion
alias cx='chmod a+x'
alias h=history
alias la='ls -a'
alias ll='ls -l'
alias l='ls -F'
alias po=popd
alias pu=pushd
alias vf=cd
# I cannot type
alias xrags=xargs
alias gti=git


# visual diff (is on mac and linux)
alias vdiff=gvimdiff

alias fin='find . -type f -print  | fgrep -v /.git/ | fgrep -v .class | fgrep -v /.m2/ > xref.all'

alias git_head='git symbolic-ref --short HEAD'

# git log with subject only (git log--pretty=oneine has hash)
alias git1='git log --pretty=%s --no-decorate'

alias exgrep='grep -I --exclude-dir=.git --exclude-dir=.m2 --exclude-dir=target --exclude=*.tgz --exclude=*.class --exclude=*.jar --exclude-dir=testdata --exclude-dir=toolchain --exclude-dir=.idea'

# https://unix.stackexchange.com/questions/85249/why-not-use-which-what-to-use-then
alias which='command -v'

# https://stackoverflow.com/questions/30247603
alias amend='VISUAL="gvim -f" git commit --amend'
# sublime text
alias samend='VISUAL="subl -w" git commit --amend'

# alias vvb='vncserver -geometry 1900x1050  :1'
# alias vv='vncserver -geometry 1900x1000  :1'
alias vvlenovo='vncserver -geometry 1300x680 :1'
alias vvmac='vncserver -geometry 2500x1460 :3'
alias vvmacconsole='vncserver -geometry 1650x940 :2'
# alias ff='/scratch/apsherma/bin/firefox/firefox'

alias unsethttp='unset http_proxy ; unset https_proxy'

# make patch as described in https://wiki.cloudera.com/display/~vihang/Hive+Developer+Environment+Setup
alias make_patch='git show --full-index --no-prefix'

# get aws creds per https://wiki.cloudera.com/pages/viewpage.action?pageId=68501666
alias get_aws='source <(ssh -o "StrictHostKeyChecking=no" s3@cloudcat.infra.cloudera.com impaladev --style env); export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN;'

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
export HISTCONTROL=ignoredups
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

