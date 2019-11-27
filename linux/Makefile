help: ## list make targets
	@awk 'BEGIN { FS = ":.*?## " } /^[a-zA-Z_-]+:.*?## / { sub("\\\\n", sprintf("\n%22c", " "), $$2); printf " %-20s  %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

deb: ## build deb packages
	$(MAKE) --directory packaging deb

archive: ## build upstream archive
	$(MAKE) --directory components archive

clean: ## clean artifacts
	$(MAKE) --directory components clean
	$(MAKE) --directory packaging clean
