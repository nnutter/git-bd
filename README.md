# Documentation

- For usage, see [git-bd.md](https://github.com/nnutter/git-bd/blob/master/git-bd.md).
- For installation, see [INSTALL.md](https://github.com/nnutter/git-bd/blob/master/docs/INSTALL.md).
- For instruction on converting from `git-bd`'s predecessor, GBM, see [GBM.md](https://github.com/nnutter/git-bd/blob/master/docs/GBM.md).

# Caveats

Remember, almost everything that happens in Git can be undone. Don't panic!

- If you mix `git branch` and `git bd` for the same logical branch you will
  probably get confused due to the HEAD of the given branch moving out from
  underneath the branchdir.
- If you move your branchdir base repo you will have to repair broken symlinks.
  Some of which are normally broken.
