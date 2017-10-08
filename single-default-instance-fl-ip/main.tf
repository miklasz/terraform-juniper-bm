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
#    CREATE FLOATING --- IP
#
#
resource "openstack_networking_floatingip_v2" "fip_1" {
  pool       = "external"
}

#
#        NETWORK, SUBNET, DNS
#
variable "internet-access" {
    default  = "internet-access-network"
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
