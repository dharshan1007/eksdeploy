output "vpc_arn" {
    value = aws_vpc.vpc_wp.arn
}

output "vpc_id" {
    value = aws_vpc.vpc_wp.id
}

output "wp_public_subnet_id" {
    value = aws_subnet.wp_public_subnet.id
}

output "private_subnet1_id" {
    value = aws_subnet.wp_private_subnet_1.id
}

output "private_subnet2_id" {
    value = aws_subnet.wp_private_subnet_2.id
}

output "public_subnet_arn" {
    value = aws_subnet.wp_public_subnet.arn
}

output "private_subnet1_arn" {
    value = aws_subnet.wp_private_subnet_1.arn
}

output "private_subnet2_arn" {
    value = aws_subnet.wp_private_subnet_2.arn
}

output "private_subnet3_id" {
    value = aws_subnet.wp_private_subnet_3.id
}

output "private_subnet3_arn" {
    value = aws_subnet.wp_private_subnet_3.arn
}

output "gmarket_wp_sg_id" {
    value = aws_security_group.gmarket_wp_sg.id
}

output "gmarket_nat_sg_id" {
    value = aws_security_group.gmarket_nat_sg.id
}

output "nat_nic_id" {
    value = aws_network_interface.nat_instance.id
}

/*
# outputs for resources in development environment

output "vpc_dev_arn" {
    value = aws_vpc.vpc_dev.arn
}

output "vpc_dev_id" {
    value = aws_vpc.vpc_dev.id
}

output "dev_public_subnet_id" {
    value = aws_subnet.dev_public_subnet.id
}

output "dev_private_subnet1_id" {
    value = aws_subnet.dev_private_subnet_1.id
}

output "dev_private_subnet2_id" {
    value = aws_subnet.dev_private_subnet_2.id
}

output "dev_public_subnet_arn" {
    value = aws_subnet.dev_public_subnet.arn
}

output "dev_private_subnet1_arn" {
    value = aws_subnet.dev_private_subnet_1.arn
}

output "dev_private_subnet2_arn" {
    value = aws_subnet.dev_private_subnet_2.arn
}

output "dev_private_subnet3_id" {
    value = aws_subnet.dev_private_subnet_3.id
}

output "dev_private_subnet3_arn" {
    value = aws_subnet.dev_private_subnet_3.arn
}

output "gmarket_dev_sg_id" {
    value = aws_security_group.gmarket_dev_sg.id
}
*/