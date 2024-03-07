[ -f "$HOME/.profile" ] && source "$HOME/.profile"

export PYTHON3_MACOS_FRAMEWORK="/Library/Frameworks/Python.framework"
if [ -d "$PYTHON3_MACOS_FRAMEWORK" ]
then
  # Setting PATH for Python 3.9
  # The original version is saved in .zprofile.pysave
  PATH="/Library/Frameworks/Python.framework/Versions/3.9/bin:${PATH}"
  export PATH

  # Setting PATH for Python 3.10
  # The original version is saved in .zprofile.pysave
  PATH="/Library/Frameworks/Python.framework/Versions/3.10/bin:${PATH}"
  export PATH

  # Setting PATH for Python 3.11
  # The original version is saved in .zprofile.pysave
  PATH="/Library/Frameworks/Python.framework/Versions/3.11/bin:${PATH}"
  export PATH
fi

# local binaries and Homebrew sbin
export PATH="$HOME/.local/bin:$PATH"
if command -v brew &> /dev/null
then
  export PATH="$(brew --prefix)/sbin:$PATH"
fi

# JavaFX
if [ -d "$HOME/javafx-sdk-*" ]
then
  export PATH_TO_FX="$HOME/javafx-sdk-*/lib"
  export PATH="$HOME/perl5/bin${PATH:+:${PATH}}"; export PATH;
fi

# perl
if [ -d "$HOME/perl5" ]
then
  export PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
  export PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
  export PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
  export PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;
fi

# java
if [ -f /usr/libexec/java_home ]
then
  export JAVA_HOME=$(/usr/libexec/java_home)
  export PATH="$JAVA_HOME:$PATH"
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
