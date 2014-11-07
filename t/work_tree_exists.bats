#!/usr/bin/env bats

load test_helper

function setup {
    init_repo
}

function teardown {
    tempdir_cleanup
}

@test "work_tree_exists does find known bd" {
    git bd some_bd
    work_tree_exists some_bd
}

@test "work_tree_exists does not find unknown bd" {
    ! work_tree_exists some_bd
}
