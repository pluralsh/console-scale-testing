resource "aws_db_subnet_group" "plural_db_subnet" {
  name       = "plural-db-subnet"
  subnet_ids = module.vpc.private_subnets  # Ensures the DB is deployed in private subnets

  tags = {
    Name = "plural-db-subnet"
  }
}

resource "aws_db_instance" "plural_db" {
  identifier             = "plural-db"
  engine                = "postgres"
  engine_version        = "15.2"
  instance_class        = "db.t3.medium"  # Adjust based on expected workload
  allocated_storage     = 50
  storage_type          = "gp3"
  publicly_accessible   = false
  vpc_security_group_ids = [module.rds_sg.security_group_id]
  db_subnet_group_name  = aws_db_subnet_group.plural_db_subnet.name
  multi_az              = false  # Set to true for high availability
  backup_retention_period = 7
  apply_immediately     = true

  username = "admin"
  password = var.db_password 

  tags = {
    Name = "plural-db"
  }
}
