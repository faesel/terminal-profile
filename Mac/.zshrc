alias g='git'

cc() {
    cd "$HOME/code"
}

ccf() {
    cd "$HOME/code/faesel"
}

ccm() {
    cd "$HOME/code/mns"
}

newb() {
    git checkout -b "$@" || return
    printf 'Finished creating branch %s\n' "$(git branch --show-current)"
}

publish() {
    local branch
    branch=$(git symbolic-ref --quiet --short HEAD) || return
    git push --set-upstream origin "$branch"
}
