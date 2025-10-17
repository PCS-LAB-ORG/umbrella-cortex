output "instance_id" {
  description = "ID of the vulnerable Linux instance"
  value       = aws_instance.vulnerable_instance.id
}

output "public_ip" {
  description = "Public IP address of the instance"
  value       = aws_instance.vulnerable_instance.public_ip
}