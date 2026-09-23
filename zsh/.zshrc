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

check_command() {
  command -v "$@" &> /dev/null
}

# starship
check_command starship && eval "$(starship init zsh)"

# shell aliases
shell_aliases_dir="$HOME/.dotfiles/_shell-aliases"
source "$shell_aliases_dir/color.sh"
source "$shell_aliases_dir/ls.sh"
source "$shell_aliases_dir/eza.sh"
unset shell_aliases_dir
alias matugen-img='matugen image -t scheme-rainbow'

# manpager, editor, etc.
if check_command nvim
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
#check_command fzf && source <(fzf --zsh)

# deno completions
check_command deno && eval "$(deno completions zsh)"

# gpg signing fix
export GPG_TTY=$TTY

if [[ "$TERM" != "linux" ]]; then
  export TERM=xterm-256color
fi

export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"

# builtin <C-w>
export WORDCHARS='_'

alias nvim-nightly="$HOME/.local/share/bob/nightly/bin/nvim"

alias hx="PATH=\"$HOME/.local/share/nvim/mason/bin:$PATH\" hx"

check_command pkgx && eval "$(pkgx dev --shellcode)"  # https://github.com/pkgxdev/dev

[ -f "$HOME/.pkgxd" ] && source "$HOME/.pkgxd"

[ -f "/Users/mirge/.ghcup/env" ] && source "/Users/mirge/.ghcup/env" # ghcup-env

check_command sunbeam && source <(sunbeam completion zsh)

check_command luarocks && eval "$(luarocks path --bin)"

check_command zoxide && eval "$(zoxide init zsh)"

check_command direnv && eval "$(direnv hook zsh)"

check_command pypush && eval "$(pypush --show-completion)"

check_command arduino-cli && eval "$(arduino-cli completion zsh)"

check_command git-branchless && function git() { git-branchless wrap -- "$@" }

check_command k3s && eval "$(k3s completion zsh)"

check_command kubectl && eval "$(kubectl completion zsh)"

# bun completions
[ -s "/home/tor/.bun/_bun" ] && source "/home/tor/.bun/_bun"

check_command atuin && eval "$(atuin init --disable-up-arrow zsh)"

check_command pfetch && pfetch

unset -f check_command
