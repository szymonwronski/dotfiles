if type brew &>/dev/null; then
  FPATH=/opt/homebrew/share/zsh-completions:$FPATH
  
  autoload -Uz compinit
  compinit
fi

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(mise activate zsh)"
source /opt/homebrew/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source ~/.config/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source <(fzf --zsh)

zvm_after_init() {
 # I need to put this here because zsh-vi-mode seems to override CTRL+R binding
  # Set up fzf key bindings and fuzzy completion: $(brew --prefix)/opt/fzf/install
  # [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
  source <(fzf --zsh)
    bindkey -r '^K'
    zle     -N             sesh-sessions
    bindkey -M emacs '^K' sesh-sessions
    bindkey -M vicmd '^K' sesh-sessions
    bindkey -M viins '^K' sesh-sessions
}

function sesh-sessions() {
  {
    exec </dev/tty
    exec <&1
    local session
    session=$(sesh list | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
    zle reset-prompt > /dev/null 2>&1 || true
    [[ -z "$session" ]] && return
    sesh connect $session
  }
}

# fzf-tab config

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:z:*' fzf-preview 'eza -1a --color=always $realpath'
# custom fzf flags
# NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
# To make fzf-tab follow FZF_DEFAULT_OPTS.
# NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
zstyle ':fzf-tab:*' use-fzf-default-opts yes
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'
# tmux popup
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' popup-min-size 80 12

alias l='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first'
alias ll='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first -l --git -h'
alias la='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first -a'
alias lla='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first -a -l --git -h'

export EDITOR='nvim'
