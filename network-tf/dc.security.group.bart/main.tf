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
  remote_ip_prefix  = "${var.security_group_rule1}"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_1.id}"
  depends_on        = ["openstack_networking_secgroup_v2.secgroup_1"]
}
resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_2" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 1
  port_range_max    = 65535
  remote_ip_prefix  = "${var.security_group_rule2}"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_1.id}"
  depends_on        = ["openstack_networking_secgroup_rule_v2.secgroup_rule_1"]
}
resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_3" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 1
  port_range_max    = 65535
  remote_ip_prefix  = "${var.security_group_rule3}"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_1.id}"
  depends_on        = ["openstack_networking_secgroup_rule_v2.secgroup_rule_2"]
}
