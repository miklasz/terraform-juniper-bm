#
#    configure the openstack provider
#

provider "openstack" {
  tenant_name = "${var.openstack_project_name}"
  user_name = "${var.openstack_user_name}"
  password = "${var.openstack_password}"
  auth_url = "${var.openstack_auth_url}"
}

#
#    create default DataCentred Security Group
#


resource "openstack_networking_secgroup_v2" "secgroup_1" {
  name        = "${var.security_group1}"
  description = "DataCentred-Access-Only"
}

#
#    security rules - allow only datacentred ip class
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
#   create vSRX networks and ports for mgmt and internet access network
#

resource "openstack_networking_network_v2" "network_5" {
  name           = "${var.network_5_vsrx}"
  admin_state_up = "true"
  depends_on        = ["openstack_networking_secgroup_rule_v2.secgroup_rule_3"]
}

#
#    create subnets
#

resource "openstack_networking_subnet_v2" "subnet_5" {
  network_id      = "${openstack_networking_network_v2.network_5.id}"
  cidr            = "${var.subnet_5_vsrx}"
  dns_nameservers = ["${var.dns}"]
  ip_version      = 4
  depends_on      = ["openstack_networking_network_v2.network_5"]
}

#
#   create routers and interfaces for OOB and Internet access
#

resource "openstack_networking_router_v2" "internet_router" {
  name = "${var.openstack_router}"
  admin_state_up   = "true"
  external_gateway = "${var.openstack_gateway}"
  depends_on       = ["openstack_networking_subnet_v2.subnet_5"]
}

resource "openstack_networking_router_interface_v2" "router_interface_2" {
  router_id  = "${openstack_networking_router_v2.internet_router.id}"
  subnet_id  = "${openstack_networking_subnet_v2.subnet_5.id}"
  depends_on = ["openstack_networking_router_v2.internet_router"]
}

#
#    build ports
#

# vsrx1 port_1 for mgnt
resource "openstack_networking_port_v2" "port_1" {
  name           = "vsrx-1-port_1"
  network_id     = "${openstack_networking_network_v2.network_5.id}"
  admin_state_up = "true"
  depends_on = ["openstack_networking_router_interface_v2.router_interface_2"]
}

# vsrx2 port_2 for mgnt
resource "openstack_networking_port_v2" "port_2" {
  name           = "vsrx-2-port_2"
  network_id     = "${openstack_networking_network_v2.network_5.id}"
  admin_state_up = "true"
  depends_on = ["openstack_networking_port_v2.port_1"]
}

# vsrx3 port_3 for mgnt
resource "openstack_networking_port_v2" "port_3" {
  name           = "vsrx-3-port_3"
  network_id     = "${openstack_networking_network_v2.network_5.id}"
  admin_state_up = "true"
  depends_on = ["openstack_networking_port_v2.port_2"]
}

# vsrx1 port_4 for internet access
resource "openstack_networking_port_v2" "port_4" {
  name           = "vsrx-1-port_4"
  network_id     = "${openstack_networking_network_v2.network_5.id}"
  admin_state_up = "true"
  depends_on = ["openstack_networking_port_v2.port_3"]
}

#
#   pull floating IP's
#

resource "openstack_networking_floatingip_v2" "fip_1" {
  pool = "external"
  depends_on = ["openstack_networking_port_v2.port_4"]
}

resource "openstack_networking_floatingip_v2" "fip_2" {
  pool = "external"
  depends_on = ["openstack_networking_floatingip_v2.fip_1"]
}

resource "openstack_networking_floatingip_v2" "fip_3" {
  pool = "external"
  depends_on = ["openstack_networking_floatingip_v2.fip_2"]
}

resource "openstack_networking_floatingip_v2" "fip_4" {
  pool = "external"
  depends_on = ["openstack_networking_floatingip_v2.fip_3"]
  }


#
#   build instances
#

resource "openstack_compute_instance_v2" "vsrx1" {
  name            = "oob-instance1"
  image_id        = "73fb2fff-64bf-415f-82ec-b63bbb04b3cf"
  flavor_id       = "b671216b-1c68-4765-b752-0e8e6b6d015f"
  key_pair        = "BARTRON"
  security_groups = ["datacentred"]
  depends_on = ["openstack_networking_floatingip_v2.fip_4"]

  network {
    name = "vSRX-LAN-OUTSIDE"
  ##  port = "${openstack_networking_port_v2.port_1.id}"
  }

  timeouts {
    create = "5m"
    delete = "2m"
  }
}

resource "openstack_compute_instance_v2" "vsrx2" {
  name            = "oob-instance2"
  image_id        = "73fb2fff-64bf-415f-82ec-b63bbb04b3cf"
  flavor_id       = "b671216b-1c68-4765-b752-0e8e6b6d015f"
  key_pair        = "BARTRON"
  security_groups = ["datacentred"]
  depends_on = ["openstack_compute_instance_v2.vsrx1"]
  network {
    name = "vSRX-LAN-OUTSIDE"
    #port = "${openstack_networking_port_v2.port_2.id}"
  }

  timeouts {
    create = "5m"
    delete = "2m"
  }
}

