# aliases
alias ll='ls -l'
alias la='ls -a'
alias l='ls -F'
alias h=history
alias pu=pushd
alias po=popd
alias a=alias
alias cx='chmod a+x'
alias fin='find . -type f -print  | fgrep -v /.git/  > xref.all'

# alias vvbtlinux43='vncserver -geometry 1450x980 :2'
# alias vvb='vncserver -geometry 1900x1050  :1'
# alias vv='vncserver -geometry 1900x1000  :1'
alias vvlenovo='vncserver -geometry 1300x680 :3'
# alias ff='/scratch/apsherma/bin/firefox/firefox'

alias unsethttp='unset http_proxy ; unset https_proxy'

# needs bash v4
# https://superuser.com/questions/857250/how-to-update-bash-on-mac-os-x-yosemite
PROMPT_DIRTRIM=3
# put pwd in prompt 
# https://www.gnu.org/software/bash/manual/html_node/Controlling-the-Prompt.html#Controlling-the-Prompt
PS1='[\w]\$ ' 

