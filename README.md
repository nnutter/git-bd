# Description

`git bd` mimics `git branch` in usage but `git bd` creates a new working directory for each branch you create.  The combination of a branch and working directory is what I refer to as a *branchdir*.  *Branchdirs* allow you to have multiple branches checked out at once.

# Installation

Put `git-bd` and `git-new-workdir` in your `PATH` and ensure it is executable.
Source `bd.bashrc` to add Bash completion for `git bd` and to add a Bash function, `bd`, to switch between branchdirs.
To setup a repo to use `git bd` with do:

    git config branchdir.base <dir>
    git config branchdir.git-dir <.gitdir>

For example:

    cd <REPO>
    mkdir bd
    git config branchdir.base "$PWD"/bd
    git config branchdir.git-dir "$(git rev-parse --git-dir)"
    echo bd >> .gitignore

# Caveats

Remember, almost everything that happens in Git can be undone. Don't panic!

- If you mix `git merge` or `git pull` with `git pull --rebase` you will probably regret it.
- If you mix `git branch` and `git bd` you will probably regret it.
- If you move your branchdir base repo you will have to repair broken symlinks. Some of which are "supposed" to be broken.
