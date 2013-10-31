# setting
autoload -Uz compinit
compinit

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
 
# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..
   
# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                      /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# complete process name
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'


# prompt

#PROMPT=" %{${fg[yellow]}%}%~%{${reset_color}%}
#%1(v|%F{green}%1v%f|) 
#[%n] $ "
#PROMPT2='[%n]> '


autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [ -n "$vcs_info_msg_0_" ] && psvar[1]="$vcs_info_msg_0_"
}
#RPROMPT="%1(v|%F{green}%1v%f|)"
#RPROMPT="%F{038}[%f%F{077}%1(v|%1v |)%f%F{038}%~]%f"

# git：まだpushしていないcommitあるかチェックする
my_git_info_push () {
    if [ "$(git remote 2>/dev/null)" != "" ]; then
	local head="$(git rev-parse HEAD)"
local remote
for remote in $(git rev-parse --remotes) ; do
    if [ "$head" = "$remote" ]; then return 0 ; fi
    done
# pushしていないcommitがあることを示す文字列
echo "<P>"
fi
}

# git：stashに退避したものがあるかチェックする
my_git_info_stash () {
    if [ "$(git stash list 2>/dev/null)" != "" ]; then
# stashがあることを示す文字列
echo "{s}"
fi
}

# vcs_infoの出力に独自の出力を付加する
my_vcs_info () {
vcs_info
echo $(my_git_info_stash)$(my_git_info_push)$vcs_info_msg_0_
}

setopt prompt_subst
RPROMPT=$'$(my_vcs_info)'



# history
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000
setopt extended_history
setopt share_history
setopt hist_ignore_dups
function history-all { history -E 1}

# terminal title
case "${TERM}" in
kterm*|xterm)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST}\007"
    }
    ;;
esac 

setopt print_eight_bit

# color setting
autoload -Uz colors
colors
export LSCOLORS=gxfxxxxxcxxxxxxxxxgxgx
export LS_COLORS='di=01;36:ln=01;35:ex=01;32'
zstyle ':completion:*' list-colors 'di=37' 'ln=35' 'ex=32'

# prompt
PROMPT="%{${fg[yellow]}%}[%n@%m]%{${reset_color}%} %~
%# "


setopt prompt_subst
RPROMPT=$'%{${fg[green]}%}$(my_vcs_info)%{${reset_color}%}'

# alias
alias history='history-all'

