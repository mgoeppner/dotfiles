export DEFAULT_USER=mgoeppner
export LANG=en_US.UTF-8
export EDITOR='vim'
export TERMINAL=urxvt
export ZSH=/home/mgoeppner/.cache/oh-my-zsh

export XDG_CACHE_HOME=${HOME}/.cache
export XDG_CONFIG_HOME=${HOME}/.config
export XDG_DATA_HOME=${HOME}/.config

test -e ~/.secrets && source ~/.secrets

if [ -z "$SSH_AGENT_PID" ]; then
    eval $(ssh-agent -s) && ssh-add ~/.ssh/id_rsa
fi

plugins=(vi-mode)

OH_MY_ZSH="${ZSH}/oh-my-zsh.sh"
test -e ${OH_MY_ZSH} && source ${OH_MY_ZSH}

POWERLINE=/usr/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh

if [ "$WINDOWID" ]; then
    test -e ${POWERLINE} && source ${POWERLINE}
fi

# Aliases
alias cls="clear"
alias zshconfig="${EDITOR} ~/.zshrc ~/.zshrc.home ~/.zshrc.work"
alias pbcopy="xclip -selection clipboard"
alias pbpaste="xclip -selection clipboard -o"

test -e ~/.zshrc.home && source ~/.zshrc.home
test -e ~/.zshrc.work && source ~/.zshrc.work

function set-brightness() {
    echo $1 | sudo tee /sys/class/backlight/gmux_backlight/brightness;
}

function set-kbd-brightness() {
    echo $1 | sudo tee /sys/class/leds/smc::kbd_backlight/brightness;
}

function toggle-kbd-layout() {
    if [ "$(setxkbmap -query | awk '/layout/ {print $2}')" = "us" ]; then
        setxkbmap se;
        rivalcfg -c blue -e steady;
        return 0;
    fi

    setxkbmap us;
    rivalcfg -c red -e steady;
    return 0;
}
