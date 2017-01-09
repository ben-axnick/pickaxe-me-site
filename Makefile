STACK_NAME = pickaxe-me-site

.PHONY: create
deploy:
	bundle exec stackup $(STACK_NAME) up --template cf.yml

.PHONY: clean
clean:
	bundle exec stackup $(STACK_NAME) delete

.PHONY: build
build:
	bundle exec jekyll build --source src --destination build

.PHONY: watch
watch:
	bundle exec jekyll build --source src --destination build --watch

.PHONY: dev
dev:
	docker-compose up -d

.PHONY: sync
sync:
	aws s3 sync $(PWD)/build/ s3://pickaxe.me \
		--acl public-read \
		--cache-control "max-age=10"
