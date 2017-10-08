output "INSTANCE IP - ssh to" {
  value = "185.43.218.185\n"
}
output "INSTANCE INTERNAL IP" {
  value = "${openstack_compute_instance_v2.instance1.access_ip_v4}\n"
}
