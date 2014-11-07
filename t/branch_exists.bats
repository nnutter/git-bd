#!/usr/bin/env bats

load test_helper

function setup {
    init_repo
}

function teardown {
    tempdir_cleanup
}

@test "branch_exists finds master" {
    branch_exists master
}

@test "branch_exists does not find unknown_branch" {
    ! branch_exists unknown_branch
}
