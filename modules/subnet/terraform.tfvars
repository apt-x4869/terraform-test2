region = "ap-south-1"

vpc_id = "vpc-cae82aa1"
vpc_name = "MDS-NON-PROD-DEV-US-EAST-2"

azs = [ "ap-south-1a", "ap-south-1b", "ap-south-1c" ]

subnet = [ "172.31.224.0/21", "172.31.232.0/22", "172.31.236.0/22" ]

subnet_name = "k8s"

// route_table_id = [ "rtb-0ab28b199d417cc1e", "rtb-0e1ac3abf03569b02", "rtb-0e6e42fcfec0a2f04" ]

route_table_id = ["rtb-b927a7d2"]