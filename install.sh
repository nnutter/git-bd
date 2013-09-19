#!/bin/sh

####  ~/.bashrc.d/ shall now exist - useful hack to load many .bashrc files
mkdir -p ~/.bashrc.d/
SOURCE_RC_FILES='for file in ~/.bashrc.d/*; do source $file; done'
if ! fgrep -q "$SOURCE_RC_FILES" ~/.bashrc; then
  echo "$SOURCE_RC_FILES" >> ~/.bashrc
fi


####  Delete previous installation
INSTALL_PATH=~/.bashrc.d/git-bd.sh
cat /dev/null > $INSTALL_PATH


####  Install git-bd and the bd alias
echo PATH=\$PATH:`pwd` >> $INSTALL_PATH
echo source `pwd`/bd.bashrc >> $INSTALL_PATH


####  Inform the user of installation method
echo '
Success: git-bd environment settings are now in ~/.bashrc.d/git-bd.sh
Tip: ~/.bashrc.d/* are files loaded after your ~/.bashrc file.
Please restart your shell now, or source ~/.bashrc
'
