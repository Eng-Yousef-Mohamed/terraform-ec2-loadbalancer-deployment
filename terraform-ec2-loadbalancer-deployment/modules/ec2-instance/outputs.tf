output "public_instance_ids" {
  value = aws_instance.public_ec2.*.id
}

output "preivte_instance_ids" {
  value = aws_instance.private_ec2.*.id
}

output "public_ec2_ids" {
  value = aws_instance.public_ec2.*.id
}
output "private_ec2_ids" {
  value = aws_instance.private_ec2.*.id
}
output "public_security_group_id" {
  value = aws_security_group.public_security-group.id
}
output "private_security_group_id" {
  value = aws_security_group.public_security-group.id
}