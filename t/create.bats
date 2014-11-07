#!/usr/bin/env bats

load test_helper

function setup {
    init_repo
}

function teardown {
    tempdir_cleanup
}

@test "create succeeds without start point" {
    git-bd foo
    test -d "$TEMPDIR/foo"
    FOO="$(git rev-parse --verify refs/heads/foo)"
    MASTER="$(git rev-parse --verify refs/heads/master)"
    test "$FOO" = "$MASTER"
}

@test "create succeeds with start point" {
    git checkout -b foo
    echo foo > README.md
    git commit -m 'foo' README.md
    git checkout master
    git-bd baz foo
    test -d "$TEMPDIR/baz"
    BAZ="$(git rev-parse --verify refs/heads/baz)"
    FOO="$(git rev-parse --verify refs/heads/foo)"
    MASTER="$(git rev-parse --verify refs/heads/master)"
    test "$BAZ" = "$FOO"
    test "$BAZ" != "$MASTER"
}

@test "create fails when start point doesn't exist" {
    run git-bd baz foo
    test "$status" -ne 0
    ! test -d "$TEMPDIR/baz"
    ! git rev-parse --verify refs/heads/baz
}
