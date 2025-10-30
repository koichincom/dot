Alias
alias n='nvim .'
alias p='cd ~/Projects'
alias c='cd ~/.config'

# Default editor
export EDITOR='nvim'

# Load zsh-syntax-highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Load zsh-autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Ruby
export PATH="/opt/homebrew/opt/rbenv/bin:$PATH"

# Homebrew
export PATH="/opt/homebrew/bin:$PATH"

# npm
export PATH="/Users/koichi/.npm-global/bin:$PATH"
eval "$(rbenv init - zsh)"
