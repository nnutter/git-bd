function abs_path {
    echo "$( cd -P "$1" && pwd )"
}

function warn {
    echo "$@" 1>&2
}

function tempdir {
    set -o errexit
    local TEMPDIR

    if man mktemp | grep -q BSD
    then
        TEMPDIR="$(mktemp -d -t git-bd)"
    fi

    if man mktemp | grep -q GNU
    then
        warn "GNU mktemp"
    fi

    echo "$TEMPDIR"
}

function tempdir_trap {
    local TEMPDIR="$1"
    if test -d "$TEMPDIR"
    then
        echo "cleaning up '$TEMPDIR'..."
        rm -rf "$TEMPDIR"
    fi
}
