#!/usr/bin/make -f

prefix ?= /usr/local
exec_prefix ?= $(prefix)

bindir ?= $(exec_prefix)/bin
sysconfdir ?= $(prefix)/etc

install:
	mkdir -p $(bindir)
	install git-bd $(bindir)/git-bd
	install git-new-workdir $(bindir)/git-new-workdir
	mkdir -p $(sysconfdir)
	install bd.bashrc $(sysconfdir)/git-bd.bashrc
