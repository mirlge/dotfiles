# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zdharma-continuum/fast-syntax-highlighting"
plug "zsh-users/zsh-completions"
plug "zsh-users/zsh-apple-touchbar"

bindkey -v

# Load and initialise completion system
autoload -Uz compinit
compinit

# User Config #

# iTerm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# antigen start #
#source $(dirname $0)/antigen.zsh

#antigen bundle zsh-users/zsh-completions
#antigen bundle zsh-users/zsh-autosuggestions
#antigen bundle zsh-users/zsh-apple-touchbar
#antigen bundle zsh-users/zsh-syntax-highlighting
#antigen bundle zsh-users/zsh-history-substring-search

#antigen apply
# antigen end #

export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# starship
eval "$(starship init zsh)"

# zsh-xt
. $HOME/.zsh-xt/load.zsh
zsh-xt color
zsh-xt ls
zsh-xt lsd
zsh-xt nvim
zsh-xt git

# manpager, editor, etc.
export MANPAGER="nvim +Man!"
export VISUAL="nvim"
export EDITOR="nvim"

# fzf Rosé Pine
export FZF_DEFAULT_OPTS="
  --color=fg:#908caa,bg:#191724,hl:#ebbcba
  --color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
  --color=border:#403d52,header:#31748f,gutter:#191724
  --color=spinner:#f6c177,info:#9ccfd8,separator:#403d52
  --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"

# deno completions
eval "$(deno completions zsh)"

# zellij completions + more
eval "$(zellij setup --generate-completion zsh)"

# gpg signing fix
export GPG_TTY=$TTY

export TERM=xterm-256color

alias nvim-nightly="$HOME/.nvim/versions/nightly/bin/nvim"

alias hx="PATH=\"$HOME/.local/share/nvim/mason/bin:$PATH\" hx"

source <(pkgx --shellcode)  #docs.tea.xyz/shellcode

source "$HOME/.pkgxd"

[ -f "/Users/mirge/.ghcup/env" ] && source "/Users/mirge/.ghcup/env" # ghcup-env

source <(sunbeam completion zsh)

eval "$(luarocks path --bin)"

#fastfetch
