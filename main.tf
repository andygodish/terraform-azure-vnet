resource "azurerm_virtual_network" "this" {
  provider            = azurerm.subscription_provider
  location            = var.location
  name                = "vnet-${local.uniq_name}${var.sub_prefix}-${var.app_prefix}-${var.app_env}-${local.location_abbr[var.location]}"
  resource_group_name = var.resource_group_name
  address_space       = var.address_space

  dynamic "subnet" {
    for_each = { for s in var.subnets : s.name => s }
    content {
      name           = subnet.value.name
      address_prefix = subnet.value.address_prefix
    }
  }

  tags = merge(local.tags, var.tags)
}

