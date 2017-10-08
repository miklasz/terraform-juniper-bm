#
#               AUTHENTICATION
#


variable "openstack_user_name" {
    description = "put your email in ~/secret.tfvars"
    default  = ""
}
variable "openstack_password" {
    description = "put your password in ~/secret.tfvars"
    default  = ""
}
variable "openstack_project_name" {
    description = "put your project name in ~/secret.tfvars"
    default  = ""
}
variable "openstack_auth_url" {
    description = "The endpoint url to connect to OpenStack."
    default  = "https://compute.datacentred.io:5000/v3.0"
}


#
#               SECURITY GROUP & RULES
#


variable "security_group1" {
    description = "security group description"
    default     = "datacentred"
}
variable "security_group_description" {
    default = "DataCentred-Access-Only"
}


#
#               IP ADDRESSES
#
variable "security_group_rule1" {
    description = "alow subnet 185.43.216.0/22"
    default     = "185.43.216.0/22"
}
variable "security_group_rule2" {
    description = "alow subnet 185.98.148.0/22"
    default     = "185.98.148.0/22"
}
variable "security_group_rule3" {
    description = "alow subnet 87.127.171.48/29"
    default     = "87.127.171.48/29"
}
