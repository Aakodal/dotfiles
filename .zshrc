if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="/home/aakodal/.oh-my-zsh"

setopt correct

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
)

export ZSH_TMUX_AUTOSTART=false
export ZSH_TMUX_AUTOCONNECT=false
export ZSH_TMUX_AUTOSTART_ONCE=false

source $ZSH/oh-my-zsh.sh

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' rehash true
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

export SHELL=zsh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.local/share/Flutter-2.2.3/bin"
export PATH="$PATH:$HOME/.volta/.bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.local/share/haxe-4.1.5"

export WINEPREFIX="/home/aakodal/.local/share/wineprefixes/w32"

export DOTNET_CLI_TELEMETRY_OPTOUT=1

alias gitacp='git add -A && git commit && git push'
alias zcc='gcc -Wall -Wextra -pedantic -std=c11 -fno-common -fno-builtin'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source /home/aakodal/.config/broot/launcher/bash/br
