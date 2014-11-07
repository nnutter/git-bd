#!/usr/bin/env bats

load test_helper

function setup {
    init_repo
}

function teardown {
    tempdir_cleanup
}

@test "rename succeeds with valid new name" {
    git-bd foo

    run git-bd -m foo bar
    test "$status" -eq 0
    ! bd_registered foo
    ! branch_exists foo
    ! work_tree_exists foo
    bd_exists bar
}

@test "rename fails when new name already exists" {
    git-bd foo
    git-bd bar

    run git-bd -mf foo bar
    test "$status" -ne 0
    bd_exists foo
    bd_exists bar
}

@test "force rename succeeds when new name already exists" {
    git-bd foo
    git-bd bar

    run git-bd -Mf foo bar
    test "$status" -eq 0
    ! bd_registered foo
    ! branch_exists foo
    ! work_tree_exists foo
    bd_exists bar
}
