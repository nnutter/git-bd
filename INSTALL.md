# Install with [Homebrew][] (Mac OS X only)

If you have [Homebrew][] installed you can easily install `git-bd`:

    brew tap nnutter/homebrew-misc
    brew install git-bd

Pay attention to the caveat about modifying your `~/.bash_profile`.

[Homebrew]: http://brew.sh

# Install with PPA (Ubuntu only)

    sudo add-apt-repository ppa:nnutter/git-bd
    sudo apt-get update
    sudo apt-get install git-bd

# Install using Makefile

You can install from source using `make`:

    PREFIX=/usr/local
    mkdir -p $PREFIX
    make prefix=$PREFIX

# Install manually

1. Put `git-bd` and `git-new-workdir` in your `PATH` and ensure it is executable.
2. Source `bd.bashrc` in your `~/.bashrc` to add Bash completion for `git bd` and to add a Bash function, `bd`, to switch between branchdirs.
3. To setup a repo to use `git bd --init`.

    For example:

        mkdir git-bd
        git clone https://github.com/nnutter/git-bd.git master
        cd master
        git bd --init

# Install from npm

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
