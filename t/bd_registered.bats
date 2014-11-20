#!/usr/bin/env bats

load test_helper

function setup {
    init_repo
}

function teardown {
    tempdir_cleanup
}

@test "bd_registered does find known bd" {
    git bd some_bd
    bd_registered some_bd
}

@test "bd_registered does not find unknown bd" {
    ! bd_registered some_bd
}
