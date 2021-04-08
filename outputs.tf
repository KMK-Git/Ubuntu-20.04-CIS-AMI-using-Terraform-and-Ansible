output "instance_ip_addr" {
  value       = module.ec2_instance.private_ip
  description = "Private IP address of deployed EC2 instance"
  sensitive   = true
}

output "instance_id" {
  value       = module.ec2_instance.id[0]
  description = "Instance ID of deployed EC2 instance"
}