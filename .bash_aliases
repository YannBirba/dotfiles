#!/bin/bash

alias zshconfig="code ~/.zshrc"
alias aliasconfig="code ~/.bash_aliases"
alias ls="eza -l -g -a -m -h --icons"
alias lst="eza -l -g -a -m -h -1 --icons --tree"
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
alias star='tar -czvf'
alias suntar='tar -zxvf'
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
alias clean="pn clean"
alias fix="pn fix"
alias showlog="tail -f"
alias sl="showlog"
alias go="j"
alias goc="jc"
alias pm="pm2"
alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'

function ssl() {
    openssl req -nodes -newkey rsa:2048 -keyout "$1"-key.pem -out "$1"-cert.csr -subj "/C=FR/ST=Auvergne-Rhône-Alpes/L=Saint-Etienne/O=Yann Birba/OU=Development/CN=yannbirba.fr"
}

function local-ssl() {
    openssl req -nodes -newkey rsa:2048 -keyout "$1"-key.pem -out "$1"-cert.csr -subj "/C=FR/ST=Auvergne-Rhône-Alpes/L=Saint-Etienne/O=Yann Birba/OU=Development/CN=localhost"
}

function create:react() {
    if [ -z "$1" ]; then
        echo "Error: Please provide a name for the project"
        return 1
    fi
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
    if ! git init; then
        echo "Error: git init failed"
        return 1
    fi
    if ! git add .; then
        echo "Error: git add . failed"
        return 1
    fi
    if ! git commit -m "feat:create app"; then
        echo "Error: git commit -m 'feat:create app' failed"
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

function pm:start:npm() {
    if [ -z "$1" ]; then
        echo "Error: Please provide a name for the process"
        return 1
    fi
    if ! pm2 start pnpm --name "$1" --watch --ignore-watch="node_modules" --time --interpreter bash -- start; then
        echo "Error: pm2 start pnpm --name $1 --interpreter bash -- start failed"
        return 1
    fi
    if ! pm2 save; then
        echo "Error: pm2 save failed"
        return 1
    fi
    pm2 startup
    printf "\n"
    echo "Success: Started $1"
    return 0
}

function pm:start:config() {
    if [ -z "$1" ]; then
        echo "Error: Please provide a name for the process"
        return 1
    fi
    if ! pm2 start ecosystem.config.js --name "$1" --watch --ignore-watch="node_modules" --time --interpreter bash; then
        echo "Error: pm2 start ecosystem.config.js --name $1 --watch --ignore-watch=node_modules --time failed"
        return 1
    fi
    if ! pm2 save; then
        echo "Error: pm2 save failed"
        return 1
    fi
    pm2 startup
    printf "\n"
    echo "Success: Started $1"
    return 0
}

function pmdelete() {
    if [ -z "$1" ]; then
        echo "Error: Please provide a name for the process"
        return 1
    fi
    if ! pm2 delete "$1"; then
        echo "Error: pm2 delete $1 failed"
        return 1
    fi
    if ! pm2 save; then
        echo "Error: pm2 save failed"
        return 1
    fi
    printf "\n"
    echo "Success: Deleted $1"
    return 0
}

# tar -czvf archive.tar.gz folder_to_compress -s|--sudo
function tarme() {

    # Read arguments

    local folder_to_compress
    local archive_name
    local sudo

    while [ "$1" != "" ]; do
        case $1 in
        -s | --sudo)
            sudo="sudo"
            ;;
        *)
            folder_to_compress="$1"
            ;;
        esac
        shift
    done

    # Check if folder_to_compress is set

    if [ -z "$folder_to_compress" ]; then
        echo "Error: Please provide a folder to compress"
        return 1
    fi

    # Check if folder_to_compress exists

    if [ ! -d "$folder_to_compress" ]; then
        echo "Error: $folder_to_compress does not exist"
        return 1
    fi

    # Check if archive_name is set

    if [ -z "$archive_name" ]; then
        archive_name="$(basename "$folder_to_compress")"
    fi

    # Check if archive_name already exists

    if [ -f "$archive_name.tar.gz" ]; then
        echo "Error: $archive_name.tar.gz already exists"
        return 1
    fi

    # Compress folder_to_compress

    if ! $sudo tar -czvf "$archive_name.tar.gz" "$folder_to_compress"; then
        echo "Error: $sudo tar -czvf $archive_name.tar.gz $folder_to_compress failed"
        return 1
    fi

    # Check if archive_name.tar.gz exists

    if [ ! -f "$archive_name.tar.gz" ]; then
        echo "Error: $archive_name.tar.gz does not exist"
        return 1
    fi

    # Check if archive_name.tar.gz is not empty

    if [ ! -s "$archive_name.tar.gz" ]; then
        echo "Error: $archive_name.tar.gz is empty"
        return 1
    fi

    return 0
}

# tar -xzvf archive.tar.gz -s|--sudo
function untarme() {
    # Read arguments

    local archive_to_extract
    local sudo

    while [ "$1" != "" ]; do
        case $1 in
        -s | --sudo)
            sudo="sudo"
            ;;
        *)
            archive_to_extract="$1"
            ;;
        esac
        shift
    done

    # Check if archive_to_extract is set

    if [ -z "$archive_to_extract" ]; then
        echo "Error: Please provide an archive to extract"
        return 1
    fi

    # Check if archive_to_extract exists

    if [ ! -f "$archive_to_extract" ]; then
        echo "Error: $archive_to_extract does not exist"
        return 1
    fi

    # Check if archive_to_extract is not empty

    if [ ! -s "$archive_to_extract" ]; then
        echo "Error: $archive_to_extract is empty"
        return 1
    fi

    # Extract archive_to_extract

    if ! $sudo tar -xzvf "$archive_to_extract"; then
        echo "Error: $sudo tar -xzvf $archive_to_extract failed"
        return 1
    fi

    return 0
}
