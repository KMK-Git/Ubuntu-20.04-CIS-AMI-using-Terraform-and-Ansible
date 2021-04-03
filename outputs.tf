output "instance_ip_addr" {
  value       = var.is_public_instance ? module.ec2_instance.public_ip : module.ec2_instance.private_ip
  description = "Public or private IP address of deployed EC2 instance"
  sensitive   = true
}