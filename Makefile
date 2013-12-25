#!/usr/bin/make -f

prefix ?= /usr/local
exec_prefix ?= $(prefix)

bindir ?= $(exec_prefix)/bin
sysconfdir ?= $(prefix)/etc

profiledir = $(sysconfdir)/profile.d

all: install caveat

caveat:
	@echo 'If $(profiledir)/*.sh are not already automatically sourced you should add the following to your ~/.bash_profile:'
	@echo
	@echo '  for script in $(profiledir)/*.sh; do'
	@echo '    if [ -r $$script ]; then'
	@echo '      source $$script'
	@echo '    fi'
	@echo '  done'
	@echo
	@echo "This will enable the use of the 'bd' command which makes it easy to switch between a repo's branchdirs. 'git-bd' is available regardless of whether you choose to do this."

install:
	@install -d $(bindir)
	@install git-bd $(bindir)/git-bd
	@install git-new-workdir $(bindir)/git-new-workdir
	@install -d $(profiledir)
	@install bd.bashrc $(profiledir)/git-bd.sh

.PHONY: all caveat install
