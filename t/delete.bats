#!/usr/bin/env bats

load test_helper

function setup {
    init_repo
}

function teardown {
    tempdir_cleanup
}

@test "delete fails from the same bd" {
    git-bd foo
    cd "$TEMPDIR/foo"

    bd_exists foo
    run git-bd -df foo
    test "$status" -ne 0
    bd_exists foo
}

@test "delete succeeds when branch is merged" {
    git-bd foo

    bd_exists foo
    run git-bd -df foo
    test "$status" -eq 0
    ! bd_registered foo
    ! branch_exists foo
    ! work_tree_exists foo
}

@test "delete fails when branch is unmerged" {
    git-bd foo
    cd "$TEMPDIR/foo"
    echo foo > README.md
    git commit -m 'foo' README.md
    cd "$TEMPDIR/master"

    bd_exists foo
    run git-bd -df foo
    test "$status" -ne 0
    bd_registered foo
    branch_exists foo
    ! work_tree_exists foo
}

@test "force delete succeeds when branch is umerged" {
    git-bd foo
    cd "$TEMPDIR/foo"
    echo foo > README.md
    git commit -m 'foo' README.md
    cd "$TEMPDIR/master"

    bd_exists foo
    run git-bd -Df foo
    test "$status" -eq 0
    ! bd_registered foo
    ! branch_exists foo
    ! work_tree_exists foo
}

@test "delete fails for unknown branchdir" {
    run git-bd -df foo
    test "$status" -ne 0
    ! bd_registered foo
    ! branch_exists foo
    ! work_tree_exists foo
}

@test "delete with branch and work_tree already removed" {
    git-bd foo

    git branch -d foo
    rm -rf "$TEMPDIR/foo"

    bd_registered foo
    run git-bd -df foo
    test "$status" -eq 0
    ! bd_registered foo
    ! branch_exists foo
    ! work_tree_exists foo
}

@test "delete with branch already removed" {
    git-bd foo
    bd_exists foo

    git branch -d foo

    bd_registered foo
    work_tree_exists foo
    run git-bd -df foo
    test "$status" -eq 0
    ! bd_registered foo
    ! branch_exists foo
    ! work_tree_exists foo
}

@test "delete with work_tree already removed" {
    git-bd foo
    rm -rf "$TEMPDIR/foo"

    bd_registered foo
    branch_exists foo
    run git-bd -df foo
    test "$status" -eq 0
    ! bd_registered foo
    ! branch_exists foo
    ! work_tree_exists foo
}

@test "repeated deletes" {
    git-bd foo
    cd "$TEMPDIR/foo"
    echo foo > README.md
    git commit -m 'foo' README.md
    cd "$TEMPDIR/master"
    run git-bd -df foo
    test "$status" -ne 0
    ! work_tree_exists foo
    branch_exists foo
    git branch -f foo master
    run git-bd -df foo
    test "$status" -eq 0
    ! branch_exists foo
}
