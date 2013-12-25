#!/usr/bin/make -f

prefix ?= /usr/local
exec_prefix ?= $(prefix)

bindir ?= $(exec_prefix)/bin
sysconfdir ?= $(prefix)/etc

install:
	install git-bd $(bindir)/git-bd
	install git-new-workdir $(bindir)/git-new-workdir
	install bd.bashrc $(sysconfdir)/git-bd.bashrc
