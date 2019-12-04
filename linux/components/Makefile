PREFIX?=/usr/local
PACKAGE:=environment

.PHONY: help
help: ## list make targets
	@awk 'BEGIN { FS = ":.*?## " } /^[a-zA-Z_-]+:.*?## / { sub("\\\\n", sprintf("\n%22c", " "), $$2); printf " %-20s  %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

.PHONY: install
install: ## install upstream

	# {bin,sbin}
	install -Dm 755 --target-directory $(DESTDIR)$(patsubst ,/usr,$(PREFIX))/bin bin/*

	# conffiles
	find etc -type f -exec install -Dm 644 {} $(DESTDIR)$(PREFIX)/{} \;

	# data files
	find usr -type f -exec install -Dm 644 {} $(DESTDIR)/{} \;

	# ensure ssh-client config file
	if [ ! -s $(DESTDIR)$(PREFIX)/etc/ssh/ssh_config ]; then \
		echo '# ssh-client configurations' > $(DESTDIR)$(PREFIX)/etc/ssh/ssh_config; \
	fi

	# link ssh-client configuration(s)
	if [ -z "$$(grep -E 'Include $(PREFIX)/etc/ssh/workspace$$' $(DESTDIR)$(PREFIX)/etc/ssh/ssh_config)" ]; then \
		echo '' 1>> $(PREFIX)/etc/ssh/ssh_config; \
		echo 'Include $(PREFIX)/etc/ssh/workspace' 1>> $(DESTDIR)$(PREFIX)/etc/ssh/ssh_config; \
	fi

.PHONY: authors
authors: ## list upstream contributors
	git log --format='%aN <%aE>' | LC_ALL=C.UTF-8 sort -uf | tee AUTHORS

.PHONY: update
update: ## update upstream components

	# components.csv
	while IFS="," read -r path url; do \
		mkdir --parent "$$(dirname --zero $$path)"; \
		curl --silent --fail --output "$$path" "$$url"; \
	done < components.csv

	# vim ftplugins
	mkdir --parent etc/vim/ftplugin
	curl --silent --fail "https://github.com/ashenm/workspace/tree/latest/filesystem/etc/vim/ftplugin" | \
		grep -oP '/ashenm/workspace/blob/latest/filesystem/etc/vim/ftplugin/\K[^"]{1,}' | while read -r plugin; do \
		curl -sfo "etc/vim/ftplugin/$$plugin" "https://raw.githubusercontent.com/ashenm/workspace/latest/filesystem/etc/vim/ftplugin/$$plugin"; \
	done

.PHONY: version
version: ## update upstream version
	@git tag --list --sort '-creatordate:raw' | awk '{ sub(/^v/, "", $$0); exit } END { sub(/^$$/, "1.0", $$0); print }' | tee VERSION

.PHONY: clean
clean: ## declutter upstream components
	find . -type d -empty -delete

.PHONY: purge
purge: ## remove upstream components

	# components.csv
	while IFS="," read -r path url; do \
		rm --recursive --force "$$(dirname --zero $$path)"; \
	done < components.csv

	# remove generated metadata
	rm --force AUTHORS VERSION

	# purge all empty directories
	find . -type d -empty -delete

archive: update version authors ## build upstream archive
	tar --create --xz --file $(if $(ARCHIVE),$(ARCHIVE),../$(PACKAGE)-$$(cat VERSION).txz) --transform 's/^\./$(PACKAGE)/' .
