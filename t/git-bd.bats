#!/usr/bin/env bats

load test_helper

function setup {
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

function teardown {
    tempdir_cleanup $TEMPDIR
}

@test "PATH setup correctly" {
    run which git-bd
    test "$status" -eq 0
    test "$output"  = "$WORK_TREE/git-bd"
}

@test "CWD setup correctly" {
    run pwd
    warn "$output"
    test "$status" -eq 0
    test "$output"  = "$TEMPDIR/master"
}

@test "initial state setup correctly" {
    run git log --oneline
    test "$status" -eq 0
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

@test "delete fails from the same bd" {
    git-bd foo
    cd "$TEMPDIR/foo"
    run git-bd -df foo
    test "$status" -ne 0
    test -d "$TEMPDIR/foo"
    git rev-parse --verify refs/heads/foo
}

@test "delete succeeds when branch is merged" {
    git-bd foo
    run git-bd -df foo
    test "$status" -eq 0
    ! test -d "$TEMPDIR/foo"
    ! git rev-parse --verify refs/heads/foo
}

@test "delete fails when branch is unmerged" {
    git-bd foo
    cd "$TEMPDIR/foo"
    echo foo > README.md
    git commit -m 'foo' README.md
    cd "$TEMPDIR/master"
    run git-bd -df foo
    test "$status" -ne 0
    ! test -d "$TEMPDIR/foo"
    git rev-parse --verify refs/heads/foo
}

@test "force delete succeeds when branch is umerged" {
    git-bd foo
    cd "$TEMPDIR/foo"
    echo foo > README.md
    git commit -m 'foo' README.md
    cd "$TEMPDIR/master"
    run git-bd -Df foo
    test "$status" -eq 0
    ! test -d "$TEMPDIR/foo"
    ! git rev-parse --verify refs/heads/foo
}

@test "rename succeeds with valid new name" {
    git-bd foo
    run git-bd -m foo bar
    test "$status" -eq 0
    ! test -d "$TEMPDIR/foo"
    ! git rev-parse --verify refs/heads/foo
    test -d "$TEMPDIR/bar"
    git rev-parse --verify refs/heads/bar
}

@test "rename fails when new name already exists" {
    git-bd foo
    git-bd bar
    run git-bd -mf foo bar
    test "$status" -ne 0
    test -d "$TEMPDIR/foo"
    git rev-parse --verify refs/heads/foo
    test -d "$TEMPDIR/bar"
    git rev-parse --verify refs/heads/bar
}

@test "force rename succeeds when new name already exists" {
    git-bd foo
    git-bd bar
    run git-bd -Mf foo bar
    test "$status" -eq 0
    ! test -d "$TEMPDIR/foo"
    ! git rev-parse --verify refs/heads/foo
    test -d "$TEMPDIR/bar"
    git rev-parse --verify refs/heads/bar
}

@test "delete fails for unknown branchdir" {
    run git-bd -df foo
    test "$status" -ne 0
}

@test "delete with branch and work_tree already removed" {
    git-bd foo
    git branch -d foo
    rm -rf "$TEMPDIR/foo"
    run git-bd -df foo
    test "$status" -eq 0
}

@test "delete with branch already removed" {
    git-bd foo
    git branch -d foo
    run git-bd -df foo
    test "$status" -eq 0
    ! test -d "$TEMPDIR/foo"
}

@test "delete with work_tree already removed" {
    git-bd foo
    rm -rf "$TEMPDIR/foo"
    run git-bd -df foo
    test "$status" -eq 0
    ! git rev-parse --verify refs/heads/foo
}
