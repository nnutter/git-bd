#!/usr/bin/make -f

ifdef DESTDIR
prefix ?= /usr
sysconfdir ?= /etc
else
prefix ?= /usr/local
sysconfdir ?= $(prefix)/etc
endif

exec_prefix ?= $(prefix)

bindir ?= $(exec_prefix)/bin
datadir ?= $(prefix)/share
bashrc ?= $(datadir)/git-bd.bashrc

profiledir = $(sysconfdir)/profile.d
profile = $(profiledir)/git-bd.sh

mandir = $(prefix)/share/man

PROFILE_SH=\
'if [ -n "$${BASH_VERSION}" ]\n'\
'then\n'\
'source $(bashrc)\n'\
'fi'

build:

clean:
	@rm -f git-bd.1

git-bd.1: git-bd.md
	@pandoc -s -t man git-bd.md -o git-bd.1

docs: git-bd.1

caveats:
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
	@install -d $(DESTDIR)$(bindir)
	@install git-bd $(DESTDIR)$(bindir)/git-bd
	@install git-new-workdir $(DESTDIR)$(bindir)/git-new-workdir
	@install -d $(DESTDIR)$(datadir)
	@install git-bd.bashrc $(DESTDIR)$(bashrc)
	@install -d $(DESTDIR)$(profiledir)
	@echo $(PROFILE_SH) | sed 's/^ *//' > $(DESTDIR)$(profile)

install-docs: docs
	@install git-bd.1 $(DESTDIR)$(mandir)/man1/git-bd.1

all: install caveats

.PHONY: all caveats install build clean docs install-docs
