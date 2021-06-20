region = "ap-south-1"

/* Existing VPC*/
/* This has precedence over creating new vpc*/
/* By default its false*/
#existing_vpc = false
#vpc_id = "vpc-cae82aa1"

#VPC name is must for naming convention
vpc_name = "MDS-NON-PROD-DEV-US-EAST-2"


/* Creating New VPC*/
cidr_block = "172.31.0.0/16"

/* For Secondary CIDR Block */
#secondary_cidr_blocks = [ "10.43.64.0/26", "10.43.128.0/26", "10.43.192.0/26" ]
/* For Seconday CIDR Block*/

/* Subnets */
# if azs left empty then it wil automatically get all azs from region
# else if specified then it will only use those azs
azs = [ "ap-south-1a", "ap-south-1b" , "ap-south-1c" ]

private_subnet = {
  "k8s"   = [ "172.31.240.0/22", "172.31.244.0/22", "172.31.248.0/22" ],
  "kafka" = [ "172.31.224.0/21", "172.31.232.0/22", "172.31.236.0/22" ]
  }

#public subnet required for NAT Gateway
public_subnet = {
  "default"   = [ "172.31.192.0/20", "172.31.208.0/21", "172.31.216.0/21" ]
  }

#subnet name in which nat gateway will be created
nat_subnet = "default"