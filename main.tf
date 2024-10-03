provider "aws" {
  region = "us-east-1"  # Altere para a região desejada
}

resource "aws_rds_cluster" "autoatendimentodb" {
  cluster_identifier  = "autoatendimentodb-cluster"
  engine              = "aurora-postgres"
  engine_version      = "14.8"  # Altere conforme necessário
  master_username     = var.db_username
  master_password     = var.db_password
  database_name       = var.db_name 
  skip_final_snapshot = true
}

resource "aws_rds_cluster_instance" "autoatendimentodb" {
  count              = 1
  cluster_identifier = aws_rds_cluster.autoatendimentodb.id
  instance_class     = "db.t3.small"  # Classe de instância mínima
  engine             = aws_rds_cluster.autoatendimentodb.engine
}

output "db_endpoint" {
  value = aws_rds_cluster.autoatendimentodb.endpoint
}