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
#    INSTANCES
#
#
resource "openstack_compute_instance_v2" "instance1" {
  name            = "${var.instance_name}"
  image_id        = "${var.instance_image_id}"
  flavor_id       = "${var.instance_flavor_id}"
  key_pair        = "${var.key_pair}"
  floating_ip     = "185.43.218.185"
  security_groups = ["datacentred"]

  network {
    name = "${var.internet-access}"
    }
  timeouts {
    create = "5m"
    delete = "2m"
  }
}
