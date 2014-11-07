function abs_path {
    echo "$( cd -P "$1" && pwd )"
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
        TEMPDIR="$(mktemp --tmpdir -d git-bd.XXXXXXXX)"
    fi

    echo "$TEMPDIR"
}

function tempdir_cleanup {
    local TEMPDIR="$1"
    if test -d "$TEMPDIR"
    then
        echo "cleaning up '$TEMPDIR'..."
        rm -rf "$TEMPDIR"
    fi
}
