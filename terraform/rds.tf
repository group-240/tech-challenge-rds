resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "tech-challenge-db-subnet-group"
  subnet_ids = data.terraform_remote_state.infra.outputs.private_subnet_ids

  tags = {
    Name = "Tech Challenge DB Subnet Group"
  }
}

resource "aws_db_instance" "postgres" {
  identifier        = "tech-challenge-db"
  engine            = "postgres"
  engine_version    = "15.4"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password
  port     = 5432

  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name

  multi_az            = false
  publicly_accessible = false
  skip_final_snapshot = true
  deletion_protection = false
}
