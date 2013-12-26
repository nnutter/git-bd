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

PROFILE_SH=\
'if [ -n "$${BASH_VERSION}" ]\n'\
'then\n'\
'source $(bashrc)\n'\
'fi'

build:
	true

clean:
	true

install:
	@install -d $(DESTDIR)$(bindir)
	@install git-bd $(DESTDIR)$(bindir)/git-bd
	@install git-new-workdir $(DESTDIR)$(bindir)/git-new-workdir
	@install -d $(DESTDIR)$(datadir)
	@install git-bd.bashrc $(DESTDIR)$(bashrc)
	@install -d $(DESTDIR)$(profiledir)
	@echo $(PROFILE_SH) | sed 's/^ *//' > $(DESTDIR)$(profile)

all: install caveats

.PHONY: all caveats install build clean
