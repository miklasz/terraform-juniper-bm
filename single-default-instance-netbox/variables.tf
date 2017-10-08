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

variable "internet-access" {
    default  = "internet-access-network"
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
    description = "dc1.8x16"
    default  = "af2a80fe-ccad-43df-8cae-6418da948467"
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
