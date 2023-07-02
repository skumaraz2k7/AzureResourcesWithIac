# Create an AKS cluster
resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.cluster_name
  kubernetes_version    = "1.25.6"
  sku_tier              = "Standard" 

  default_node_pool {
    name            = "agentpool"
    node_count      = 1
    vm_size         = "Standard_D2_v2"
    os_disk_size_gb = 30
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

data "azuread_service_principal" "aks_spi" {
  application_id = azurerm_kubernetes_cluster.aks_cluster.service_principal.0.client_id
}

resource "azurerm_role_assignment" "aksrole" {
  scope                = azurerm_kubernetes_cluster.aks_cluster.id
  role_definition_name = "Azure Kubernetes Service RBAC Cluster Admin"
  principal_id         = data.azuread_service_principal.aks_spi.id
}
