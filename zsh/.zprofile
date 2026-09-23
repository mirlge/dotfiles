[ -f "$HOME/.profile" ] && source "$HOME/.profile"

# local binaries and Homebrew sbin
export PATH="$HOME/.local/bin:$PATH"
if command -v brew &> /dev/null
then
  export PATH="$(brew --prefix)/sbin:$PATH"
fi

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
[ -d "$BUN_INSTALL" ] && export PATH="$BUN_INSTALL/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export HOMEBREW_NO_ANALYTICS=1

# deno
export DENO_INSTALL="$HOME/.deno"
[ -d "$DENO_INSTALL" ] && export PATH="$DENO_INSTALL/bin:$PATH"

export QT_QPA_PLATFORMTHEME=qt5ct

command -v go &> /dev/null && export PATH="$(go env GOPATH)/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

if [[ "$TERM" == "linux" ]] && command -v uwsm &> /dev/null && uwsm check may-start && uwsm select; then
	exec systemd-cat -t uwsm_start uwsm start default
fi
