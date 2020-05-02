# https://github.com/tmknom/template-terraform-module
TERRAFORM_VERSION := 0.12.24
-include .Makefile.terraform

.Makefile.terraform:
	curl -sSL https://raw.githubusercontent.com/tmknom/template-terraform-module/0.2.6/Makefile.terraform -o .Makefile.terraform

MINIMAL_DIR := ./examples/minimal
COMPLETE_DIR := ./examples/complete
SINGLE_NAT_GATEWAY_DIR := ./examples/single_nat_gateway
DISABLED_NAT_GATEWAY_DIR := ./examples/disabled_nat_gateway

plan-minimal: ## Run terraform plan examples/minimal
	$(call terraform,${MINIMAL_DIR},init,)
	$(call terraform,${MINIMAL_DIR},plan,)

apply-minimal: ## Run terraform apply examples/minimal
	$(call terraform,${MINIMAL_DIR},apply,)

destroy-minimal: ## Run terraform destroy examples/minimal
	$(call terraform,${MINIMAL_DIR},destroy,)

plan-complete: ## Run terraform plan examples/complete
	$(call terraform,${COMPLETE_DIR},init,)
	$(call terraform,${COMPLETE_DIR},plan,)

apply-complete: ## Run terraform apply examples/complete
	$(call terraform,${COMPLETE_DIR},apply,)

destroy-complete: ## Run terraform destroy examples/complete
	$(call terraform,${COMPLETE_DIR},destroy,)

plan-single-nat-gateway: ## Run terraform plan examples/single_nat_gateway
	$(call terraform,${SINGLE_NAT_GATEWAY_DIR},init,)
	$(call terraform,${SINGLE_NAT_GATEWAY_DIR},plan,)

apply-single-nat-gateway: ## Run terraform apply examples/single_nat_gateway
	$(call terraform,${SINGLE_NAT_GATEWAY_DIR},apply,)

destroy-single-nat-gateway: ## Run terraform destroy examples/single_nat_gateway
	$(call terraform,${SINGLE_NAT_GATEWAY_DIR},destroy,)

plan-disabled-nat-gateway: ## Run terraform plan examples/disabled_nat_gateway
	$(call terraform,${DISABLED_NAT_GATEWAY_DIR},init,)
	$(call terraform,${DISABLED_NAT_GATEWAY_DIR},plan,)

apply-disabled-nat-gateway: ## Run terraform apply examples/disabled_nat_gateway
	$(call terraform,${DISABLED_NAT_GATEWAY_DIR},apply,)

destroy-disabled-nat-gateway: ## Run terraform destroy examples/disabled_nat_gateway
	$(call terraform,${DISABLED_NAT_GATEWAY_DIR},destroy,)
