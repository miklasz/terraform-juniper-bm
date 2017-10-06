output "INSTANCE IP - user: matti/bart" {
  value = "${openstack_networking_floatingip_v2.fip_1.address}\n"
}
output "INSTANCE INTERNAL IP" {
  value = "${openstack_compute_instance_v2.vsrx1.access_ip_v4}\n"
}
