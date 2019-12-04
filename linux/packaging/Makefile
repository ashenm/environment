DEBIAN_VERSIONS:=debian-stretch debian-buster
UBUNTU_VERSIONS:=ubuntu-bionic ubuntu-disco ubuntu-eoan
DISTROS:=$(DEBIAN_VERSIONS) $(UBUNTU_VERSIONS)

PACKAGE:=$(shell awk -F ': ' '$$1 == "Source" { print $$2; exit }' common/control)
VERSION:=$(if $(wildcard source.txz),$(shell tar -xJOf source.txz $(PACKAGE)/VERSION),)
REVISION:=1

UPSTREAM:=$(realpath $(CURDIR)/../components)

.PHONY: help
help: ## list make targets
	@awk 'BEGIN { FS = ":.*?## " } /^[a-zA-Z_-]+:.*?## / { sub("\\\\n", sprintf("\n%22c", " "), $$2); printf " %-20s  %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

.PHONY: clean
clean: ## remove build artifacts
	find . -mindepth 1 -maxdepth 1 -type d \! -name 'common' -exec rm -rf {} \;
	rm --recursive --force $(PACKAGE)_*

.PHONY: ubuntu
ubuntu: $(UBUNTU_VERSIONS) ## build all ubuntu deb packages

.PHONY: debian
debian: $(DEBIAN_VERSIONS) ## build all debian deb packages

.PHONY: deb
deb: ubuntu debian ## build all deb packages

.PHONY: $(DISTROS)
$(DISTROS): source.txz
	$(CURDIR)/package --distribution $(@:debian-%=%) --revision $(REVISION) $(VERSION)

source.txz:
	$(MAKE) --directory $(UPSTREAM) archive ARCHIVE=$(CURDIR)/source.txz
