#
#    CONFIGURE OPEN STACK PROVIDER
#

provider "openstack" {
  tenant_name = "${var.openstack_project_name}"
  user_name   = "${var.openstack_user_name}"
  password    = "${var.openstack_password}"
  auth_url    = "${var.openstack_auth_url}"
}

#
#
#    CREATE NETWORK and SUBNET
#
#
resource "openstack_networking_network_v2" "network_1" {
  name           = "${var.internet-access}"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "subnet_1" {
  network_id      = "${openstack_networking_network_v2.network_1.id}"
  cidr            = "${var.subnet_1_lan}"
  dns_nameservers = ["${var.dns}"]
  ip_version      = 4
  enable_dhcp     = true
  depends_on      = ["openstack_networking_network_v2.network_1"]
}

#
#
#    CREATE ROUTER and INTERFACES
#
#
resource "openstack_networking_router_v2" "internet_router" {
  name = "${var.internet_router}"
  admin_state_up   = "true"
  external_gateway = "${var.openstack_gateway}"
  depends_on       = ["openstack_networking_subnet_v2.subnet_1"]
}

resource "openstack_networking_router_interface_v2" "router_interface_1" {
  router_id  = "${openstack_networking_router_v2.internet_router.id}"
  subnet_id  = "${openstack_networking_subnet_v2.subnet_1.id}"
  depends_on = ["openstack_networking_router_v2.internet_router"]
}

#
#
#    CREATE FLOATING --- IP
#
#
resource "openstack_networking_floatingip_v2" "fip_1" {
  pool       = "external"
  depends_on = ["openstack_networking_router_interface_v2.router_interface_1"]
}

#
#
#    INSTANCES
#
#
resource "openstack_compute_instance_v2" "instance1" {
  name            = "${var.instance_name}"
  image_id        = "${var.instance_image_id}"
  flavor_id       = "${var.instance_flavor_id}"
  key_pair        = "${var.key_pair}"
  security_groups = ["datacentred"]
  depends_on = ["openstack_networking_floatingip_v2.fip_1"]

  network {
    name = "${var.internet-access}"
    }
  timeouts {
    create = "5m"
    delete = "2m"
  }
}
resource "openstack_compute_floatingip_associate_v2" "fip_1" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_1.address}"
  instance_id = "${openstack_compute_instance_v2.instance1.id}"
}
