# setting
autoload -U compinit
compinit

# color
autoload colors
colors

# prompt

PROMPT=" %{${fg[yellow]}%}%~%{${reset_color}%} 
[%n]$ "
PROMPT2='[%n]> '

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

# color setting
export LSCOLORS=gxfxxxxxcxxxxxxxxxgxgx
export LS_COLORS='di=01;36:ln=01;35:ex=01;32'
zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'ex=32'
