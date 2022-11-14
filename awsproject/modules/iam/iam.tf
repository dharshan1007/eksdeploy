resource "aws_iam_role" "dev-resources-iam-role" {
name        = "dev-ssm-role"
description = "The role for the developer resources EC2"
assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        },
        {
            "Sid": "IAM",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::789755013245:user/nhimarajashekharachari"
            },
            "Action": "sts:AssumeRole"
        },
        {
            "Sid": "malar",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::789755013245:user/mgovindan@us.maxnerva.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
tags = {
Name = "dev-ssm-role"
environment = var.environment
solution = var.solution
}
}

resource "aws_iam_role_policy_attachment" "dev-resources-ssm-policy" {
role       = aws_iam_role.dev-resources-iam-role.name
policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "terraform_authorization_role"{
    role = aws_iam_role.dev-resources-iam-role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_role_policy_attachment" "terraform_admin_access"{
    role = aws_iam_role.dev-resources-iam-role.name
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_instance_profile" "dev_iam_instance_profile" {
name = "dev_iam_instance_profile"
role = aws_iam_role.dev-resources-iam-role.name
}

