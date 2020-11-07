export EDITOR='vim'

function cd() {
    new_directory="$*";
    if [ $# -eq 0 ]; then 
        new_directory=${HOME};
    fi;
    builtin cd "${new_directory}" && ls
}

alias jim='vim ~/.bash_profile; source ~/.bash_profile'

alias gitup='git submodule update --init --recursive && git submodule foreach --recursive git fetch && git submodule foreach git pull --ff-only origin master' # from https://stackoverflow.com/questions/10168449/git-update-submodules-recursively
