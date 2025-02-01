# migration from bash
[ -f ~/.bash_profile ] && source ~/.bash_profile

# history
HISTFILE=$ZDOTDIR/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_no_store
setopt hist_reduce_blanks
setopt share_history

export ZINIT_HOME="$HOME/.local/share/zinit/zinit.git"
### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

# zinit
# . "$ZDOTDIR/.zinit/bin/zinit.zsh"
. "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit load hlissner/zsh-autopair
zinit ice from"gh-r" as"command"
zinit load junegunn/fzf-bin
zinit ice from"gh-r" as"command" mv"powerline-go-* -> powerline-go"
zinit load justjanne/powerline-go
zinit load momo-lab/zsh-abbrev-alias
zinit load zsh-users/zsh-autosuggestions
zinit load zsh-users/zsh-completions
zinit load zsh-users/zsh-syntax-highlighting

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

autoload -U compinit
compinit -C

# powerline
if command -v powerline-go >/dev/null; then
    zmodload zsh/datetime

    function preexec() {
        __TIMER=$EPOCHREALTIME
    }

    function powerline_precmd() {
        local __ERRCODE=$?
        local __DURATION=0

        if [ -n "$__TIMER" ]; then
            local __ERT=$EPOCHREALTIME
            __DURATION="$((__ERT - ${__TIMER:-__ERT}))"
            __DURATION=${__DURATION%%.*} # floor
            unset __TIMER
        fi

        eval "$(powerline-go \
            -duration $__DURATION \
            -error $__ERRCODE \
            -eval \
            -modules ssh,cwd,perms,jobs,exit \
            -modules-right duration,git \
            -numeric-exit-codes \
            -path-aliases $'\~/Library/Mobile Documents/com~apple~CloudDocs=@iCloud' \
            -shell zsh \
        )"
    }

    function install_powerline_precmd() {
        for s in "${precmd_functions[@]}"
        do
            if [ "$s" = "powerline_precmd" ]; then
                return
            fi
        done
        precmd_functions+=(powerline_precmd)
    }

    if [ "$TERM" != "linux" ]; then
        install_powerline_precmd
    fi
fi

# abbrev-alias
abbrev-alias -g G='| grep --color=yes -Hn'
abbrev-alias -g F='| fzf'

# alias
alias sail='[ -f sail ] && bash sail || bash vendor/bin/sail'
alias ls='ls -G'
alias ll='ls -l'

# 上書き防止
alias cp="cp -i"
alias rm='rm -i'
alias mv='mv -i'

alias g="git"
alias gs="git status"
alias gf="git fetch"
alias ga="git add ."
alias gcm="git commit -m"
alias gp="git pull"
alias gpr="git pull --rebase"
alias gb="git branch"
alias gba="git branch -a"
alias gbm="git branch --merged"
alias gbnm="git branch --no-merged"
alias gc="git checkout"
alias gcb="git checkout -b"
alias gc-="git checkout -"
alias grs="git restore"
alias gl="git log"
alias glo="git log --oneline"
alias gps="git push"
alias gpsu="git symbolic-ref --short HEAD | tr -d "\n" | xargs -I@ git push -u origin @" #カレントブランチで `git push -u` を行う
alias gpst="git push origin --tags"
alias gss="git stash save"
alias gsa="git stash apply"
alias gsd="git stash drop"
alias gcp="git cherry-pick"
alias gcpc="git cherry-pick --continue"
alias gcpa="git cherry-pick --abort"
alias grb="git rebase"
alias grbc="git rebase --continue"
alias arba="git rebase --abort"

alias v="vim"
alias t="tig"

alias szp="source ~/.zsh/.zprofile"
alias szr="source ~/.zsh/.zshrc"
alias es='exec $SHELL -l'

alias pngq="pngquant --ext .png --force --speed 1"

alias bs="brew search"
alias bi="brew info"

alias ysb="yarn storybook"

alias ns="npm run start"
alias ys="yarn start"
alias ysb="yarn storybook"
alias yt="yarn test"
alias yb="yarn build"

alias d="docker"
alias dp="docker ps"
alias dpa="docker ps -a"
alias di="docker image"
alias dil="docker image ls"
alias dv="docker volume"
alias dvl="docker volume ls"
alias dc="docker compose"
alias dsp="docker system prune"
alias dcud="docker compose up -d"
alias dcst="docker compose start" 
alias dcsp="docker compose stop"
alias dcd="docker compose down"
alias dcl="docker compose logs"
alias dce="docker compose exec"


## mkdir & cd
function mkcd () { mkdir -p "$@" && eval cd "\"\$$#\""; }


# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

function __fuzzy_history()
{
    local _query
    local _command
    if (( $#BUFFER != 0 )); then
        _query="^$BUFFER"
    else
        _query=''
    fi
    _command=$(history -nr 1 | fzf --query="$_query")
    if [ -n "$_command" ]; then
        BUFFER=$_command
        zle accept-line
    fi
}
autoload -Uz __fuzzy_history
zle -N __fuzzy_history
bindkey '^r' __fuzzy_history

# nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# PATH
export PATH=/opt/homebrew/bin:$PATH
export PATH="/opt/homebrew/opt/php@8.3/bin:$PATH"
export PATH="/opt/homebrew/opt/php@8.3/sbin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/php@8.3/lib"
export CPPFLAGS="-I/opt/homebrew/opt/php@8.3/include"
# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
