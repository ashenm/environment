help: ## list make targets
	@awk 'BEGIN { FS = ":.*?## " } /^[a-zA-Z_-]+:.*?## / { sub("\\\\n", sprintf("\n%22c", " "), $$2); printf " %-20s  %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

.PHONY: deb
deb: ## build ubuntu packages
	$(MAKE) --directory packaging ubuntu

.PHONY: archive
archive: ## build upstream archive
	$(MAKE) --directory components archive

.PHONY: clean
clean: ## clean artifacts
	$(MAKE) --directory components clean
	$(MAKE) --directory packaging clean

.PHONY: purge
purge: clean
	$(MAKE) --directory components purge
	$(MAKE) --directory packaging purge
