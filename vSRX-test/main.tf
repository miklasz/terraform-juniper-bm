#
#
# Authentication
#
#
provider "openstack" {
  tenant_name = "${var.openstack_project_name}"
  user_name   = "${var.openstack_user_name}"
  password    = "${var.openstack_password}"
  auth_url    = "${var.openstack_auth_url}"
}
#
#
#    CREATE FLOATING --- IP
#
#
resource "openstack_networking_floatingip_v2" "fip_1" {
  pool       = "external"
}
############################################################
resource "openstack_networking_port_v2" "port_1" {
  name           = "${var.vsrx1_port1_name}"
  network_id     = "internet-access-network"
  admin_state_up = "true"
  allowed_address_pairs = ["${var.pairs}"]
}
############################################################
#
#
# vSRX1 instance
#
#
resource "openstack_compute_instance_v2" "vsrx1" {
  name            = "${var.name-vsrx-1}"
  image_id        = "${var.vsrx-image}"
  flavor_id       = "${var.vsrx-flavor}"
  key_pair        = ""
  security_groups = ["datacentred"]
  depends_on = ["openstack_networking_floatingip_v2.fip_1"]

  network {
    name = "${var.internet-access}"
    port = "openstack_networking_port_v2.port_1.id"
    }
  timeouts {
    create = "5m"
    delete = "5m"
  }
}
#
#
#   Deploy Floating IP to vSRX-1
#
#
resource "openstack_compute_floatingip_associate_v2" "fip_1" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_1.address}"
  instance_id = "${openstack_compute_instance_v2.vsrx1.id}"
}
