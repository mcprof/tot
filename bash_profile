export EDITOR='vim'
export CLICOLOR=1

function cd() {
    new_directory="$*";
    if [ $# -eq 0 ]; then
        new_directory=${HOME};
    fi;
    builtin cd "${new_directory}" && ls
}

# Vim command settings
set -o vi

alias jim='vim ~/.bash_profile; source ~/.bash_profile'
alias jimup='sudo apt update && sudo apt upgrade && sudo apt update && sudo apt upgrade'
alias vimjim='vim ~/.vim/vimrc'
alias jimvim='vim ~/.vim/vimrc'
alias lsd="ls -lh && du -h --max-depth 1"
alias notes="vim ~/tot/reference.md"

alias jimip='lynx www.whatsmyip.com'

alias gitup='git submodule update --init --recursive && git submodule foreach --recursive git fetch && git submodule foreach git pull --ff-only origin           master' # from https://stackoverflow.com/questions/10168449/git-update-submodules-recursively

alias ulaunch='bash ~/launch.sh'
alias launchu=ulaunch

alias diskm='bash ~/.diskmount.sh'
alias disku='bash ~/.diskunmount.sh'
# alias diskm='sudo cryptsetup open /dev/sdb blackdrive ; sudo mount /dev/mapper/blackdrive ~/blackdrive'
# alias disku='sudo umount ~/blackdrive ; sudo cryptsetup close blackdrive'

alias paperpush='rsync -auhcPv ~/Documents/finalpaper gehirn:Documents/'

alias balpush='bash ~/.balthasarpush.sh'
# rsync -auPhv --exclude-from='/Volumes/Alpha/mirror/excludelist.txt' /Volumes/Alpha/mirror/AlphaStorage balthasarl:cedar/mirror/
alias balpushdel='bash ~/.balthasarpushdelete.sh'
# rsync -auPhv --delete --exclude-from='/Volumes/Alpha/mirror/excludelist.txt' /Volumes/Alpha/mirror/AlphaStorage balthasarl:cedar/mirror/
