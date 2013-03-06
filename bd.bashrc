__git_bd_list_branches() {
    local branchdir_base="$(git config --get branchdir.base 2> /dev/null || true)"
    git config --get-regexp branchdir\..*\.work-tree \
        | sed -e 's/branchdir\..*\.work-tree //' \
        | sed -e "s|$branchdir_base/*||"

}

_git_bd() {
    local cur="${COMP_WORDS[COMP_CWORD]}"

    local prev=""
    if [ $COMP_CWORD -gt 0 ]; then
        prev="${COMP_WORDS[COMP_CWORD - 1]}"
    fi

    local BRANCHES=$(__git_bd_list_branches)
    if [ -z "$BRANCHES" ]; then
        return
    fi

    if [[ "$prev" =~ -[dDmM] ]]; then
        COMPREPLY=($(compgen -W "$BRANCHES" -- $cur))
    else
        if [[ ${#COMP_WORDS[@]} -eq 3 && "$cur" =~ -[dDmM]? ]]; then
            OPTIONS="-d -D -m -M"
            COMPREPLY=($(compgen -W "$OPTIONS" -- $cur))
        fi
    fi

}

bd_complete() {
    COMPREPLY=()
    local BRANCHES=$(__git_bd_list_branches)
    if [ ${#COMP_WORDS[@]} -eq 2 ]; then
        local cur=${COMP_WORDS[COMP_CWORD]}
        COMPREPLY=($(compgen -W "$BRANCHES" -- $cur))
    fi
}
complete -F _git_bd bd

bd() {
    local branchdir_base="$(git config --get branchdir.base 2> /dev/null || true)"
    local git_dir="$(git config --get branchdir.git-dir 2> /dev/null || true)"
    if [ -n "$1" ]; then
        cd "$branchdir_base/$1"
    else
        cd "$git_dir/.."
    fi
}
