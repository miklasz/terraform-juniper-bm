#
#    CONFIGURE OPEN STACK PROVIDER
#

provider "openstack" {
  tenant_name = "${var.openstack_project_name}"
  user_name = "${var.openstack_user_name}"
  password = "${var.openstack_password}"
  auth_url = "${var.openstack_auth_url}"
}

#
#    CREATE DATACENTRED SECURITY GROUP
#

resource "openstack_networking_secgroup_v2" "secgroup_1" {
  name        = "${var.security_group1}"
  description = "${var.security_group_description}"
}

#
#
#    DATACENTRED --- SECURITY RULES
#
#

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 1
  port_range_max    = 65535
  remote_ip_prefix  = "185.43.216.0/22"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_1.id}"
  depends_on        = ["openstack_networking_secgroup_v2.secgroup_1"]
}
resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_2" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 1
  port_range_max    = 65535
  remote_ip_prefix  = "185.98.148.0/22"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_1.id}"
  depends_on        = ["openstack_networking_secgroup_rule_v2.secgroup_rule_1"]
}
resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_3" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 1
  port_range_max    = 65535
  remote_ip_prefix  = "87.127.171.48/29"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_1.id}"
  depends_on        = ["openstack_networking_secgroup_rule_v2.secgroup_rule_2"]
}

#
#
#   CREATE - vSRX --- NETWORKS
#
#

# vSRX1 - vSRX2 network
resource "openstack_networking_network_v2" "network_1" {
  name           = "${var.vsrx1_to_vsrx2}"
  admin_state_up = "true"
  depends_on     = ["openstack_networking_secgroup_rule_v2.secgroup_rule_3"]
}
# vSRX2 - vSRX3 network
resource "openstack_networking_network_v2" "network_2" {
  name           = "${var.vsrx2_to_vsrx3}"
  admin_state_up = "true"
  depends_on     = ["openstack_networking_network_v2.network_1"]
}
# vSRX3 - vSRX1 network
resource "openstack_networking_network_v2" "network_3" {
  name           = "${var.vsrx3_to_vsrx1}"
  admin_state_up = "true"
  depends_on     = ["openstack_networking_network_v2.network_2"]
}
# instance connected to vsrx1
resource "openstack_networking_network_v2" "network_4" {
  name           = "${var.instance1_to_vsrx1}"
  admin_state_up = "true"
  depends_on     = ["openstack_networking_network_v2.network_3"]
}
# instance connected to vsrx2
resource "openstack_networking_network_v2" "network_5" {
  name           = "${var.instance2_to_vsrx2}"
  admin_state_up = "true"
  depends_on     = ["openstack_networking_network_v2.network_4"]
}
# instance connected to vsrx3
resource "openstack_networking_network_v2" "network_6" {
  name           = "${var.instance3_to_vsrx3}"
  admin_state_up = "true"
  depends_on     = ["openstack_networking_network_v2.network_5"]
}

#
#
#   CREATE - OOB --- NETWORKS
#
#

# oob-network-external
resource "openstack_networking_network_v2" "network_7" {
  name           = "${var.oob-network-external}"
  admin_state_up = "true"
  depends_on     = ["openstack_networking_network_v2.network_6"]
}
# oob-network-internal
resource "openstack_networking_network_v2" "network_8" {
  name           = "${var.oob-network-internal}"
  admin_state_up = "true"
  depends_on     = ["openstack_networking_network_v2.network_7"]
}


#
#
#   CREATE - vSRX --- SUBNETS
#
#

# vSRX1 - vSRX2 subnet
resource "openstack_networking_subnet_v2" "subnet_1" {
  network_id      = "${openstack_networking_network_v2.network_1.id}"
  cidr            = "${var.subnet_1_lan}"
  dns_nameservers = ["${var.dns}"]
  ip_version      = 4
  enable_dhcp     = false
  depends_on      = ["openstack_networking_network_v2.network_7"]
}

#vSRX2 - vSRX3 subnet
resource "openstack_networking_subnet_v2" "subnet_2" {
  network_id      = "${openstack_networking_network_v2.network_2.id}"
  cidr            = "${var.subnet_2_lan}"
  dns_nameservers = ["${var.dns}"]
  ip_version      = 4
  enable_dhcp     = false
  depends_on      = ["openstack_networking_subnet_v2.subnet_1"]
}

#vSRX3 - vSRX1 subnet
resource "openstack_networking_subnet_v2" "subnet_3" {
  network_id      = "${openstack_networking_network_v2.network_3.id}"
  cidr            = "${var.subnet_3_lan}"
  dns_nameservers = ["${var.dns}"]
  ip_version      = 4
  enable_dhcp     = false
  depends_on      = ["openstack_networking_subnet_v2.subnet_2"]
}

