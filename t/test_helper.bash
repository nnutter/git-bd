function diag {
    echo "# $@"
}

function abs_path {
    echo "$( cd -P "$1" && pwd )"
}

function tempdir {
    set -o errexit

    if man mktemp | grep -q BSD
    then
        TEMPDIR="$(mktemp -d -t git-bd)"
    fi

    if man mktemp | grep -q GNU
    then
        TEMPDIR="$(mktemp --tmpdir -d git-bd.XXXXXXXX)"
    fi

    echo "$TEMPDIR"
}

function tempdir_cleanup {
    if test -d "$TEMPDIR"
    then
        diag "cleaning up '$TEMPDIR'..."
        rm -rf "$TEMPDIR"
    fi
}

function branch_exists {
    git rev-parse --verify refs/heads/${1}
}

function bd_registered {
    git config bd.${1}.work-tree
}

function work_tree_exists {
    test -d "${TEMPDIR}/${1}"
}

function bd_exists {
    branch_exists ${1} && work_tree_exists ${1} && bd_registered ${1}
}

function init_repo {
    WORK_TREE="$(abs_path $BATS_TEST_DIRNAME/..)"
    export PATH="${WORK_TREE}:${PATH}"

    TEMPDIR="$(tempdir)"
    cd $TEMPDIR

    git init master
    cd master
    git config user.email "you@example.com"
    git config user.name "Your Name"
    touch README.md
    git add README.md
    git commit -m 'initial commit'

    git-bd -f --init
}

function sha_of {
    git rev-parse --verify refs/heads/${1}
}
