IMAGE = sturai/ilias-dev

variants   = $(sort $(wildcard */*/Dockerfile))
unreleased = $(wildcard *alpha*/*/Dockerfile) $(wildcard *beta*/*/Dockerfile)

variant = $$(basename $$(dirname $1))
branch  = $$(basename $$(dirname $$(dirname $1)))

.ONESHELL:

all: $(variants) tag

.PHONY: $(variants)
$(variants):
	variant=$(call variant,$@)
	branch=$(call branch,$@)
	docker build --rm \
		-f $$branch/$$variant/Dockerfile \
		-t $(IMAGE):$$branch \
		-t $(IMAGE):$$branch-$$variant \
		.

.PHONY: tag
tag: $(variants)
	latest=$(lastword $(filter-out $(unreleased),$(variants)))
	variant=$(call variant,$$latest)
	branch=$(call branch,$$latest)
	docker tag $(IMAGE):$$branch-$$variant $(IMAGE):latest

.PHONY: push
push:
	docker push $(IMAGE)