#
#
#   CREATE - INSTANCE --- SUBNETS
#
#

# instance1 subnet
resource "openstack_networking_subnet_v2" "subnet_4" {
  network_id      = "${openstack_networking_network_v2.network_4.id}"
  cidr            = "${var.subnet_4_lan}"
  dns_nameservers = ["${var.dns}"]
  ip_version      = 4
  enable_dhcp     = false
  depends_on      = ["openstack_networking_subnet_v2.subnet_3"]
}
# instance2 subnet
resource "openstack_networking_subnet_v2" "subnet_5" {
  network_id      = "${openstack_networking_network_v2.network_5.id}"
  cidr            = "${var.subnet_5_lan}"
  dns_nameservers = ["${var.dns}"]
  ip_version      = 4
  enable_dhcp     = false
  depends_on      = ["openstack_networking_subnet_v2.subnet_4"]
}
# instance3 subnet
resource "openstack_networking_subnet_v2" "subnet_6" {
  network_id      = "${openstack_networking_network_v2.network_6.id}"
  cidr            = "${var.subnet_6_lan}"
  dns_nameservers = ["${var.dns}"]
  ip_version      = 4
  enable_dhcp     = false
  depends_on      = ["openstack_networking_subnet_v2.subnet_5"]
}

#
#
#   CREATE OOB --- SUBNETS
#
#

# instance-oob oob-network-external subnet
resource "openstack_networking_subnet_v2" "subnet_7" {
  network_id      = "${openstack_networking_network_v2.network_7.id}"
  cidr            = "${var.subnet_7_lan}"
  dns_nameservers = ["${var.dns}"]
  ip_version      = 4
  enable_dhcp     = true
  depends_on      = ["openstack_networking_subnet_v2.subnet_6"]
}
# instance-oob oob-network-internal subnet
resource "openstack_networking_subnet_v2" "subnet_8" {
  network_id      = "${openstack_networking_network_v2.network_8.id}"
  cidr            = "${var.subnet_8_lan}"
  dns_nameservers = ["${var.dns}"]
  ip_version      = 4
  enable_dhcp     = true
  depends_on      = ["openstack_networking_subnet_v2.subnet_7"]
}

#
#
#    CREATE vSRX SUBNET --- PORTS
#
#

