output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_1_id" {
  description = "ID of public subnet 1"
  value       = aws_subnet.public_1.id
}

output "public_subnet_2_id" {
  description = "ID of public subnet 2"
  value       = aws_subnet.public_2.id
}

output "private_subnet_1_id" {
  description = "ID of private subnet 1"
  value       = aws_subnet.private_1.id
}

output "private_subnet_2_id" {
  description = "ID of private subnet 2"
  value       = aws_subnet.private_2.id
}

output "data_subnet_1_id" {
  description = "ID of data subnet 1"
  value       = aws_subnet.data_1.id
}

output "data_subnet_2_id" {
  description = "ID of data subnet 2"
  value       = aws_subnet.data_2.id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = [aws_subnet.public_1.id, aws_subnet.public_2.id]
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = [aws_subnet.private_1.id, aws_subnet.private_2.id]
}

output "data_subnet_ids" {
  description = "List of data subnet IDs"
  value       = [aws_subnet.data_1.id, aws_subnet.data_2.id]
}

output "nat_gateway_1_id" {
  description = "ID of NAT Gateway 1"
  value       = aws_nat_gateway.nat_1.id
}

output "nat_gateway_2_id" {
  description = "ID of NAT Gateway 2"
  value       = aws_nat_gateway.nat_2.id
}

