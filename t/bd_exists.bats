#!/usr/bin/env bats

load test_helper

function setup {
    init_repo
}

function teardown {
    tempdir_cleanup
}

@test "bd_exists does find known bd" {
    git bd some_bd
    bd_exists some_bd
}

@test "bd_exists does not find unknown bd" {
    ! bd_exists some_bd
}

@test "bd_exists fails if branch is deleted" {
    git bd some_bd
    git branch -d some_bd
    ! bd_exists some_bd
}

@test "bd_exists fails if work_tree is deleted" {
    git bd some_bd
    rm -rf "${TEMPDIR}/some_bd"
    ! bd_exists some_bd
}

@test "bd_exists fails if bd is unregistered" {
    git bd some_bd
    git config --unset bd.some_bd.work-tree
    ! bd_exists some_bd
}
