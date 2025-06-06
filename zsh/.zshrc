# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# starship prompt
# requires starship to be installed
eval "$(starship init zsh)"

# Add in zsh plugins
zinit wait lucid light-mode for \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
      zdharma-continuum/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions \
      zsh-users/zsh-completions \
      Aloxaf/fzf-tab

zinit snippet OMZP::git 
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# History
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':compinit' cache-path ~/.zcompdump
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='eza -h --icons --git --color=auto --hyperlink'
alias la='ls -la'
alias ll='ls -l'
alias tree='tree -C'
alias hyprland='Hyprland'
alias nvfzf='nvim $(fzf -m --preview="bat --color=always {}")'
alias lg='lazygit'

# Variables
export EDITOR="nvim"

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"


# other stuff
# fnm
FNM_PATH="/home/am/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/am/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi

# bun completions
[ -s "/home/am/.bun/_bun" ] && source "/home/am/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/am/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/am/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/home/am/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/home/am/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

. "/home/am/.deno/env"


export PATH="/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:$PATH"

PATH="/home/am/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/am/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/am/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/am/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/am/perl5"; export PERL_MM_OPT;

[ -f "/home/am/.ghcup/env" ] && . "/home/am/.ghcup/env" # ghcup-env

# pnpm
export PNPM_HOME="/home/am/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# fzf catppuccin
export FZF_DEFAULT_OPTS=" \
--style=full \
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#313244,label:#CDD6F4"
