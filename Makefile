IMAGE_NAME ?= srsolutions/ilias-dev

IMAGES = \
	7/php7.3-apache \
	7/php7.4-apache \
	8/php7.4-apache \
	8/php8.0-apache \
	9/php8.1-apache \
	9/php8.2-apache \
	10-alpha/php8.2-apache \
	10-alpha/php8.3-apache

LATEST = 9/php8.2-apache

variant = $$(basename $1)
branch  = $$(basename $$(dirname $1))
tag     = $$(echo $1 | sed 's|/|-|')

.ONESHELL:

all: $(IMAGES) tag

.PHONY: $(IMAGES)
$(IMAGES):
	@variant=$(call variant,$@)
	@branch=$(call branch,$@)
	@echo "Building $(IMAGE_NAME):$$branch-$$variant"
	docker build --rm \
		-f $$branch/Dockerfile \
		--build-arg ILIAS_VERSION=$$branch-$$variant \
		-t $(IMAGE_NAME):$$branch-$$variant \
		.

.PHONY: tag
tag: $(LATEST)
	@for i in $(IMAGES); do \
		variant=$(call variant,$$i);
		branch=$(call branch,$$i);
		tag=$(call tag,$$i);
		echo "Tagging $(IMAGE_NAME):$$tag as $(IMAGE_NAME):$$branch"; \
		docker tag $(IMAGE_NAME):$$tag $(IMAGE_NAME):$$branch; \
	done
	@latest=$(IMAGE_NAME):$(call tag,$(LATEST))
	@echo "Tagging $$latest as latest"
	docker tag $$latest $(IMAGE_NAME):latest

.PHONY: push
push:
	docker push -a $(IMAGE_NAME)
