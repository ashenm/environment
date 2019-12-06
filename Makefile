.PHONY: build
build:
	$(MAKE) linux
	$(MAKE) windows

.PHONY: clean
clean:
	rm --force --recursive releases

.PHONY: install
install:
	sudo apt update && \
		sudo apt install --yes devscripts equivs lcab
	$(MAKE) --directory linux/packaging install

.PHONY: linux
linux: linux/components
	$(MAKE) --directory linux/packaging ubuntu

.PHONY: linux/components
linux/components:
	$(MAKE) --directory linux/components archive ARCHIVE=/dev/null

.PHONY: linux/binaries
linux/binaries:
	$(MAKE) --directory linux/packaging ubuntu PACKAGE_BINARY=true

.PHONY: windows
windows: windows/aliases
	lcab -nr windows/aliases windows/aliases.cab

.PHONY: windows/aliases
windows/aliases:
	mkdir --parent windows/aliases

.PHONY: version
version:
	@git tag --list --sort '-creatordate:raw' | awk '{ sub(/^v/, "", $$0); exit } END { sub(/^$$/, "1.0", $$0); print "v"$$0 }'

.PHONY: version++
version++:
	@git tag --list --sort '-creatordate:raw' | awk '{ sub(/^v/, "", $$0); exit } END { sub(/^$$/, "1.0", $$0); print "v"$$0 + 0.1 }'

.PHONY: release
release:
	git tag --force $${SIGNATURE_REFERENCE:+--sign} $${SIGNATURE_REFERENCE:+--user=}$${SIGNATURE_REFERENCE} $(shell make version++)
