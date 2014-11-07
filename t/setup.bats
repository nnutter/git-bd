#!/usr/bin/env bats

load test_helper

function setup {
    init_repo
}

function teardown {
    tempdir_cleanup
}

@test "PATH setup correctly" {
    run which git-bd
    test "$status" -eq 0
    test "$output"  = "$WORK_TREE/git-bd"
}

@test "CWD setup correctly" {
    run pwd
    test "$status" -eq 0
    test "$output"  = "$TEMPDIR/master"
}

@test "initial state setup correctly" {
    run git log --oneline
    test "$status" -eq 0
}
