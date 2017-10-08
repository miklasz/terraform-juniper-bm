output "INSTANCE IP - ssh to" {
  value = "${openstack_networking_floatingip_v2.fip_1.address}\n"
}
output "INSTANCE INTERNAL IP" {
  value = "${openstack_compute_instance_v2.instance1.access_ip_v4}\n"
}
