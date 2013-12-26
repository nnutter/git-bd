#!/usr/bin/make -f

prefix ?= $(DESTDIR)/usr
exec_prefix ?= $(prefix)

bindir ?= $(exec_prefix)/bin
sysconfdir ?= $(DESTDIR)/etc

profiledir = $(sysconfdir)/profile.d

build:
	true

clean:
	true

install:
	@install -d $(bindir)
	@install git-bd $(bindir)/git-bd
	@install git-new-workdir $(bindir)/git-new-workdir
	@install -d $(profiledir)
	@install bd.bashrc $(profiledir)/git-bd.sh

.PHONY: all caveats install
