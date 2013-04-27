function __git_bd_list_branches {
    local base_dir="$(git config --get bd.base-dir 2> /dev/null || true)"
    git config --get-regexp bd\..*\.work-tree \
        | sed -e 's/bd\..*\.work-tree //' \
        | sed -e "s|$base_dir/*||"

}

function _git_bd {
    local cur="${COMP_WORDS[COMP_CWORD]}"

    local prev=""
    if [ $COMP_CWORD -gt 0 ]; then
        prev="${COMP_WORDS[COMP_CWORD - 1]}"
    fi

    local BRANCHES=$(__git_bd_list_branches)
    if [ -z "$BRANCHES" ]; then
        return
    fi

    if [[ "$prev" =~ -[dDmMi] ]]; then
        COMPREPLY=($(compgen -W "$BRANCHES" -- $cur))
    else
        if [[ ${#COMP_WORDS[@]} -eq 3 && "$cur" =~ -[dDmMi]? ]]; then
            OPTIONS="-d -D -m -M --init"
            COMPREPLY=($(compgen -W "$OPTIONS" -- $cur))
        fi
    fi

}
complete -F _git_bd git-bd

function __complete_bd {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local BRANCHES=$(__git_bd_list_branches)
    if [ -z "$BRANCHES" ]; then
        return
    else
        if [ ${#COMP_WORDS[@]} -eq 2 ]; then
            COMPREPLY=($(compgen -W "$BRANCHES" -- $cur))
        fi
    fi
}
complete -F __complete_bd bd

function bd {
    local base_dir="$(git config --get bd.base-dir 2> /dev/null || true)"
    local git_dir="$(git config --get bd.git-dir 2> /dev/null || true)"
    if [ -n "$1" ]; then
        cd "$base_dir/$1"
    else
        cd "$git_dir/.."
    fi
}
