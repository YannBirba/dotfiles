#!/bin/bash

alias zshconfig="code ~/.zshrc"
alias aliasconfig="code ~/.bash_aliases"
alias ls="exa -l -g -a -m -h --icons"
alias lst="exa -l -g -a -m -h -1 --icons --tree"
alias pn=pnpm
alias batcat=bat
alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
alias c="clear"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias cdd="cd ~/dev"
alias reload="exec zsh"
alias g="git"
alias md="mkdir -pv"
alias cp='cp -vi'
alias ln='ln -vi'
alias update="sudo apt update && sudo apt upgrade -y"
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias ssl='openssl req -nodes -newkey rsa:2048 -keyout example.key -out example.csr -subj "/C=GB/ST=London/L=London/O=Global Security/OU=IT Department/CN=example.com"'
alias h='history'
alias js='jobs -l'
alias headers='curl -I --insecure'
alias api='curl -i -X GET -H "Accept: application/json" -H "Content-Type: application/json" --insecure'
alias apiheaders='curl -I -X GET -H "Accept: application/json" -H "Content-Type: application/json" --insecure'
alias cv="curl -v"
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
alias apt='sudo apt'
alias cpv='rsync -ah --info=progress2'
alias rm="rm -rif"
alias trash='echo "\nMoving files to ~/.trash ...\n" && mv -ft ~/.trash'
alias trashlist="ls ~/.trash"
alias cleartrash="rm ~/.trash/*"
alias t="trash"
alias tl="trashlist"
alias ct="cleartrash"
alias ainstall='sudo apt install'
alias aremove='sudo apt remove'
alias ai='ainstall'
alias ar='aremove'
alias ssa="service --status-all"
alias dsp="docker system prune -f -a --volumes"
alias tar='tar -czvf'
alias untar='tar -zxvf'
alias gs='git status'
alias gr='git remote -v'
alias pmain='git push origin main'
alias pdev='git push origin dev'
alias findfile="l | grep -i"
alias findhistory="history | grep -i"
alias untracked="git ls-files . --others --exclude-standard  --others"
alias n="node"
alias nv="node -v"
alias dev="pn dev"
alias build="pn build"
alias start="pn start"
alias test="pn test"
alias lint="pn lint"
alias format="pn format"
alias fix="pn fix"
alias showlog="tail -f"
alias sl="showlog"
alias go="j"
alias goc="jc"

function createreact() {
    if ! pn create vite@latest "$1" --template react-swc-ts; then
        echo "Error: pn create vite@latest $1 --template react-swc-ts failed"
        return 1
    fi
    if ! cd "$1"; then
        echo "Error: cd $1 failed"
        return 1
    fi
    if ! pn i; then
        echo "Error: pnpm install failed"
        return 1
    fi
    if ! pn up --latest; then
        echo "Error: pnpm up --latest failed"
        return 1
    fi
    if ! code .; then
        echo "Error: code . failed"
        return 1
    fi
    printf "\n"
    echo "Success: Created React project $1"
    return 0
}
