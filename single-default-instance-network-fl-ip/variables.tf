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
#   Instance
#
variable "instance_name" {
    description = "NETBOX"
    default  = "netbox"
}
variable "instance_image_id" {
    description = "Ubuntu Server 16.04.2"
    default  = "73fb2fff-64bf-415f-82ec-b63bbb04b3cf"
}
variable "instance_flavor_id" {
    description = "dc1.2x4.40"
    default  = "b671216b-1c68-4765-b752-0e8e6b6d015f"
}
#
# this key is already within openstack, to add new key use (below example is a fake key):
# default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDAjpC1hwiOCCmKEWxJ4qzTTsJbKzndLotBCz5PcwtUnflmU+gHJtWMZKpuEGVi29h0A/+ydKek1O18k10Ff+4tyFjiHDQAnOfgWf7+b1yK+qDip3X1C0UPMbwHlTfSGWLGZqd9LvEFx9k3h/M+VtMvwR1lJ9LUyTAImnNjWG7TaIPmui30HvM2UiFEmqkr4ijq45MyX2+fLIePLRIF61p4whjHAQYufqyno3BS48icQb4p6iVEZPo4AE2o9oIyQvj2mx4dk5Y8CgSETOZTYDOR3rU2fZTRDRgPJDH9FWvQjF5tA0p3d9CoWWd2s6GKKbfoUIi8R/Db1BSPJwkqB"
#
# or if you want to use key from file use:
#
# your existing key in openstack
variable "key_pair" {
    default  = "HOME"
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