# vsrx1 port_1 to vsrx2 port_1
resource "openstack_networking_port_v2" "port_1" {
  name           = "${var.vsrx1_port1_name}"
  network_id     = "${openstack_networking_network_v2.network_1.id}"
  admin_state_up = "true"
  depends_on = ["openstack_networking_subnet_v2.subnet_8"]
  fixed_ip {
    "subnet_id"  = "${openstack_networking_subnet_v2.subnet_1.id}"
    "ip_address" = "${var.subnet_1_lan_1}"
  }
}
# vsrx2 port_1 to vsrx1 port_2
resource "openstack_networking_port_v2" "port_2" {
  name           = "${var.vsrx2_port1_name}"
  network_id     = "${openstack_networking_network_v2.network_1.id}"
  admin_state_up = "true"
  depends_on = ["openstack_networking_port_v2.port_1"]
  fixed_ip {
    "subnet_id"  = "${openstack_networking_subnet_v2.subnet_1.id}"
    "ip_address" = "${var.subnet_1_lan_2}"
  }
}
# vsrx2 port_2 to vsrx3 port_1
resource "openstack_networking_port_v2" "port_3" {
  name           = "${var.vsrx2_port2_name}"
  network_id     = "${openstack_networking_network_v2.network_2.id}"
  admin_state_up = "true"
  depends_on = ["openstack_networking_port_v2.port_2"]
  fixed_ip {
    "subnet_id"  = "${openstack_networking_subnet_v2.subnet_2.id}"
    "ip_address" = "${var.subnet_2_lan_1}"
  }
}
# vsrx3 port_1 to vsrx2 port_2
resource "openstack_networking_port_v2" "port_4" {
  name           = "${var.vsrx3_port1_name}"
  network_id     = "${openstack_networking_network_v2.network_2.id}"
  admin_state_up = "true"
  depends_on = ["openstack_networking_port_v2.port_3"]
  fixed_ip {
    "subnet_id"  = "${openstack_networking_subnet_v2.subnet_2.id}"
    "ip_address" = "${var.subnet_2_lan_2}"
  }
}
# vsrx3 port_2 to vsrx1 port_2
resource "openstack_networking_port_v2" "port_5" {
  name           = "${var.vsrx3_port2_name}"
  network_id     = "${openstack_networking_network_v2.network_3.id}"
  admin_state_up = "true"
  depends_on = ["openstack_networking_port_v2.port_4"]
  fixed_ip {
    "subnet_id"  = "${openstack_networking_subnet_v2.subnet_3.id}"
    "ip_address" = "${var.subnet_3_lan_1}"
  }
}
# vsrx1 port_2 to vsrx3 port_1
resource "openstack_networking_port_v2" "port_6" {
  name           = "${var.vsrx1_port2_name}"
  network_id     = "${openstack_networking_network_v2.network_3.id}"
  admin_state_up = "true"
  depends_on = ["openstack_networking_port_v2.port_5"]
  fixed_ip {
    "subnet_id"  = "${openstack_networking_subnet_v2.subnet_3.id}"
    "ip_address" = "${var.subnet_3_lan_2}"
  }
}
# vsrx1 port3 to instance1 port1
resource "openstack_networking_port_v2" "port_8" {
  name           = "${var.vsrx1_port3_name}"
  network_id     = "${openstack_networking_network_v2.network_4.id}"
  admin_state_up = "true"
  depends_on = ["openstack_networking_port_v2.port_6"]
  fixed_ip {
    "subnet_id"  = "${openstack_networking_subnet_v2.subnet_4.id}"
    "ip_address" = "${var.subnet_4_lan_3}"
  }
}
# vsrx2 port3 to instance1 port1
resource "openstack_networking_port_v2" "port_10" {
  name           = "${var.vsrx2_port3_name}"
  network_id     = "${openstack_networking_network_v2.network_5.id}"
  admin_state_up = "true"
  depends_on = ["openstack_networking_port_v2.port_8"]
  fixed_ip {
    "subnet_id"  = "${openstack_networking_subnet_v2.subnet_5.id}"
    "ip_address" = "${var.subnet_5_lan_3}"
  }
}
# vsrx3 port3 to instance1 port1
resource "openstack_networking_port_v2" "port_12" {
  name           = "${var.vsrx3_port3_name}"
  network_id     = "${openstack_networking_network_v2.network_6.id}"
  admin_state_up = "true"
  depends_on = ["openstack_networking_port_v2.port_10"]
  fixed_ip {
    "subnet_id"  = "${openstack_networking_subnet_v2.subnet_6.id}"
    "ip_address" = "${var.subnet_6_lan_3}"
  }
}

#
#
#    CREATE INSTANCES SUBNET --- PORTS
#
#

# instance1 connected to vsrx1
resource "openstack_networking_port_v2" "port_7" {
  name           = "${var.instance1_port1_name}"
  network_id     = "${openstack_networking_network_v2.network_4.id}"
  admin_state_up = "true"
  depends_on = ["openstack_networking_port_v2.port_12"]
  fixed_ip {
    "subnet_id"  = "${openstack_networking_subnet_v2.subnet_4.id}"
    "ip_address" = "${var.subnet_4_lan_1}"
  }
}
# instance2 connected to vsrx2
resource "openstack_networking_port_v2" "port_9" {
  name           = "${var.instance2_port1_name}"
  network_id     = "${openstack_networking_network_v2.network_5.id}"
  admin_state_up = "true"
  depends_on = ["openstack_networking_port_v2.port_7"]
  fixed_ip {
    "subnet_id"  = "${openstack_networking_subnet_v2.subnet_5.id}"
    "ip_address" = "${var.subnet_5_lan_1}"
  }
}
# instance3 connected to vsrx3
resource "openstack_networking_port_v2" "port_11" {
  name           = "${var.instance3_port1_name}"
  network_id     = "${openstack_networking_network_v2.network_6.id}"
  admin_state_up = "true"
  depends_on = ["openstack_networking_port_v2.port_7"]
  fixed_ip {
    "subnet_id"  = "${openstack_networking_subnet_v2.subnet_6.id}"
    "ip_address" = "${var.subnet_6_lan_1}"
  }
}

#
#
#    CREATE OOB SUBNET --- PORTS
#
#


