DEBIAN_VERSIONS:=debian-stretch debian-buster
UBUNTU_VERSIONS:=ubuntu-xenial ubuntu-bionic ubuntu-cosmic ubuntu-disco
DISTROS:=$(DEBIAN_VERSIONS) $(UBUNTU_VERSIONS)

PACKAGE:=$(shell awk -F ': ' '$$1 == "Source" { print $$2; exit }' common/control)
VERSION:=$(if $(wildcard source.tgz),$(shell tar -xOf source.tgz $(PACKAGE)/VERSION),)

UPSTREAM:=$(realpath $(CURDIR)/../components)

.PHONY: help
help: ## list make targets
	@awk 'BEGIN { FS = ":.*?## " } /^[a-zA-Z_-]+:.*?## / { sub("\\\\n", sprintf("\n%22c", " "), $$2); printf " %-20s  %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

.PHONY: clean
clean: ## remove build artifacts
	find . -mindepth 1 -maxdepth 1 -type d \! -name 'common' -exec rm -rf {} \;
	rm --recursive --force source.tgz $(PACKAGE)_*

.PHONY: ubuntu
ubuntu: $(UBUNTU_VERSIONS) ## build all ubuntu deb packages

.PHONY: debian
debian: $(DEBIAN_VERSIONS) ## build all debian deb packages

.PHONY: deb
deb: ubuntu debian ## build all deb packages

.PHONY: $(DISTROS)
$(DISTROS): source.tgz
	$(CURDIR)/package --distribution $(@:debian-%=%) $(VERSION)

source.tgz:
	$(MAKE) --directory $(UPSTREAM) archive ARCHIVE=$(CURDIR)/source.tgz
