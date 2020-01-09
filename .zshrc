export DEFAULT_USER=mgoeppner
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR='vim'
export POWERLINE="/usr/local/lib/python2.7/site-packages/powerline"

export XDG_CACHE_HOME=${HOME}/.cache
export XDG_CONFIG_HOME=${HOME}/.config
export XDG_DATA_HOME=${HOME}/.config

if [ ! -d ${XDG_CACHE_HOME} ]; then
    mkdir -p ${XDG_CACHE_HOME}
fi

if [ ! -d ${XDG_CONFIG_HOME} ]; then
    mkdir -p ${XDG_CONFIG_HOME}
fi

if [ ! -d ${XDG_DATA_HOME} ]; then
    mkdir -p ${XDG_DATA_HOME}
fi

# History file configuration
[ -z "${HISTFILE}" ] && HISTFILE="${HOME}/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000

# History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data

test -e ~/.zshrc.vimode && source ~/.zshrc.vimode

POWERLINE_ZSH=${POWERLINE}/bindings/zsh/powerline.zsh
test -e ${POWERLINE_ZSH} && powerline-daemon -q && source ${POWERLINE_ZSH}

# Aliases
alias cls="clear"
alias ff="find . | fzf"
alias zshconfig="${EDITOR} ~/.zshrc ~/.zshrc.home ~/.zshrc.work"
alias powerlineconfig="${EDITOR} ~/.config/powerline"

test -e ~/.zshrc.secrets && source ~/.zshrc.secrets
test -e ~/.zshrc.home && source ~/.zshrc.home
test -e ~/.zshrc.work && source ~/.zshrc.work

# Setup pyenv and pyenv-virtualenv
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

DEFAULT_TMUX_SESSION="shell"
if [ -z "$TMUX" ]; then
    if [ -z $(tmux ls -F "#{session_name}" | grep ${DEFAULT_TMUX_SESSION}) ]; then
        exec tmux new -s ${DEFAULT_TMUX_SESSION}
    else
        session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0)
        exec tmux attach -t ${session}
    fi 
fi