resource "openstack_compute_instance_v2" "vsrx3" {
  name            = "oob-instance3"
  image_id        = "73fb2fff-64bf-415f-82ec-b63bbb04b3cf"
  flavor_id       = "b671216b-1c68-4765-b752-0e8e6b6d015f"
  key_pair        = "BARTRON"
  security_groups = ["datacentred"]
  depends_on = ["openstack_compute_instance_v2.vsrx2"]

  network {
    name = "vSRX-LAN-OUTSIDE"
    #port = "${openstack_networking_port_v2.port_3.id}"
  }
  timeouts {
    create = "5m"
    delete = "2m"
  }
}

resource "openstack_compute_instance_v2" "oob" {
  name            = "oob-instance4"
  image_id        = "73fb2fff-64bf-415f-82ec-b63bbb04b3cf"
  flavor_id       = "b671216b-1c68-4765-b752-0e8e6b6d015f"
  key_pair        = "BARTRON"
  security_groups = ["datacentred"]
  depends_on = ["openstack_compute_instance_v2.vsrx3"]

  network {
    name = "vSRX-LAN-OUTSIDE"
    #port = "${openstack_networking_port_v2.port_4.id}"
  }
  timeouts {
    create = "5m"
    delete = "2m"
  }
}



  resource "openstack_compute_floatingip_associate_v2" "fip_1" {
    floating_ip = "${openstack_networking_floatingip_v2.fip_1.address}"
    instance_id = "${openstack_compute_instance_v2.vsrx1.id}"
  }

  resource "openstack_compute_floatingip_associate_v2" "fip_2" {
    floating_ip = "${openstack_networking_floatingip_v2.fip_2.address}"
    instance_id = "${openstack_compute_instance_v2.vsrx2.id}"
  }

  resource "openstack_compute_floatingip_associate_v2" "fip_3" {
    floating_ip = "${openstack_networking_floatingip_v2.fip_3.address}"
    instance_id = "${openstack_compute_instance_v2.vsrx3.id}"
  }

  resource "openstack_compute_floatingip_associate_v2" "fip_4" {
    floating_ip = "${openstack_networking_floatingip_v2.fip_4.address}"
    instance_id = "${openstack_compute_instance_v2.oob.id}"
  }

/*



#create router
resource "openstack_networking_router_v2" "public_router" {
  name = "${var.openstack_router}"
  admin_state_up = "true"
  external_gateway = "${var.openstack_gateway}"
}

resource "openstack_networking_router_interface_v2" "router_interface_1" {
  router_id = "${openstack_networking_router_v2.public_router.id}"
  subnet_id = "${openstack_networking_subnet_v2.subnet_1.id}"
}

resource "openstack_networking_floatingip_v2" "fip_1" {
  pool = "external"
}

#resource "openstack_compute_floatingip_associate_v2" "fip_1" {
#  floating_ip = "${openstack_networking_floatingip_v2.fip_1.address}"
#  instance_id = "${openstack_compute_instance_v2.test-vm.id}"
#}

#create instance
resource "openstack_compute_instance_v2" "test-vm" {
  name            = "test-vm"
  image_id        = "73fb2fff-64bf-415f-82ec-b63bbb04b3cf"
  flavor_id       = "b671216b-1c68-4765-b752-0e8e6b6d015f"
  key_pair        = "BARTRON"
  floating_ip     = "${openstack_networking_floatingip_v2.fip_1.address}"
  security_groups = ["datacentred"]
  user_data       = "data.template_file.user-data.rendered"

  network {
    name = "SKYNET"
  }
}

data "template_file" "user-data" {
  template = <<EOF
#cloud-config

---
packages:
  - fail2ban
  - htop
users:
  - name: bart
    ssh-authorized-keys:
      - ssh-rsa  AAAAB3NzaC1yc2EAAAADAQABAAABAQCazpEMrUH/tmliXAH1xduBbiodcGEHv7j/C1gmJLPL1w1KiPhCoymqA/PUEERZDZ2Lpl02i0wL7ynP7s7uQ/2T5fmNWhjTY9/X+KuQ8vxUGSAWMKeD4/Hy5mJ+OeutsChbtztSGjKBJbogXHhO7xYXkGOylKVW3UuRUC2Wl0Brke0kw1ZRpgUBz6UjlXEncwYtVh0XcTaKG3KcOzEEoG1a3AE2DcFyLPJyXYuFqCERdAAqQR0vGUaQhZvash1CxBsUoCdi+xCfZ9cXH6v3VYg59Nrl1NGKfdRrQ1Il/uiBPfQ12XJo7oreciLAN2DMsytOXdxuy9y2xd/YugKGW3q/ bart@datacentred.co.uk
EOF
}




#output "ip" {
#  value = "${openstack_networking_floatingip_v2.fip_1.address}"
#}
*/
