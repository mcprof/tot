function cd() {
    new_directory="$*";
    if [ $# -eq 0 ]; then 
        new_directory=${HOME};
    fi;
    builtin cd "${new_directory}" && ls
}

alias jim='vim ~/.zshrc; source ~/.zshrc'
alias jimup="brew update && brew upgrade && brew update && brew upgrade && pip3 install -U pip && pip3 install -U youtube-dl && pip3 install -U wget"
alias vimjim="vim ~/tot/vim/vimrc"
alias jimvim="vim ~/tot/vim/vimrc"

# https://ma.ttias.be/du-max-depth-alternative-mac-osx/
alias lsd="ls -lh && du -hd1"

export EDITOR='vim'
export CLICOLOR=1

# Fix for behaviour of not redrawing full terminal on exiting/backgrounding vim, just scrolling one line up
TERM=xterm

# Added to make SSH keys load after restart, from https://discussions.apple.com/thread/7685687
# ssh-add -A


# Possible, from https://www.ibm.com/developerworks/aix/library/au-spunixpower.html

# Expand-o-Matic

# With so much code available on the Internet, you're likely to download dozens of files every day. And chances are, all those files are packaged differently—a ZIP file here, a RAR file there, and tarballs galore, albeit each one compressed with a different utility. Remembering how to decompress and expand each package format can be taxing. So, why not capture all those tasks in a single command? This function is widely available in many sample dot files:

# ex () {
#   if [ -f $1 ] ; then
#     case $1 in
#       *.tar.bz2)   tar xjf $1        ;;
#       *.tar.gz)    tar xzf $1     ;;
#       *.bz2)       bunzip2 $1       ;;
#       *.rar)       rar x $1     ;;
#       *.gz)        gunzip $1     ;;
#       *.tar)       tar xf $1        ;;
#       *.tbz2)      tar xjf $1      ;;
#       *.tgz)       tar xzf $1       ;;
#       *.zip)       unzip $1     ;;
#       *.Z)         uncompress $1  ;;
#       *.7z)        7z x $1    ;;
#       *)           echo "'$1' cannot be extracted via extract()" ;;
#     esac
#   else
#     echo "'$1' is not a valid file"
#   fi
# }

# This function, ex, expands 11 file formats and can be extended if you deal with some other package type. Once defined—say, in a shell startup file—you can simply type ex somefile, where somefile ends with one of the named extensions:


# Zsh starts:
# ------------------------------------------------------------------------------


# # https://scriptingosx.com/2019/07/moving-to-zsh-part-5-completions/
# # # case insensitive path-completion 
# zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 
# # partial completion suggestions
# zstyle ':completion:*' list-suffixes zstyle ':completion:*' expand prefix suffix 

# # https://unix.stackexchange.com/questions/185537/combining-zsh-s-tab-completion-with-case-insensitivity
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# setopt MENU_COMPLETE

# autoload -Uz compinit && compinit 
# # autoload -Uz compinit && compinit 
# # autoload -Uz compinit 
# # autoload compinit 
#
# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**'
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall


# terminal vim from https://stackoverflow.com/questions/26196585/why-doesnt-my-jk-zsh-vi-cmd-mode-binding-not-work
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M viins 'kj' vi-cmd-mode

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# # adapted from https://www.wikihow.com/Encrypt-an-External-
# Hard-Drive-on-Linux
# alias mountdrive='sudo cryptsetup luksOpen /dev/sdc sdc &&
# sudo mount /dev/mapper/sdc /mnt/encrypted'
# alias unmountdrive='sudo umount /mnt/encrypted && sudo
# cryptsetup luksClose sdc'
# # https://blog.webnersolutions.com/ubuntu-how-to-
# automatically-mount-the-encrypted-drive-at-startup-of-system/
# # https://www.golinuxcloud.com/mount-luks-encrypted-disk-
# partition-linux/


# add bash style edit command line to zsh with vim binding (escape + v) 
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