# oob-network-external oob-instance
resource "openstack_networking_port_v2" "port_20" {
  name           = "${var.oob-network-external}"
  network_id     = "${openstack_networking_network_v2.network_7.id}"
  admin_state_up = "true"
  depends_on = ["openstack_networking_port_v2.port_11"]
  fixed_ip {
    "subnet_id"  = "${openstack_networking_subnet_v2.subnet_7.id}"
    "ip_address" = "${var.subnet_7_lan10}"
  }
}
# oob-network-internal oob-instance
resource "openstack_networking_port_v2" "port_21" {
  name           = "${var.oob-network-internal}"
  network_id     = "${openstack_networking_network_v2.network_8.id}"
  admin_state_up = "true"
  depends_on = ["openstack_networking_port_v2.port_20"]
  fixed_ip {
    "subnet_id"  = "${openstack_networking_subnet_v2.subnet_8.id}"
    "ip_address" = "${var.subnet_8_lan10}"
  }
}
# oob-network-internal to vsrx1
resource "openstack_networking_port_v2" "port_30" {
  name           = "${var.oob-network-internal}"
  network_id     = "${openstack_networking_network_v2.network_8.id}"
  admin_state_up = "true"
  depends_on = ["openstack_networking_port_v2.port_21"]
  fixed_ip {
    "subnet_id"  = "${openstack_networking_subnet_v2.subnet_8.id}"
    "ip_address" = "${var.subnet_8_lan21}"
  }
}



#
#
#    CREATE vSRX --- INSTANCES
#
#

# vSRX1
resource "openstack_compute_instance_v2" "vsrx1" {
  name            = "${var.name-vsrx-1}"
  image_id        = "${var.vsrx-image}"
  flavor_id       = "${var.vsrx-flavor}"
  key_pair        = ""
  security_groups = ["datacentred"]
  depends_on = ["openstack_networking_port_v2.port_21"]

  network {
    name = "${var.oob-network-internal}"
    port = "${openstack_networking_port_v2.port_30.id}"
  }
  network {
    name = "vSRX1_to_vSRX2"
    port = "${openstack_networking_port_v2.port_1.id}"
  }
  network {
    name = "vSRX3_to_vSRX1"
    port = "${openstack_networking_port_v2.port_6.id}"
  }
  network {
    name = "instance1_to_vsrx1"
    port = "${openstack_networking_port_v2.port_8.id}"
  }
  timeouts {
    create = "5m"
    delete = "2m"
  }
}

# vSRX2
resource "openstack_compute_instance_v2" "vsrx2" {
  name            = "${var.name-vsrx-2}"
  image_id        = "${var.vsrx-image}"
  flavor_id       = "${var.vsrx-flavor}"
  key_pair        = ""
  security_groups = ["datacentred"]
  depends_on = ["openstack_compute_instance_v2.vsrx1"]

  network {
    name = "vSRX1_to_vSRX2"
    port = "${openstack_networking_port_v2.port_2.id}"
  }
  network {
    name = "vSRX2_to_vSRX3"
    port = "${openstack_networking_port_v2.port_3.id}"
  }
  network {
    name = "instance2_to_vsrx2"
    port = "${openstack_networking_port_v2.port_10.id}"
  }

  timeouts {
    create = "5m"
    delete = "2m"
  }
}

# vsrx3
resource "openstack_compute_instance_v2" "vsrx3" {
  name            = "${var.name-vsrx-3}"
  image_id        = "${var.vsrx-image}"
  flavor_id       = "${var.vsrx-flavor}"
  key_pair        = ""
  security_groups = ["datacentred"]
  depends_on = ["openstack_compute_instance_v2.vsrx2"]

    network {
    name = "vSRX2_to_vSRX3"
    port = "${openstack_networking_port_v2.port_4.id}"
  }
  network {
    name = "vSRX3_to_vSRX1"
    port = "${openstack_networking_port_v2.port_5.id}"
  }
  network {
    name = "instance3_to_vsrx3"
    port = "${openstack_networking_port_v2.port_12.id}"
  }
  timeouts {
    create = "5m"
    delete = "2m"
  }
}

#
#
#    CREATE COMPUTE --- INSTANCES
#
#

resource "openstack_compute_instance_v2" "instance1" {
  name            = "instance1"
  image_id        = "73fb2fff-64bf-415f-82ec-b63bbb04b3cf"
  flavor_id       = "b671216b-1c68-4765-b752-0e8e6b6d015f"
  key_pair        = "BARTRON"
  security_groups = ["datacentred"]
  depends_on = ["openstack_compute_instance_v2.vsrx3"]

  network {
    name = "instance1_to_vsrx1"
    port = "${openstack_networking_port_v2.port_7.id}"
  }
  timeouts {
    create = "5m"
    delete = "2m"
  }
}

resource "openstack_compute_instance_v2" "instance2" {
  name            = "instance2"
  image_id        = "73fb2fff-64bf-415f-82ec-b63bbb04b3cf"
  flavor_id       = "b671216b-1c68-4765-b752-0e8e6b6d015f"
  key_pair        = "BARTRON"
  security_groups = ["datacentred"]
  depends_on = ["openstack_compute_instance_v2.instance1"]

  network {
    name = "instance2_to_vsrx2"
    port = "${openstack_networking_port_v2.port_9.id}"
  }
  timeouts {
    create = "5m"
    delete = "2m"
  }
}

