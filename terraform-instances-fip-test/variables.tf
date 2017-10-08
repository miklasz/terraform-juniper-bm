#
# authentication
#

variable "openstack_user_name" {
    description = "bartosz@miklaszewski.com."
    default  = "bartosz@miklaszewski.com"
}

variable "openstack_project_name" {
    description = "test1"
    default  = "test1"
}

variable "openstack_password" {
    description = ""
    default  = ""
}

variable "openstack_auth_url" {
    description = "The endpoint url to connect to OpenStack."
    default  = "https://compute.datacentred.io:5000/v3.0"
}

variable "openstack_keypair_bartron" {
    description = "BARTRON"
    default  = "BARTRON"
}

variable "openstack_keypair_home" {
    description = "HOME"
    default  = "HOME"
}

variable "os_tenant_id" {
    description = "c0661a404bad4c0ca03125347264e378"
    default = "c0661a404bad4c0ca03125347264e378"
}

variable "openstack_domain_id" {
    description = "default"
    default  = "default"
}

variable "tenant_network" {
    description = "default"
    default  = "default"
}

#
# networks
#

variable "security_group1" {
    description = "security group description"
    default     = "datacentred"
}


variable "network_1_lan" {
    default  = "LAN-INSIDE-1"
}

variable "network_2_lan" {
    default  = "LAN-INSIDE-2"
}

variable "network_3_lan" {
    default  = "LAN-INSIDE-3"
}

variable "network_4_mgmt" {
    default  = "LAN-INSIDE-MGMT"
}

variable "network_5_vsrx" {
    default  = "vSRX-LAN-OUTSIDE"
}

variable "network_6_oob" {
    default  = "OOB-OUTSIDE"
}

#
# subnets / dns
#

variable "subnet_1_lan" {
    default  = "10.10.10.0/24"
}

variable "subnet_2_lan" {
    default  = "20.20.20.0/24"
}

variable "subnet_3_lan" {
    default  = "30.30.30.0/24"
}

variable "subnet_4_mgmt" {
    default  = "172.0.0.0/24"
}

variable "subnet_5_vsrx" {
    default  = "192.168.1.0/24"
}

variable "subnet_6_oob" {
    default  = "192.168.0.0/24"
}

variable "dns" {
    default  = "8.8.8.8"
}

variable "openstack_router" {
    default  = "INTERNET-ROUTER"
}

variable "oob_router" {
    default  = "OOB-ROUTER"
}

variable "openstack_gateway" {
    default  = "6751cb30-0aef-4d7e-94c3-ee2a09e705eb"
}

#
#   OOB - vSRX configuration / vSRX and OOB Instance
#

variable "vsrx-image" {
    description = "uploaded vsrx image"
    default  = "60370a34-dbda-4b5e-b7d0-0f84227b2309"
}

variable "vsrx-flavor" {
    description = "dc1.2x4.40"
    default  = "196235bc-7ca5-4085-ac81-7e0242bda3f9"
}

variable "name-vsrx-1" {
    description = "vsrx1 name"
    default  = "vSRX-1"
}

variable "name-vsrx-2" {
    description = "vsrx2 name"
    default  = "vSRX-2"
}

variable "name-vsrx-3" {
    description = "vsrx3 name"
    default  = "vSRX-3"
}

variable "oob-instance" {
    description = "oob-instance name"
    default  = "OOB-Instance"
}

variable "ip-vsrx-1-mgmt" {
    description = "vsrx1 - ip for managment network"
    default  = "172.0.0.10"
}

variable "ip-vsrx-2-mgmt" {
    description = "vsrx2 - ip for managment network"
    default  = "172.0.0.20"
}

variable "ip-vsrx-3-mgmt" {
    description = "vsrx3 - ip for managment network"
    default  = "172.0.0.30"
}

variable "ip-vsrx-1-outside" {
    description = "vsrx1 - ip for outside network"
    default  = "192.168.1.10"
}

variable "ip-vsrx-2-outside" {
    description = "vsrx2 - ip for outside network"
    default  = "192.168.1.20"
}

variable "ip-vsrx-3-outside" {
    description = "vsrx3 - ip for outside network"
    default  = "192.168.1.30"
}

variable "ip-oob-inside" {
    description = "oob instance - inside ip"
    default  = "172.0.0.100"
}

variable "ip-oob-outside" {
    description = "oob instance - ip for outside network"
    default  = "192.168.0.100"
}
#variable "openstack_gateway" {
#    default  = "6751cb30-0aef-4d7e-94c3-ee2a09e705eb"
#}












variable "openstack_floating_ip" {
    default  = "default"
}

variable "openstack_subnet_name" {
    default  = "dr-public-subnet-1a"
}

variable "cidr" {
    default  = "10.10.10.0/24"
}

variable "openstack_network_name" {
    default  = "dr-public-subnet-1a"
}
