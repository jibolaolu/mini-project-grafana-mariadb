resource "aws_instance" "WebBox1" {
  ami             = var.Node-ami
  instance_type   = var.instance_Type
  security_groups = [aws_security_group.Nodes.id]
  #vpc_security_group_ids = []
  subnet_id         = aws_subnet.Project_Public_Subnet1.id
  availability_zone = "eu-west-2a"
  key_name          = var.Keyname

  tags = {
    Name = "WebBox-1"
  }
}
resource "aws_instance" "WebBox2" {
  ami               = var.Node-ami
  instance_type     = var.instance_Type
  security_groups   = [aws_security_group.Nodes.id]
  subnet_id         = aws_subnet.Project_Public_Subnet1.id
  availability_zone = "eu-west-2a"
  key_name          = var.Keyname

  tags = {
    Name = "WebBox-2"
  }
}

resource "aws_instance" "Monitor_Box" {
  ami               = var.Monitor-ami
  instance_type     = var.instance_Type
  security_groups   = [aws_security_group.Monitor_SG.id]
  subnet_id         = aws_subnet.Project_Public_Subnet2.id
  availability_zone = "eu-west-2b"
  key_name          = var.Keyname

  tags = {
    Name = "MonitorBox"
  }
}