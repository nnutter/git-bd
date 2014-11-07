Running tests requires the [Bash Automated Testing System][1] which can be
easily installed from source and from Homebrew.

Once [BATS][1] is installed you can execute the test files directly, for example,

```
$ t/create.bats
 ✓ create succeeds without start point
 ✓ create succeeds with start point
 ✓ create fails when start point doesn't exist

3 tests, 0 failures
```

Since [BATS][1] can produce TAP output you can use it with `prove`, for example,

```
$ prove -j 4 --exec bats t/*.bats
t/branch_exists.bats ..... ok
t/bd_registered.bats ..... ok
t/create.bats ............ ok
t/bd_exists.bats ......... ok
t/setup.bats ............. ok
t/rename.bats ............ ok
t/work_tree_exists.bats .. ok
t/delete.bats ............ ok
All tests successful.
Files=8, Tests=29,  7 wallclock secs ( 0.05 usr  0.02 sys +  8.44 cusr  8.53 csys = 17.04 CPU)
Result: PASS
```

[1]: https://github.com/sstephenson/bats
