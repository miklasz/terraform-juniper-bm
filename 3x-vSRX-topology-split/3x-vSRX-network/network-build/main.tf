provider "openstack" {
  tenant_name = "${var.openstack_project_name}"
  user_name = "${var.openstack_user_name}"
  password = "${var.openstack_password}"
  auth_url = "${var.openstack_auth_url}"
}

resource "openstack_networking_secgroup_v2" "secgroup_1" {
  name        = "${var.security_group1}"
  description = "DataCentred-Access-Only"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 1
  port_range_max    = 65535
  remote_ip_prefix  = "185.43.216.0/22"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_1.id}"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_2" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 1
  port_range_max    = 65535
  remote_ip_prefix  = "185.98.148.0/22"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_1.id}"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_3" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 1
  port_range_max    = 65535
  remote_ip_prefix  = "87.127.171.48/29"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_1.id}"
}

resource "openstack_networking_network_v2" "network_1" {
  name           = "${var.network_1_lan}"
  admin_state_up = "true"
}

resource "openstack_networking_network_v2" "network_2" {
  name           = "${var.network_2_lan}"
  admin_state_up = "true"
}

resource "openstack_networking_network_v2" "network_3" {
  name           = "${var.network_3_lan}"
  admin_state_up = "true"
}

resource "openstack_networking_network_v2" "network_4" {
  name           = "${var.network_4_mgmt}"
  admin_state_up = "true"
}

resource "openstack_networking_network_v2" "network_5" {
  name           = "${var.network_5_vsrx}"
  admin_state_up = "true"
}

resource "openstack_networking_network_v2" "network_6" {
  name           = "${var.network_6_oob}"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "subnet_1" {
  network_id      = "${openstack_networking_network_v2.network_1.id}"
  cidr            = "${var.subnet_1_lan}"
  dns_nameservers = ["${var.dns}"]
  ip_version      = 4
}

resource "openstack_networking_subnet_v2" "subnet_2" {
  network_id      = "${openstack_networking_network_v2.network_2.id}"
  cidr            = "${var.subnet_2_lan}"
  dns_nameservers = ["${var.dns}"]
  ip_version      = 4
}

resource "openstack_networking_subnet_v2" "subnet_3" {
  network_id      = "${openstack_networking_network_v2.network_3.id}"
  cidr            = "${var.subnet_3_lan}"
  dns_nameservers = ["${var.dns}"]
  ip_version      = 4
}

resource "openstack_networking_subnet_v2" "subnet_4" {
  network_id      = "${openstack_networking_network_v2.network_4.id}"
  cidr            = "${var.subnet_4_mgmt}"
  dns_nameservers = ["${var.dns}"]
  ip_version      = 4
}

resource "openstack_networking_subnet_v2" "subnet_5" {
  network_id      = "${openstack_networking_network_v2.network_5.id}"
  cidr            = "${var.subnet_5_vsrx}"
  dns_nameservers = ["${var.dns}"]
  ip_version      = 4
}

resource "openstack_networking_subnet_v2" "subnet_6" {
  network_id      = "${openstack_networking_network_v2.network_6.id}"
  cidr            = "${var.subnet_6_oob}"
  dns_nameservers = ["${var.dns}"]
  ip_version      = 4
}

#
# create router
#

resource "openstack_networking_router_v2" "internet_router" {
  name = "${var.openstack_router}"
  admin_state_up = "true"
  external_gateway = "${var.openstack_gateway}"
}

resource "openstack_networking_router_v2" "oob_router" {
  name = "${var.oob_router}"
  admin_state_up = "true"
  external_gateway = "${var.openstack_gateway}"
}

resource "openstack_networking_router_interface_v2" "router_interface_2" {
  router_id = "${openstack_networking_router_v2.internet_router.id}"
  subnet_id = "${openstack_networking_subnet_v2.subnet_5.id}"
}

resource "openstack_networking_router_interface_v2" "router_interface_3" {
  router_id = "${openstack_networking_router_v2.oob_router.id}"
  subnet_id = "${openstack_networking_subnet_v2.subnet_6.id}"
}

#
# build managment network
#

# vsrx1 port_1 for mgnt
resource "openstack_networking_port_v2" "port_1" {
  name           = "vsrx-1-port_1"
  network_id     = "${openstack_networking_network_v2.network_4.id}"
  admin_state_up = "true"
  fixed_ip {
    "subnet_id"  = "${openstack_networking_subnet_v2.subnet_4.id}"
    "ip_address" = "${var.ip-vsrx-1-mgmt}"
  }
}

# vsrx2 port_2 for mgnt
resource "openstack_networking_port_v2" "port_2" {
  name           = "vsrx-2-port_2"
  network_id     = "${openstack_networking_network_v2.network_4.id}"
  admin_state_up = "true"
  fixed_ip {
    "subnet_id"  = "${openstack_networking_subnet_v2.subnet_4.id}"
    "ip_address" = "${var.ip-vsrx-2-mgmt}"
  }
}

# vsrx3 port_3 for mgnt
resource "openstack_networking_port_v2" "port_3" {
  name           = "vsrx-3-port_3"
  network_id     = "${openstack_networking_network_v2.network_4.id}"
  admin_state_up = "true"
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
  fixed_ip {
    "subnet_id"  = "${openstack_networking_subnet_v2.subnet_5.id}"
    "ip_address" = "${var.ip-vsrx-3-outside}"
  }
}

# instance oob outside port_7
resource "openstack_networking_port_v2" "port_7" {
  name           = "${var.oob-instance}"
  network_id     = "${openstack_networking_network_v2.network_6.id}"
  admin_state_up = "true"
  fixed_ip {
    "subnet_id"  = "${openstack_networking_subnet_v2.subnet_6.id}"
    "ip_address" = "${var.ip-oob-outside}"
  }
}

# instance oob inside port_8
resource "openstack_networking_port_v2" "port_8" {
  name           = "${var.oob-instance}"
  network_id     = "${openstack_networking_network_v2.network_4.id}"
  admin_state_up = "true"
  fixed_ip {
    "subnet_id"  = "${openstack_networking_subnet_v2.subnet_4.id}"
    "ip_address" = "${var.ip-oob-inside}"
  }
}

resource "openstack_networking_floatingip_v2" "fip_1" {
  pool = "external"
}

resource "openstack_networking_floatingip_v2" "fip_2" {
  pool = "external"
}

resource "openstack_networking_floatingip_v2" "fip_3" {
  pool = "external"
}

resource "openstack_networking_floatingip_v2" "fip_4" {
  pool = "external"
}
