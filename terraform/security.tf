resource "aws_security_group" "rds_sg" {
  name        = "tech-challenge-rds-sg"
  description = "Allow PostgreSQL inbound traffic"
  vpc_id      = data.terraform_remote_state.infra.outputs.vpc_id

  ingress {
    description = "PostgreSQL from VPC"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.infra.outputs.vpc_cidr]
  }

  ingress {
    description     = "PostgreSQL from EKS"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [data.terraform_remote_state.infra.outputs.eks_cluster_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tech-challenge-rds-sg"
  }
}
