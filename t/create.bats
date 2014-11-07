#!/usr/bin/env bats

load test_helper

function setup {
    init_repo
}

function teardown {
    tempdir_cleanup
}

@test "create succeeds without start point" {
    run git-bd foo
    test "$status" -eq 0
    bd_exists foo
    test "$(sha_of foo)" = "$(sha_of master)"
}

@test "create succeeds with start point" {
    git checkout -b foo
    echo foo > README.md
    git commit -m 'foo' README.md
    git checkout master

    run git-bd baz foo
    test "$status" -eq 0
    bd_exists baz
    test "$(sha_of baz)"  = "$(sha_of foo)"
    test "$(sha_of baz)" != "$(sha_of master)"
}

@test "create fails when start point doesn't exist" {
    run git-bd baz foo
    test "$status" -ne 0
    ! bd_registered baz
    ! branch_exists baz
    ! work_tree_exists baz
}
