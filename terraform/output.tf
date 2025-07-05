output "ec2_availability_zone" {
  value = aws_instance.jenkins.availability_zone
}

output "ec2_public_dns_name" {
  value = aws_eip.jenkins_eip.public_dns
}

output "ec2_instance_id" {
  value = aws_instance.jenkins.id
}

output "ec2_ami_id" {
  value = aws_instance.jenkins.ami
}

output "ec2_eip_address" {
  value = aws_eip.jenkins_eip.public_ip
}