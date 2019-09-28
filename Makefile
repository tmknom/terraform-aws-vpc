# https://github.com/tmknom/template-terraform-module
TERRAFORM_VERSION := 0.12.9
-include .Makefile.terraform

.Makefile.terraform:
	curl -sSL https://raw.githubusercontent.com/tmknom/template-terraform-module/master/Makefile.terraform -o .Makefile.terraform

MINIMAL_DIR := ./examples/minimal
COMPLETE_DIR := ./examples/complete
SINGLE_NAT_GATEWAY_DIR := ./examples/single_nat_gateway
DISABLED_NAT_GATEWAY_DIR := ./examples/disabled_nat_gateway

terraform-plan-minimal: ## Run terraform plan examples/minimal
	$(call terraform,${MINIMAL_DIR},init)
	$(call terraform,${MINIMAL_DIR},plan)

terraform-apply-minimal: ## Run terraform apply examples/minimal
	$(call terraform,${MINIMAL_DIR},apply)

terraform-destroy-minimal: ## Run terraform destroy examples/minimal
	$(call terraform,${MINIMAL_DIR},destroy)

terraform-plan-complete: ## Run terraform plan examples/complete
	$(call terraform,${COMPLETE_DIR},init)
	$(call terraform,${COMPLETE_DIR},plan)

terraform-apply-complete: ## Run terraform apply examples/complete
	$(call terraform,${COMPLETE_DIR},apply)

terraform-destroy-complete: ## Run terraform destroy examples/complete
	$(call terraform,${COMPLETE_DIR},destroy)

terraform-plan-single-nat-gateway: ## Run terraform plan examples/single_nat_gateway
	$(call terraform,${SINGLE_NAT_GATEWAY_DIR},init)
	$(call terraform,${SINGLE_NAT_GATEWAY_DIR},plan)

terraform-apply-single-nat-gateway: ## Run terraform apply examples/single_nat_gateway
	$(call terraform,${SINGLE_NAT_GATEWAY_DIR},apply)

terraform-destroy-single-nat-gateway: ## Run terraform destroy examples/single_nat_gateway
	$(call terraform,${SINGLE_NAT_GATEWAY_DIR},destroy)

terraform-plan-disabled-nat-gateway: ## Run terraform plan examples/disabled_nat_gateway
	$(call terraform,${DISABLED_NAT_GATEWAY_DIR},init)
	$(call terraform,${DISABLED_NAT_GATEWAY_DIR},plan)

terraform-apply-disabled-nat-gateway: ## Run terraform apply examples/disabled_nat_gateway
	$(call terraform,${DISABLED_NAT_GATEWAY_DIR},apply)

terraform-destroy-disabled-nat-gateway: ## Run terraform destroy examples/disabled_nat_gateway
	$(call terraform,${DISABLED_NAT_GATEWAY_DIR},destroy)
