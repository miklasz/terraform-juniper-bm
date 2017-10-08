output "INSTANCE IP - ssh to" {
  value = "${openstack_networking_floatingip_v2.fip_1.address}\n"
}
output "vSRX1 IP" {
  value = "${var.subnet_8_lan21}\n"
}
output "oob-instance oob-network-internal IP" {
  value = "${var.subnet_8_lan10}\n"
}
output "oob-instance oob-network-external IP" {
  value = "${var.subnet_7_lan10}\n"
}

#output "text idzie sobie" {
#  value = "${var.output1}"
#}
