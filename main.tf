provider "aws" {
  region = "us-east-1"  # Altere para a região desejada
}

data "aws_iam_role" "existing_role" {
  role_name = "LabRole"  # Substitua pelo nome da sua role existente
}

resource "aws_rds_cluster" "autoatendimentodb" {
  cluster_identifier  = "autoatendimentodb-cluster"
  engine              = "aurora-postgresql"
  engine_version      = "16.1"  # Altere conforme necessário
  master_username     = var.db_username
  master_password     = var.db_password
  database_name       = var.db_name 
  skip_final_snapshot = true
}

resource "aws_rds_cluster_instance" "autoatendimentodb" {
  count              = 1
  cluster_identifier = aws_rds_cluster.autoatendimentodb.id
  instance_class     = "db.serverless"  # Classe de instância mínima
  engine             = aws_rds_cluster.autoatendimentodb.engine
  
  # Associar a Role IAM existente
  iam_role                              = data.aws_iam_role.existing_role.arn
  
  # Habilitar autenticação IAM (opcional)
  iam_database_authentication_enabled   = true  
}

output "db_endpoint" {
  value = aws_rds_cluster.autoatendimentodb.endpoint
}