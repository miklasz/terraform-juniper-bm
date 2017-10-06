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
#   Subnet / Network / Router / Port
#
#
variable "internet-access" {
    default  = "internet-access-network"
}
variable "openstack_router" {
    default  = "INTERNET-ROUTER"
}
variable "openstack_gateway" {
    default  = "6751cb30-0aef-4d7e-94c3-ee2a09e705eb"
}
#
#
# vSRX1 instance
#
#
variable "name-vsrx-1" {
    description = "vsrx1.v15.d100-base-ssh-dhcp"
    default  = "vSRX-1"
}
variable "vsrx-image" {
    description = "uploaded vsrx image vSRX D100"
//    default = "60370a34-dbda-4b5e-b7d0-0f84227b2309" #d70-stock-image
//    default = "953449fd-c741-4604-a2ca-f03dc4552809" #d100-stock-image
//    default = "e573420d-ef84-4f73-b76a-0146a3252d63" #d100-base-ssh-dhcp
//    default = "e5c199fa-3a2d-448a-a8d5-4c3e65aec2c4" #d40.6-stock-image
//    default = "5f96664d-e104-4f8d-ba86-50cd8b24975c" #d40-base-ssh-dhcp
    default = "3d746617-3854-4700-95d4-70c8fa2a3c14" #d20-base-ssh-dhcp
}
variable "vsrx-flavor" {
    description = "dc1.4x8.80.broadwell"
    default  = "e662d462-a43d-4dc8-9a82-90a81364771a"
}
