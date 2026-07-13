# Configure the Terraform runtime requirements.
terraform {
  required_version = ">= 1.1.0"

  required_providers {
    # Azure Resource Manager provider and version
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.3"
    }
  }

}

# Define providers and their config params
provider "azurerm" {
  # Leave the features block empty to accept all defaults
  features {}
}

provider "cloudinit" {
  # Configuration options
}

variable "labelPrefix" {
  type    = string
  default = "jccst8918"
}
variable "region" {
  type    = string
  default = "canadacentral"
}

resource "azurerm_resource_group" "main" {
  name     = "${var.labelPrefix}-A06-RG"
  location = var.region
  tags = {
    Class      = "CST8918"
    Assignment = "Lab"
    Lab        = "A06"
  }

}

resource "azurerm_storage_account" "example" {
  name                     = "${var.labelPrefix}storage"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = var.region
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind  = "BlobStorage"
  access_tier   = "Cool"
}