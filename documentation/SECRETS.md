| Secret | Description | Sample Value |
| ------ | ----------- | ------- |
| ANSIBLE_BUCKET | Name of S3 bucket where ansible zip is uploaded and SSM command output is stored | ansible-bucket-name |
| AWS_ACCESS_KEY_ID | AWS Access Key ID | generated-aws-access-key-id |
| AWS_DEFAULT_REGION | AWS region where AMI is created | us-east-1 |
| AWS_SECRET_ACCESS_KEY | AWS Secret access key | generated-aws-secret-access-key |
| IAM_ROLE_NAME | Name of IAM role created for EC2 instance | UbuntuCISIAMRole |
| INSTANCE_NAME | Name to be used on all EC2 resources as prefix | Ubuntu CIS Instance |
| SG_NAME | Name of security group | Ubuntu CIS SG |
| STATE_BUCKET_KEY | S3 object key where terraform state is stored | terraform.tfstate |
| STATE_BUCKET_NAME | Name of S3 bucket where terraform state is stored  | terraform-bucket |
| VAULT_PASS | Ansible vault password | random-secret-value |
| VPC_AZS | A list of availability zones names or ids in the region | ["us-east-1a", "us-east-1b", "us-east-1c"] |
| VPC_CIDR | The CIDR block for the VPC | 10.0.0.0/16 |
| VPC_NAME | Name to be used on all the VPC resources as identifier | Ubuntu CIS VPC |
| VPC_PRIVATE_SUBNET | Private subnet inside the VPC. Use for EC2 instance | 10.0.1.0/24 |
| VPC_PUBLIC_SUBNET | Public subnets inside the VPC. Used for NAT Gateway | 10.0.2.0/24 |
