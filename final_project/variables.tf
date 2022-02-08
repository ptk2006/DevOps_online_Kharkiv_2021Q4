variable "my_tenant_id" {
  default = "2f6cfcdb-b0fe-417f-b8d9-0c6623467e0f"
}
variable "my_subscription_id" {
  default = "f8a4d934-9d37-4994-b69c-c7f4c4b9cc72"
}
variable "resource_prefix" {
  default     = "tf-"
  description = "Use also for fqdn. Only lowercase letters, numbers and hyphens"
}
variable "resource_location" {
  default = "West Europe"
}
variable "node_count" {
  default     = "3"
  description = "First will be Jenkins, other NGINXes"
}
variable "vm_size" {
  default = "Standard_B1s"
}
variable "host_admin" {
  default = "vmadm"
}
variable "environment" {
  default = "My_test_task"
}
variable "vnet_space" {
  default = "10.10.10.0/24"
}