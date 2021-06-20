

# Automation using Terraform : VPC Configuration Setup

Prerequisite:
1. Install awscli & terraform packages
2. Copy Credentials and configure aws command
3. Confirm aws connectivity by running : aws s3 ls

## Instruction to run terraform.
1. Download this repository
2. cd to this repositry
3. Run **terraform init** command to download aws plugins from internet
4. Update variables in **terraform.tfvars**
5. Run **terraform plan** command to check resources that are created bt terraform. 
6. Run **terraform apply -var-file=variables.tfvars** to create resources
7. To destory: **terraform apply -var-file=variables.tfvars -destroy**



### **Below are resources that are created**

## 1. VPC:
Give VPC Name in both case, it will be used to name other resources
    - **vpc_name**
```
Creates VPC with CIDR
    - cidr_block
    - secondary_blocks
```
OR 
```
If Existing VPC, give **existing_vpc=true** :
    - vpc_id
``` 


## 2. IGW(Internet Gateway):
```
Creates IGW for public subnets
```

## 3. Subnets (Private & Public):
Can be left empty if not needed
```
Creates private subnets
    - private_subnets

Creates public subnet
    - public_subnets
```
Example:
Dynamic Subnet
```
private_subnets = {
    k8s     = [ "10.43.11.23/27", "10.43.11.23/27", "10.43.11.23/27" ]
    kafka   = [ "10.43.11.23/27", "10.43.11.23/27", "10.43.11.23/27" ]
    elk     = [ ... ]
    other   = [ ... ]
    .
    .
    }

public_subnets = {
    sub1    = [ "10.43.11.23/27", "10.43.11.23/27", "10.43.11.23/27" ]
    sub2    = [ "10.43.11.23/27", "10.43.11.23/27", "10.43.11.23/27" ]
    sub3    = [ ... ]
    sub4    = [ ... ]
    .
    .
    }
```

## 4. EIP & NAT gateway:
```
Creates Elastic IPs required for NAT Gateways

Creates NAT gateway per Azs Available

```

## 5. Private Route Table
```
Creates Private Route Table
    - There are as many routing tables as the number of NAT gateways 

Creates Routes (0.0.0.0/ -> NAT Gateway)

Associates private subnets to Private RT
```

## 6. Public Route Table
```
Creates 1 Public Route Table

Creates Route (0.0.0.0/0 -> IGW)

Associates All public subnets to Public RT 
```

Remaining:
## Adding Security Groups
    - k8s sg group
    

