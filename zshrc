export TERM="xterm-256color"

# Download antigen with git if it doesn't exist already
if [ ! -r ~/.antigen/antigen.zsh ]; then
  [ ! command -v git > /dev/null 2>&1 ] ||
    (echo "Please install git." &&
    return;)
  echo "Installing antigen into ~/.antigen/";
  git clone https://github.com/zsh-users/antigen.git ~/.antigen
fi;

if [ ! -r ~/.config/base16-shell/scripts/base16-eighties.sh ]; then
  [ ! command -v git > /dev/null 2>&1 ] ||
    (echo "Please install git." &&
    return;)
  echo "Installing base16-shell into ~/.config/base16-shell";
  git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
fi;

if [ ! -r ~/.iterm2_shell_integration.zsh ]; then
  curl -L https://iterm2.com/misc/zsh_startup.in >> \
  ~/.iterm2_shell_integration.zsh
  source ~/.iterm2_shell_integration.zsh
fi;

source $HOME/.antigen/antigen.zsh

# allow usage of C-q and C-s shortcuts other places
stty -ixon
stty start undef
stty stop undef

# fix for iterm c-h issue
# infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > $TERM.ti
# tic $TERM.ti

antigen use oh-my-zsh

antigen bundle brew
antigen bundle composer
antigen bundle extract
antigen bundle git
antigen bundle git-extras
antigen bundle vagrant
antigen bundle wp-cli
antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme jeffhertzler/zsh-themes agnoster

antigen apply

export PATH=/usr/local/sbin:$PATH

export COMPOSER_DISABLE_XDEBUG_WARN=1
which -s composer >> /dev/null
if [ $? = 0 ]
  then
    export PATH=~/.composer/vendor/bin:$PATH
fi

alias vi=vim
export EDITOR=vim

if type nvim >/dev/null 2>/dev/null; then
  alias vi=nvim
  alias vim=nvim
  export EDITOR=nvim
fi

BASE16_SHELL="$HOME/.config/base16-shell/scripts/base16-eighties.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

alias art='php artisan'
alias reload=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"
alias ze="vim ~/.zshrc && reload"
alias ve="vim ~/.vimrc"

export FZF_DEFAULT_COMMAND='(git ls-files && git ls-files -o --exclude-standard || ag -g "") 2> /dev/null'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="/Users/vinceruby/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
