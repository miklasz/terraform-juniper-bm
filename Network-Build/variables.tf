#
#
#        AUTHENTICATION
#
#
variable "openstack_user_name" {
    description = "edit ~/secret.tfvars"
    default  = ""
}
variable "openstack_project_name" {
    description = "edit ~/secret.tfvars"
    default  = ""
}
variable "openstack_password" {
    description = "edit ~/secret.tfvars"
    default  = ""
}
variable "openstack_auth_url" {
    description = "The endpoint url to connect to OpenStack."
    default  = "https://compute.datacentred.io:5000/v3.0"
}
#
#
#        NETWORK, SUBNET, DNS
#
#
variable "internet-access" {
    default  = "internet-access-network"
}
variable "subnet_1_lan" {
    default  = "10.1.1.0/24"
}
variable "dns" {
    default  = "8.8.8.8"
}
#
#
#   internet_router
#
#
variable "internet_router" {
    default  = "INTERNET-ROUTER"
}
variable "openstack_gateway" {
    description = "external gateway id"
    default  = "6751cb30-0aef-4d7e-94c3-ee2a09e705eb"
}
#
#
#               IP ADDRESSES
#
#
variable "security_group_rule1" {
    description = "alow subnet 185.43.216.0/22"
    default     = "185.43.216.0/22"
}
variable "security_group_rule2" {
    description = "alow subnet 185.98.148.0/22"
    default     = "185.98.148.0/22"
}
variable "security_group_rule3" {
    description = "alow all 0.0.0.0/0"
    default     = "0.0.0.0/0"
}
variable "security_group_rule4" {
    description = "alow barts subnet"
    default     = "87.127.171.49/29"
}
