if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

CASE_SENSITIVE="true"

ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="%F{yellow} ...%f"
DISABLE_UNTRACKED_FILES_DIRTY="true"

HIST_STAMPS="dd/mm/yyyy"

plugins=(git aliases colored-man-pages colorize copypath copyfile cp history web-search autojump docker nvm node composer laravel zsh-autosuggestions zsh-syntax-highlighting sudo fzf laravel-sail)

source $ZSH/oh-my-zsh.sh

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

fix_wsl2_interop() {
    for i in $(pstree -np -s $$ | grep -o -E '[0-9]+'); do
        if [[ -e "/run/WSL/${i}_interop" ]]; then
            export WSL_INTEROP=/run/WSL/${i}_interop
        fi
    done
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export FZF_BASE="$HOME/.fzf"
export FZF_DEFAULT_COMMAND='rg --hidden --no-ignore --files -g "!.git/"'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

. /usr/share/autojump/autojump.sh

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
# pnpm
export PNPM_HOME="/home/yann/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end