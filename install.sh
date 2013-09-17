#!/bin/sh
echo '
Run these commands if you installed globally with -g
  echo PATH=\$PATH:`npm -g list --parseable git-new-workdir | head -n1` >> ~/.bashrc
  echo . `npm -g list --parseable git-bd | head -n1`/bd.bashrc >> ~/.bashrc

Run these commands if you installed locally without -g
  echo PATH=\$PATH:`npm list --parseable git-bd | head -n1` >> ~/.bashrc
  echo PATH=\$PATH:`npm list --parseable git-new-workdir | head -n1` >> ~/.bashrc
  echo . `npm list --parseable git-bd | head -n1`/bd.bashrc >> ~/.bashrc
'
