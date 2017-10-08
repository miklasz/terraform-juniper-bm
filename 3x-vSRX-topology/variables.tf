#
#               AUTHENTICATION
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


#
#               SECURITY GROUP & RULES
#


variable "security_group1" {
    description = "security group description"
    default     = "datacentred"
}
variable "security_group_description" {
    default = "DataCentred-Access-Only"
}


#
#               vSRX NETWORK
#


variable "vsrx1_to_vsrx2" {
    default  = "vSRX1_to_vSRX2"
}
variable "vsrx2_to_vsrx3" {
    default  = "vSRX2_to_vSRX3"
}
variable "vsrx3_to_vsrx1" {
    default  = "vSRX3_to_vSRX1"
}
variable "instance1_to_vsrx1" {
    default  = "instance1_to_vsrx1"
}
variable "instance2_to_vsrx2" {
    default  = "instance2_to_vsrx2"
}
variable "instance3_to_vsrx3" {
    default  = "instance3_to_vsrx3"
}


#
#               OOB NETWORK
#


variable "oob-network-external" {
    default  = "oob-network-external"
}
variable "oob-network-internal" {
    default  = "oob-network-internal"
}


#
#               vSRX SUBNET
#


variable "subnet_1_lan" {
    default  = "10.1.1.0/24"
}
variable "subnet_2_lan" {
    default  = "10.2.2.0/24"
}
variable "subnet_3_lan" {
    default  = "10.3.3.0/24"
}


#
#   vSRX - INSTANCES SUBNET
#

variable "subnet_4_lan" {
    default  = "192.168.1.0/24"
}
variable "subnet_5_lan" {
    default  = "192.168.2.0/24"
}
variable "subnet_6_lan" {
    default  = "192.168.3.0/24"
}



#
#   OOB - SUBNET
#
variable "subnet_7_lan" {
    default  = "192.168.10.0/24"
}
variable "subnet_8_lan" {
    default  = "10.0.0.0/24"
}


#
#   GENERAL NETWORKING
#


variable "dns" {
    default  = "8.8.8.8"
}


#
#   vSRX - IP
#

# vSRX1
variable "vsrx1_port1_name" {
    description = "vsrx1_port1_name"
    default  = "vsrx1 port1 to vsrx2 port1"
}
variable "subnet_1_lan_1" {
    description = "network vsrx1-vsrx2"
    default  = "10.1.1.1"
}
variable "vsrx1_port2_name" {
    description = "vsrx1_port2_name"
    default  = "vsrx1 port2 to vsrx3 port2"
}
variable "subnet_3_lan_2" {
    description = "network vsrx3-vsrx1"
    default  = "10.3.3.2"
}
variable "vsrx1_port3_name" {
    description = "vsrx1_port3_name"
    default  = "vsrx1 port3 to instance1 port1"
}
variable "subnet_4_lan_3" {
    description = "network instance1_to_vsrx1"
    default  = "192.168.1.1"
}


# vSRX2
variable "vsrx2_port1_name" {
    description = "vsrx2_port1_name"
    default  = "vsrx2 port1 to vsrx1 port1"
}
variable "subnet_1_lan_2" {
    description = "network vsrx2-vsrx1"
    default  = "10.1.1.2"
}
variable "vsrx2_port2_name" {
    description = "vsrx2_port2_name"
    default  = "vsrx2 port2 to vsrx3 port1"
}
variable "subnet_2_lan_1" {
    description = "network vsrx2-vsrx3"
    default  = "10.2.2.1"
}
variable "vsrx2_port3_name" {
    description = "vsrx2_port3_name"
    default  = "vsrx2 port3 to instance2 port1"
}
variable "subnet_5_lan_3" {
    description = "network vsrx2-instance2"
    default  = "192.168.2.1"
}


# vSRX3
variable "vsrx3_port1_name" {
    description = "vsrx3_port1_name"
    default  = "vsrx3 port1 to vsrx2 port2"
}
variable "subnet_2_lan_2" {
    description = "network vsrx2-vsrx1"
    default  = "10.2.2.2"
}
variable "vsrx3_port2_name" {
    description = "vsrx3_port2_name"
    default  = "vsrx3 port2 to vsrx1 port2"
}
variable "subnet_3_lan_1" {
    description = "network vsrx3-vsrx1"
    default  = "10.3.3.1"
}
variable "vsrx3_port3_name" {
    description = "vsrx3_port3_name"
    default  = "vsrx3 port3 to instance3 port1"
}
variable "subnet_6_lan_3" {
    description = "network vsrx3-instance3"
    default  = "192.168.3.1"
}


#
#   ip setup between vSRX and instances
#

# instance1 to vsrx1
variable "instance1_port1_name" {
    description = "instance1_port1_name"
    default  = "instance1 port1 to vsrx1 port3"
}
variable "subnet_4_lan_1" {
    description = "network instance1_to_vsrx1"
    default  = "192.168.1.100"
}
# instance2 to vsrx2
variable "instance2_port1_name" {
    description = "instance2_port1_name"
    default  = "instance2 port1 to vsrx2 port3"
}
variable "subnet_5_lan_1" {
    description = "network instance2_to_vsrx2"
    default  = "192.168.2.100"
}
# instance3 to vsrx3
variable "instance3_port1_name" {
    description = "instance3_port1_name"
    default  = "instance3 port1 to vsrx3 port3"
}
variable "subnet_6_lan_1" {
    description = "network instance3_to_vsrx3"
    default  = "192.168.3.100"
}


#
#   ip setup OOB - NETWORK
#


# instance-oob to oob-instance-network
variable "subnet_7_lan10" {
    default  = "192.168.10.10"
}
# instance-oob to oob-network-internal
variable "subnet_8_lan10" {
    default  = "10.0.0.10"
}
# vsrx1 to oob-network-internal
variable "subnet_8_lan21" {
    default  = "10.0.0.21"
}

#
#   Instances
#
variable "vsrx-image" {
    description = "uploaded vsrx image"
    default  = "60370a34-dbda-4b5e-b7d0-0f84227b2309"
}
variable "vsrx-flavor" {
    description = "dc1.2x4.40"
    default  = "196235bc-7ca5-4085-ac81-7e0242bda3f9"
}

# vSRX1
variable "name-vsrx-1" {
    description = "vsrx1 name"
    default  = "vSRX-1"
}

# vSRX2
variable "name-vsrx-2" {
    description = "vsrx2 name"
    default  = "vSRX-2"
}

# vSRX3
variable "name-vsrx-3" {
    description = "vsrx3 name"
    default  = "vSRX-3"
}

#
#   internet_router
#
variable "openstack_router" {
    default  = "INTERNET-ROUTER"
}
variable "openstack_gateway" {
    default  = "6751cb30-0aef-4d7e-94c3-ee2a09e705eb"
}


/*
variable "ip-vsrx-3-mgmt" {
    description = "vsrx3 - ip for managment network"
    default  = "172.0.0.30"
}
*/
