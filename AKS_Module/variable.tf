variable "resource_group_name" {
  description = "Name of the resource group to create for the AKS cluster"
}

variable "cluster_name" {
  description = "Name of the AKS cluster"
}

variable "location" {
  description = "Azure region where the resources will be deployed"
}