% GIT-BD(1) git-bd 0.1.6 | git-bd User Manuals
% Nathaniel Nutter \<git-bd@nnutter.com\>
% January 27, 2014

# NAME

git-bd - working directories for your branches

# SYNOPSIS

git bd \<branchdir\> [\<start-point\>]  
git bd (-m | -M) \<oldbranchdir\> \<newbranchdir\>  
git bd (-d | -D) \<branchdir\>  

# DESCRIPTION

`git bd` mimics `git branch` in usage but `git bd` creates a separate working
directory for each branch.  The combination of a branch and working directory
is referred to as a *branchdir*.  *Branchdirs* allow you to have multiple
branches checked out simultaneously.

# OPTIONS

-m
:   Move/rename a branch.

-M
:   Move/rename a branch even if the new branch name already exists.

-d
:   Delete a branch. The branch must be fully merged in its upstream branch, or
    in HEAD if no upstream was set with --track or --set-upstream.

-D
:   Delete a branch irrespective of its merged status.

\--init
:   Initialize 'git bd' configuration.

# EXAMPLES

Initialize 'git bd' configuration by running 'git bd --init'.

Use 'git bd' instead of 'git branch' to create a separate working directory for
your branch:

    $ git bd my2.6.14 v2.6.14
    $ bd my2.6.14

# SEE ALSO

`git-branch` (1).

# BUGS

When deleting a branchdir the working directory is removed and then the branch.
If the branch fails to be removed, e.g. because Git thinks it's not merged,
then you will need to remove the branch manually.

# COPYRIGHT

Copyright (c) 2013, Nathaniel Nutter

This is free documentation; you can redistribute it and/or
modify it under the terms of the GNU General Public License as
published by the Free Software Foundation; either version 2 of
the License, or (at your option) any later version.

The GNU General Public License's references to "object code"
and "executables" are to be interpreted as the output of any
document formatting or typesetting system, including
intermediate and printed output.

This manual is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public
License along with this manual; if not, see
\<http://www.gnu.org/licenses/\>.
