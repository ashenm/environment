include linux/packaging/Makefile.distros

.PHONY: build
build: linux/components
	$(MAKE) linux/ubuntu
	$(MAKE) windows

.PHONY: clean
clean:
	$(MAKE) --directory linux clean
	$(MAKE) --directory windows clean

.PHONY: purge
purge: clean
	$(MAKE) --directory linux purge
	$(MAKE) --directory windows purge

.PHONY: install
install:
	sudo apt update
	sudo apt install --yes --install-recommends \
		equivs \
		lcab \
		openssh-client \
		python3-paramiko \
		rsync \
		ubuntu-dev-tools
	$(MAKE) --directory linux/packaging install

.PHONY: linux/binaries
linux/binaries:
	$(MAKE) --directory linux/packaging ubuntu PACKAGE_BINARY=true

.PHONY: linux/debian
.SILENT: linux/debian
linux/debian:
	for DISTRO in $(DEBIAN_VERSIONS); do \
		test -z "$$TRAVIS" || echo "travis_fold:start:$$DISTRO"; \
		echo "\033[36mBuilding $$DISTRO\033[0m"; \
		$(MAKE) --directory linux/packaging $$DISTRO; \
		test -z "$$TRAVIS" || echo "travis_fold:end:$$DISTRO"; \
	done

.PHONY: linux/components
.SILENT: linux/components
linux/components:
	test -z "$$TRAVIS" || echo "travis_fold:start:linux_components"
	echo "\033[36mBuilding linux components\033[0m"
	$(MAKE) --directory linux/components archive ARCHIVE=/dev/null
	test -z "$$TRAVIS" || echo "travis_fold:end:linux_components"

.PHONY: linux/ubuntu
.SILENT: linux/ubuntu
linux/ubuntu:
	for DISTRO in $(UBUNTU_VERSIONS); do \
		test -z "$$TRAVIS" || echo "travis_fold:start:$$DISTRO"; \
		echo "\033[36mBuilding $$DISTRO\033[0m"; \
		$(MAKE) --directory linux/packaging $$DISTRO; \
		test -z "$$TRAVIS" || echo "travis_fold:end:$$DISTRO"; \
	done

.PHONY: windows
.SILENT: windows
windows:
	test -z "$$TRAVIS" || echo "travis_fold:start:windows"
	echo "\033[36mBuilding windows shims\033[0m"
	$(MAKE) --directory windows shims
	test -z "$$TRAVIS" || echo "travis_fold:end:windows"

.PHONY: version
version:
	@git tag --list --sort '-creatordate:raw' | awk '{ sub(/^v/, "", $$0); exit } END { sub(/^$$/, "1.0", $$0); print "v"$$0 }'

.PHONY: version++
version++:
	@git tag --list --sort '-creatordate:raw' | awk '{ sub(/^v/, "", $$0); exit } END { sub(/^$$/, "1.0", $$0); print "v"$$0 + 0.1 }'

.PHONY: release
release:
	git tag --force $${SIGNATURE_REFERENCE:+--sign} $${SIGNATURE_REFERENCE:+--local-user=}$${SIGNATURE_REFERENCE} --message '' $(shell make version++)
