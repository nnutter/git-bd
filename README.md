# Description

`git bd` mimics `git branch` in usage but `git bd` creates a new working directory for each branch you create.  The combination of a branch and working directory is what I refer to as a *branchdir*.  *Branchdirs* allow you to have multiple branches checked out at once.

# Installation

## Install with [Homebrew][] (Mac OS X only)

If you have [Homebrew][] installed you can easily install `git-bd`:

    brew tap nnutter/homebrew-misc
    brew install git-bd

Pay attention to the caveat about modifying your `~/.bash_profile`.

[Homebrew]: http://brew.sh

## Install using Makefile

You can install from source using `make`:

    PREFIX=/usr/local
    mkdir -p $PREFIX
    make prefix=$PREFIX

## Install manually

1. Put `git-bd` and `git-new-workdir` in your `PATH` and ensure it is executable.
2. Source `bd.bashrc` in your `~/.bashrc` to add Bash completion for `git bd` and to add a Bash function, `bd`, to switch between branchdirs.
3. To setup a repo to use `git bd --init`.

    For example:

        mkdir git-bd
        git clone https://github.com/nnutter/git-bd.git master
        cd master
        git bd --init

## Install from npm

__npm install -g git-bd__

Run these commands if you installed globally with -g
```bash
echo PATH=\$PATH:`npm -g list --parseable git-new-workdir | head -n1` >> ~/.bashrc
echo . `npm -g list --parseable git-bd | head -n1`/bd.bashrc >> ~/.bashrc
```

Run these commands if you installed locally without -g
```bash
echo PATH=\$PATH:`npm list --parseable git-bd | head -n1` >> ~/.bashrc
echo PATH=\$PATH:`npm list --parseable git-new-workdir | head -n1` >> ~/.bashrc
echo . `npm list --parseable git-bd | head -n1`/bd.bashrc >> ~/.bashrc
```

# Caveats

Remember, almost everything that happens in Git can be undone. Don't panic!

- If you mix `git merge` or `git pull` with `git pull --rebase` you will probably regret it.
- If you mix `git branch` and `git bd` you will probably regret it.
- If you move your branchdir base repo you will have to repair broken symlinks. Some of which are "supposed" to be broken.

# Convert from `git-branchdir-manager`

This assumes you did not override `$GB_DEV_BRANCH`, `$GB_MASTER_DIR_NAME`, or `$GB_MASTER_BRANCH` which default to `master`, `.gb_master`, and `gb_master` respectively.

1. Commit all changes in all branches.  You can reset them off or interactive rebase later to fix them up.
2. Remove the existing branchdirs besides `.gb_master` which you should keep.
3. Move the `.gb_master` to `master`.
4. Change directories to `master`.
5. Run `git checkout master`.
6. Run `git bd --init`.  When prompted you may want to convert existing branches to branchdirs.  This will recreate the branchdirs you just removed but will also setup the tracking `git-bd` needs to be aware of them.
7. Run `git branch -D gb_master`.
