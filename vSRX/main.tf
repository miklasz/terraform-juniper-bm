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
# Pull Floating IP
#
#
resource "openstack_networking_floatingip_v2" "fip_1" {
  pool       = "external"
}
#
#
#    CREATE NETWORK and SUBNET
#
#
