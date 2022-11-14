resource "aws_db_subnet_group" "db_sub_gr" {
  description = "terrafom db subnet group"
  name        = "main_subnet_group"
  subnet_ids      = aws_subnet.eks-private[*].id

  tags = {
    Name = "${var.solution}-${var.environment}-db-subnet"
    environment = var.environment
    solution = var.solution
  }
}

resource "aws_security_group" "sec_grp_rds" {
  name        = "rds-sg"
  description = "rds securety group"
  vpc_id      = aws_vpc.eks-vpc.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

       
  tags = {
    Name = "${var.solution}-${var.environment}-db-sg"
    environment = var.environment
    solution = var.solution
  }
}

resource "aws_db_instance" "main_db" {
  identifier        = "main-postgres-db"
 # replicate_source_db = aws_db_instance.postgres-db.identifier
  storage_type      = "${var.storage_type}"
  allocated_storage = "${var.allocated_storage}"
  engine            = "${var.db_engine}"
  engine_version    = "${var.engine_version}"
  instance_class    = "${var.instance_class}"
  db_name           = "postgres01"
  username          = "${var.db_username}"
  password          = "${var.db_password}"
  vpc_security_group_ids = [aws_security_group.sec_grp_rds.id]
  db_subnet_group_name = "${aws_db_subnet_group.db_sub_gr.id}"
  storage_encrypted    = false
  skip_final_snapshot  = false
  publicly_accessible  = true
  multi_az             = false
  maintenance_window      = "Mon:00:00-Mon:03:00"
  backup_window           = "03:00-06:00"
  backup_retention_period = 1

  tags = {
    Name = "${var.solution}-${var.environment}-db-instance"
    environment = var.environment
    solution = var.solution

  }
}

resource "aws_db_instance" "primary_read_replica" {
  identifier        = "primary-read-postgres-db"
  replicate_source_db = aws_db_instance.main_db.identifier
  storage_type      = "${var.storage_type}"
  instance_class    = "${var.instance_class}"
  vpc_security_group_ids = [aws_security_group.sec_grp_rds.id]
 # db_subnet_group_name = "${aws_db_subnet_group.db_sub_gr.id}"
  storage_encrypted    = false
  skip_final_snapshot  = true
  publicly_accessible  = false
  multi_az             = false
  maintenance_window      = "Mon:00:00-Mon:03:00"
  backup_window           = "03:00-06:00"
  backup_retention_period = 1

  tags = {
    Name = "${var.solution}-${var.environment}-primary-read-db-instance"
    environment = var.environment
    solution = var.solution

  }
}




