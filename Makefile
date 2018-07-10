IMAGE = sturai/ilias-dev
BRANCHES = 5.1 5.2 5.3

build = \
    docker build --rm \
        -t $(IMAGE):$(1) \
        -t $(IMAGE):$(1)-$(2) \
        $(1)/$(2)

.PHONY: build
build:
	for branch in $(BRANCHES); do \
		for variant in $$branch/*; do \
			variant=$$(basename $$variant); \
			$(call build,$$branch,$$variant); \
		done; \
	done; \
	docker tag $(IMAGE):$$branch $(IMAGE):latest
