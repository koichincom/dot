# Environment variables
export EDITOR='nvim'

# PATH configuration
export PATH="/opt/homebrew/opt/rbenv/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/Users/koichi/.npm-global/bin:$PATH"
eval "$(rbenv init - zsh)"

# Aliases
alias n='nvim .'
alias p='cd ~/Projects'
alias c='claude'
alias nvim-dev='NVIM_APPNAME=nvim-dev nvim'

# Plugins
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