resource "openstack_compute_instance_v2" "instance3" {
  name            = "instance3"
  image_id        = "73fb2fff-64bf-415f-82ec-b63bbb04b3cf"
  flavor_id       = "b671216b-1c68-4765-b752-0e8e6b6d015f"
  key_pair        = "BARTRON"
  security_groups = ["datacentred"]
  depends_on = ["openstack_compute_instance_v2.instance2"]

  network {
    name = "instance3_to_vsrx3"
    port = "${openstack_networking_port_v2.port_11.id}"
  }
  timeouts {
    create = "5m"
    delete = "2m"
  }
}

resource "openstack_compute_instance_v2" "oob-instance" {
  name            = "oob-instance"
  image_id        = "73fb2fff-64bf-415f-82ec-b63bbb04b3cf"
  flavor_id       = "b671216b-1c68-4765-b752-0e8e6b6d015f"
  key_pair        = "BARTRON"
  security_groups = ["datacentred"]
  depends_on = ["openstack_compute_instance_v2.instance3"]

  network {
    name = "${var.oob-network-external}"
    port = "${openstack_networking_port_v2.port_20.id}"
  }
  network {
    name = "${var.oob-network-internal}"
    port = "${openstack_networking_port_v2.port_21.id}"
  }
    timeouts {
    create = "5m"
    delete = "2m"
  }
}

#
#
#    CREATE NETWORK  --- ROUTER and INTERFACES
#
#

resource "openstack_networking_router_v2" "internet_router" {
  name = "${var.openstack_router}"
  admin_state_up   = "true"
  external_gateway = "${var.openstack_gateway}"
  depends_on       = ["openstack_compute_instance_v2.instance2"]
}

resource "openstack_networking_router_interface_v2" "router_interface_1" {
  router_id  = "${openstack_networking_router_v2.internet_router.id}"
  subnet_id  = "${openstack_networking_subnet_v2.subnet_7.id}"
  depends_on = ["openstack_networking_router_v2.internet_router"]
}

#
#
#    CREATE FLOATING --- IP
#
#

resource "openstack_networking_floatingip_v2" "fip_1" {
  pool = "external"
  depends_on = ["openstack_networking_router_interface_v2.router_interface_1"]
}

resource "openstack_compute_floatingip_associate_v2" "fip_1" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_1.address}"
  instance_id = "${openstack_compute_instance_v2.oob-instance.id}"
}

/*









# vsrx3 port_3 for mgnt
resource "openstack_networking_port_v2" "port_3" {
  name           = "vsrx-3-port_3"
  network_id     = "${openstack_networking_network_v2.network_4.id}"
  admin_state_up = "true"
  depends_on = ["openstack_networking_port_v2.port_2"]
  fixed_ip {
    "subnet_id"  = "${openstack_networking_subnet_v2.subnet_4.id}"
    "ip_address" = "${var.ip-vsrx-3-mgmt}"
  }
}

# vsrx1 port_4 for internet access
resource "openstack_networking_port_v2" "port_4" {
  name           = "vsrx-1-port_4"
  network_id     = "${openstack_networking_network_v2.network_5.id}"
  admin_state_up = "true"
  depends_on = ["openstack_networking_port_v2.port_3"]
  fixed_ip {
    "subnet_id"  = "${openstack_networking_subnet_v2.subnet_5.id}"
    "ip_address" = "${var.ip-vsrx-1-outside}"
  }
}

# vsrx2 port_5 for internet access
resource "openstack_networking_port_v2" "port_5" {
  name           = "vsrx-2-port_5"
  network_id     = "${openstack_networking_network_v2.network_5.id}"
  admin_state_up = "true"
  depends_on = ["openstack_networking_port_v2.port_4"]
  fixed_ip {
    "subnet_id"  = "${openstack_networking_subnet_v2.subnet_5.id}"
    "ip_address" = "${var.ip-vsrx-2-outside}"
  }
}

# vsrx3 port_6 for internet access
resource "openstack_networking_port_v2" "port_6" {
  name           = "vsrx-3-port_6"
  network_id     = "${openstack_networking_network_v2.network_5.id}"
  admin_state_up = "true"
  depends_on = ["openstack_networking_port_v2.port_5"]
  fixed_ip {
    "subnet_id"  = "${openstack_networking_subnet_v2.subnet_5.id}"
    "ip_address" = "${var.ip-vsrx-3-outside}"
  }
}

*/
