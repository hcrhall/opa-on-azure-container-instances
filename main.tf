resource "random_pet" "dns_name_label" {
  keepers = {
    rg_id = azurerm_resource_group.rg.id
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "opa-on-azure-container-instances"
  location = "Australia East"
}

resource "azurerm_container_group" "cg" {
  name                = "opa"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_address_type     = "public"
  dns_name_label      = random_pet.dns_name_label.id
  os_type             = "Linux"

  container {
    name   = "opa"
    image  = "openpolicyagent/opa"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 8181
      protocol = "TCP"
    }

    commands = [
      "/opa",
      "run",
      "--server",
      "--log-level",
      "debug",
      "--config-file",
      "/src/opa/config/opa.yaml"
    ]

    volume {
      name       = "src"
      mount_path = "/src"
      git_repo {
        url = "https://github.com/hcrhall/opa-on-azure-container-instances"
        directory = "opa"
      }
    }
  }
}