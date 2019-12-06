help: ## list make targets
	@awk 'BEGIN { FS = ":.*?## " } /^[a-zA-Z_-]+:.*?## / { sub("\\\\n", sprintf("\n%22c", " "), $$2); printf " %-20s  %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

.PHONY: shims
shims: ## build shims archive
	mkdir --parent $(CURDIR)/aliases
	lcab -nr $(CURDIR)/aliases $(CURDIR)/aliases.cab

.PHONY: clean
clean: ## clean artifacts
	rm --force $(CURDIR)/aliases.cab

.PHONY:
purge:
