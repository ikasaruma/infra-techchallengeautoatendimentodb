provider "aws" {
  region = "us-east-1"  # Altere para a região desejada
}

resource "aws_rds_cluster" "techchallengeautoatendimentodb" {
  cluster_identifier  = "techchallengeautoatendimentodb-cluster"
  engine              = "aurora-postgresql"
  engine_version      = "15.2"  # Altere conforme necessário
  master_username     = var.db_username
  master_password     = var.db_password
  database_name       = var.db_name 
  skip_final_snapshot = true
  role_arn            = var.lab_role
}

resource "aws_rds_cluster_instance" "techchallengeautoatendimentodb" {
  count              = 1
  cluster_identifier = aws_rds_cluster.techchallengeautoatendimentodb.id
  instance_class     = "db.t3.small"  # Classe de instância mínima
  engine             = aws_rds_cluster.techchallengeautoatendimentodb.engine
  role_arn           = var.lab_role
}

output "db_endpoint" {
  value = aws_rds_cluster.example.endpoint
}