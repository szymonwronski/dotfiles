source /opt/homebrew/opt/zinit/zinit.zsh

# OPTIONS
setopt auto_cd
setopt no_beep
setopt interactive_comments
setopt extended_glob
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt hist_reduce_blanks

HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

# COMPLETIONS & PLUGINS
zinit ice blockf
zinit light zsh-users/zsh-completions

autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
	compinit
else
	compinit -C
fi

zinit light Aloxaf/fzf-tab

zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting

zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(mise activate zsh)"
eval "$(ngrok completion)"

zvm_after_init() {
	# I need to put this here because zsh-vi-mode seems to override CTRL+R binding
	# Set up fzf key bindings and fuzzy completion: $(brew --prefix)/opt/fzf/install
	# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
	source <(fzf --zsh)
	bindkey -r '^ '
	zle -N sesh-sessions
	bindkey -M emacs '^ ' sesh-sessions
	bindkey -M vicmd '^ ' sesh-sessions
	bindkey -M viins '^ ' sesh-sessions

	bindkey -r '^Y'
	bindkey -M emacs '^Y' autosuggest-accept
	bindkey -M vicmd '^Y' autosuggest-accept
	bindkey -M viins '^Y' autosuggest-accept

	bindkey '^p' history-beginning-search-backward
	bindkey '^n' history-beginning-search-forward

	bindkey " " magic-space
	bindkey -M viins ' ' magic-space
}

function sesh-sessions() {
	{
		exec </dev/tty
		exec <&1
		local session
		session=$(sesh list | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
		zle reset-prompt >/dev/null 2>&1 || true
		[[ -z "$session" ]] && return
		sesh connect $session
	}
}

# FZF-TAB CONFIG
# case insensitive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
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

# ALIASES
alias l='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first'
alias ll='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first -l --git -h'
alias la='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first -a'
alias lla='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first -a -l --git -h'

alias q='exit'

alias gi='git init'
alias gs='git status --short'
alias ga="git add ."
alias gl='git log --graph --oneline --decorate'

n() {
	if [ "$#" -eq 0 ]; then
		nvim .
	else
		nvim "$@"
	fi
}

gc() { git commit -m "$*"; }

# Added by Antigravity IDE
export PATH="/Users/szymonwronski/.antigravity-ide/antigravity-ide/bin:$PATH"
