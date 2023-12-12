## Terraform Module Bootstrapper

A standardized way to quickly bootstrap a new Terraform module that fits the standards I use at work. 

### Quickstart

Create a new directory for your terraform module:

```
mkdir new-module && cd new-module
```

Run the docker container making sure to mount your new directory to the `/copy` directory of the container:

```
docker run -it -v $PWD:/copy andygodish/base-hashicorp-terraform-azure-1.6-bootstrap:latest
```

Then entrypoint of the container copies the module templates to the `/copy` directory, and the bind mount copies the files to your machine.

**Note** the files written to your PWD are set to an owner:group of 1000:1000. To change this, you'll need to build the image locally and provide the corresponding build args: 

```
docker build --build-arg UID=$(id -u) --build-arg GID=$(id -g)
```

### providers.tf

Verfy basic providers.tf file. Add more as needed by your module. 

### variables.tf

These are standard variables that are mostly used for the purposes of a standardized naming convention among all Azure resources. 

### locals.tf

Used primarily for naming convention. Add more to this as required by your module. 

### outputs.tf

A blank file required by the pre-commit-terraform tool. 

### Pre-Commit Terraform

- [Git Repo](https://github.com/antonbabenko/pre-commit-terraform)

A collection of git hooks for Terraform to be used with pre-commit framework.

Relevant files:

- .pre-commit-config.yaml
- tf-validate-fix.txt

#### TLDR

The following docker container execution (note the volume mount to the root of your module) will run a series of checks as defined by the `.pre-commit-config.yaml`, also found in the root of the terraform module. 

Before running, make sure you have made your first git commit. The linter makes a check against the .tf files found in the previous commit. 

```
TAG=latest

docker run -e "USERID=$(id -u):$(id -g)" -v $(pwd):/lint -w /lint ghcr.io/antonbabenko/pre-commit-terraform:$TAG run -a
```

Part of these checks will modify this README file between these lines found below:
```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.25.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm.subscription_provider"></a> [azurerm.subscription\_provider](#provider\_azurerm.subscription\_provider) | 3.84.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | CIDR for the VNET | `list(string)` | n/a | yes |
| <a name="input_app_env"></a> [app\_env](#input\_app\_env) | The env name: dev, qa, test or prod | `string` | n/a | yes |
| <a name="input_app_prefix"></a> [app\_prefix](#input\_app\_prefix) | The 3 or 4 character mnemonic for the application name | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The AZURE region location where this resource will be deployed to | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group name this private endpoint needs to be created in | `string` | n/a | yes |
| <a name="input_sub_prefix"></a> [sub\_prefix](#input\_sub\_prefix) | The 3 or 4 character mnemonic for this subscription | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | A list of subnets to create within the virtual network. | <pre>list(object({<br>    name           = string<br>    address_prefix = string<br>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | tags to be applied to resources | `map(string)` | `{}` | no |
| <a name="input_unique_name_string"></a> [unique\_name\_string](#input\_unique\_name\_string) | Provide this value if you want to create a unique name combination for this resource | `string` | `""` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.25.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm.subscription_provider"></a> [azurerm.subscription\_provider](#provider\_azurerm.subscription\_provider) | 3.84.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | CIDR for the VNET | `list(string)` | n/a | yes |
| <a name="input_app_env"></a> [app\_env](#input\_app\_env) | The env name: dev, qa, test or prod | `string` | n/a | yes |
| <a name="input_app_prefix"></a> [app\_prefix](#input\_app\_prefix) | The 3 or 4 character mnemonic for the application name | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The AZURE region location where this resource will be deployed to | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group name this private endpoint needs to be created in | `string` | n/a | yes |
| <a name="input_sub_prefix"></a> [sub\_prefix](#input\_sub\_prefix) | The 3 or 4 character mnemonic for this subscription | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | A list of subnets to create within the virtual network. | <pre>list(object({<br>    name           = string<br>    address_prefix = string<br>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | tags to be applied to resources | `map(string)` | `{}` | no |
| <a name="input_unique_name_string"></a> [unique\_name\_string](#input\_unique\_name\_string) | Provide this value if you want to create a unique name combination for this resource | `string` | `""` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->