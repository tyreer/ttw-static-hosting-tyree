define GetTerraformConfig
$(shell jq .$1.value infrastructure/.terraform/output.json)
endef

set-branch:
ifndef CIRCLE_BRANCH
GIT_BRANCH=$(shell git rev-parse --abbrev-ref HEAD)
else
GIT_BRANCH=$(CIRCLE_BRANCH)
endif

set-stage: set-branch
STAGE = develop
ifeq ($(GIT_BRANCH),master)
STAGE = production
else ifeq ($(GIT_BRANCH),staging)
STAGE = staging
endif

set-env: set-branch set-stage
FRONTEND_BUCKET_REGION=$(call GetTerraformConfig,'FRONTEND_BUCKET_REGION')
FRONTEND_BUCKET_NAME=$(call GetTerraformConfig,'FRONTEND_BUCKET_NAME')

terraform-init: set-stage
	cd infrastructure && terraform init && terraform workspace new develop
	cd infrastructure && terraform init && terraform workspace new staging
	cd infrastructure && terraform init && terraform workspace new production

terraform: set-stage
	cd infrastructure && terraform init && terraform workspace select $(STAGE)
	cd infrastructure && terraform get && terraform apply -auto-approve && \
	terraform output -json > .terraform/output.json

frontend-deploy: set-env
	aws s3 sync \
		--region $(FRONTEND_BUCKET_REGION) \
		--acl public-read \
		--exclude "node_modules/*" \
		--exclude "*.map" \
		--cache-control 'public, max-age=31536000' \
		frontend/build \
		s3://$(FRONTEND_BUCKET_NAME)/

frontend-build:
	cd frontend && yarn build