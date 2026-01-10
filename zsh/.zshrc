# Created by Zap installer
if [ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ]
then
  source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
  plug "zsh-users/zsh-autosuggestions"
  plug "zap-zsh/supercharge"
  plug "jeffreytse/zsh-vi-mode"
  plug "zsh-users/zsh-completions"
  plug "zsh-users/zsh-syntax-highlighting"
fi

bindkey -v

# Load and initialise completion system
autoload -Uz compinit
compinit

# User Config #

# better up/down history search
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# starship
command -v starship &> /dev/null && eval "$(starship init zsh)"

# shell aliases
shell_aliases_dir="$HOME/.dotfiles/_shell-aliases"
source "$shell_aliases_dir/color.sh"
source "$shell_aliases_dir/ls.sh"
source "$shell_aliases_dir/eza.sh"
unset shell_aliases_dir
alias matugen-img='matugen image -t scheme-rainbow'

# manpager, editor, etc.
if command -v nvim &> /dev/null
then
  export MANPAGER="nvim +Man!"
  export VISUAL="nvim"
  export EDITOR="nvim"
fi

# fzf Rosé Pine
export FZF_DEFAULT_OPTS="
  --color=fg:#908caa,bg:#191724,hl:#ebbcba
  --color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
  --color=border:#403d52,header:#31748f,gutter:#191724
  --color=spinner:#f6c177,info:#9ccfd8,separator:#403d52
  --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"

# set up fzf key bindings and fuzzy completion
command -v fzf &> /dev/null && source <(fzf --zsh)

# deno completions
command -v deno &> /dev/null && eval "$(deno completions zsh)"

# zellij completions + more
command -v zellij &> /dev/null && eval "$(zellij setup --generate-completion zsh)"

# gpg signing fix
export GPG_TTY=$TTY

if [[ "$TERM" != "linux" ]]; then
  export TERM=xterm-256color
fi

export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"

# builtin <C-w>
export WORDCHARS=''

alias nvim-nightly="$HOME/.local/share/bob/nightly/bin/nvim"

alias hx="PATH=\"$HOME/.local/share/nvim/mason/bin:$PATH\" hx"

command -v pkgx &> /dev/null && eval "$(pkgx dev --shellcode)"  # https://github.com/pkgxdev/dev

[ -f "$HOME/.pkgxd" ] && source "$HOME/.pkgxd"

[ -f "/Users/mirge/.ghcup/env" ] && source "/Users/mirge/.ghcup/env" # ghcup-env

command -v sunbeam &> /dev/null && source <(sunbeam completion zsh)

command -v luarocks &> /dev/null && eval "$(luarocks path --bin)"

command -v zoxide &> /dev/null && eval "$(zoxide init zsh)"

command -v direnv &> /dev/null && eval "$(direnv hook zsh)"

command -v pypush &> /dev/null && eval "$(pypush --show-completion)"

command -v arduino-cli &> /dev/null && eval "$(arduino-cli completion zsh)"

command -v git-branchless &> /dev/null && function git() { git-branchless wrap -- "$@" }

command -v k3s &> /dev/null && eval "$(k3s completion zsh)"

command -v kubectl &> /dev/null && eval "$(kubectl completion zsh)"

command -v pfetch &> /dev/null && pfetch
