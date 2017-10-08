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
    default  = "192.168.1.100"
}

variable "ip-oob-outside" {
    description = "oob instance - ip for outside network"
    default  = "192.168.0.100"
}

variable "oob-instance" {
    description = "oob-instance name"
    default  = "OOB-Instance"
}
