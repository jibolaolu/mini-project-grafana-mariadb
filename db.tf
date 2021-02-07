resource "aws_db_subnet_group" "mariadbsubnet" {
  subnet_ids = [aws_subnet.Project_Private_Subnet.id,aws_subnet.Project_Private_Subnet2.id]
  name       = "mariadbsubnet"
  tags = {
    Name = "MariaDB-SG-Group"
  }
}
resource "aws_db_parameter_group" "mariadb" {
  family = "mariadb10.4"
  name = "mariadb"

  parameter {
    name = "max_allowed_packet"
    value = "16777216"
  }
}
resource "aws_db_instance" "mariadb" {
  allocated_storage         = 20
  storage_type              = "gp2"
  engine                    = "mariadb"
  engine_version            = "10.4.8"
  identifier                = "mariadb"
  instance_class            = "db.t2.micro"
  name                      = "miniprojectdb"
  username                  = var.dbusername
  password                  = var.dbpassword
  parameter_group_name      = "mariadb"
  publicly_accessible       = false
  apply_immediately         = true
  db_subnet_group_name      = aws_db_subnet_group.mariadbsubnet.name
  vpc_security_group_ids    = [aws_security_group.Private_instance.id]
  availability_zone = aws_subnet.Project_Private_Subnet.availability_zone
  port                      = 3306
  backup_retention_period   = 7
  final_snapshot_identifier = "mariadb-final-snapshot"
  skip_final_snapshot       = true
}

output "dbendpoint" {
  value = aws_db_instance.mariadb.endpoint
}