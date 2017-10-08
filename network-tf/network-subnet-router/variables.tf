#
#        AUTHENTICATION
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
#        NETWORK, SUBNET, DNS
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
#   internet_router
#
variable "internet_router" {
    default  = "INTERNET-ROUTER"
}
variable "openstack_gateway" {
    description = "external gateway id"
    default  = "6751cb30-0aef-4d7e-94c3-ee2a09e705eb"
}
