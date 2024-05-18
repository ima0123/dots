# Alias

alias k="kubectl"
alias h="helm"

alias tf="terraform"
alias a="ansible"
alias ap="ansible-playbook"

alias togit="cd $HOME/dev/git"

alias ls="eza --group-directories-first --icons=auto"
alias ll="eza  -l --group-directories-first --icons=auto"
alias la="eza -al --group-directories-first --icons=auto"

# diffをカラフルに
alias diff='colordiff'
alias less='less -R'
alias grep='grep --color=auto'

## Apps

### OBS
alias obs='open /Applications/OBS.app/Contents/MacOS/OBS --args -picture'


## Programming

alias sail='[ -f sail ] && bash sail || bash vendor/bin/sail'

## Salesforce CLI
SF_DISABLE_TELEMETRY=true
#eval $(sf autocomplete script zsh)


# Global alias
alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g S='| sed'
alias -g A='| awk'
alias -g W='| wc'

alias ssh='ssh -o ServerAliveInterval=60'

# HTMLファイルに張り付け用の、タブ、空白、< > の変換コマンド
alias htmlconv='sed -e "s/</\&lt;/g;s/>/\&gt;/g;s/\t/\&nbsp;\&nbsp;\&nbsp;\&nbsp;/g;s/\s/\&nbsp;/g" '


# Others & Old
alias e='emacs'
alias h='history'
alias ha='history-all'
alias screen='TERM=xterm screen'
alias vi='vim'
alias s='screen -U'


# pop command
alias pd='popd'
alias gd='dirs -v; echo -n "select number: ";
read newdir; cd +"$newdir" '


# alias Cでクリップボードコピー
if which pbcopy > /dev/null 2>&1 ; then
   #Mac
   alias -g C='| pbcopy'
elif which xsel > /dev/null 2>&1 ; then
   #Linux
   alias -g C='| xsel --input --clipboard'
fi


alias bu='brew update; brew upgrade; brew upgrade --cask --greedy; brew cleanup'
