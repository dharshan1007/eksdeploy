resource "aws_ecr_repository" "basic_simulator" {
  name                 = "${var.solution}-${var.environment}-basic-simulator"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "${var.solution}-${var.environment}-basic_simulator"
    environment = var.environment
    solution = var.solution

  }

}

resource "aws_ecr_repository" "kafka" {
  name                 = "${var.solution}-${var.environment}-kafka"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "${var.solution}-${var.environment}-kafka"
    environment = var.environment
    solution = var.solution

  }

}


resource "aws_ecr_repository" "simulator_api" {
  name                 = "${var.solution}-${var.environment}-simulator_api"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "${var.solution}-${var.environment}-simulator_api"
    environment = var.environment
    solution = var.solution

  }

}


resource "aws_ecr_repository" "nifi" {
  name                 = "${var.solution}-${var.environment}-nifi"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "${var.solution}-${var.environment}-nifi"
    environment = var.environment
    solution = var.solution

  }

}


resource "aws_ecr_repository" "virtal_ev_fe" {
  name                 = "${var.solution}-${var.environment}-virtual-ev-fe"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "${var.solution}-${var.environment}-virtual-ev-fe"
    environment = var.environment
    solution = var.solution

  }

}


resource "aws_ecr_repository" "ev-portal" {
  name                 = "${var.solution}-${var.environment}-ev-portal"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "${var.solution}-${var.environment}-ev-portal"
    environment = var.environment
    solution = var.solution

  }

}


resource "aws_ecr_repository" "MQTT" {
  name                 = "${var.solution}-${var.environment}-mqtt"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "${var.solution}-${var.environment}-mqtt"
    environment = var.environment
    solution = var.solution

  }

}