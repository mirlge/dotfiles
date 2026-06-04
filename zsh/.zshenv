if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
elif [ -d "$HOME/.cargo/bin" ]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

[[ -e "$XDG_RUNTIME_DIR/gcr/ssh" && -z "$SSH_AUTH_SOCK" ]] && export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gcr/ssh"
