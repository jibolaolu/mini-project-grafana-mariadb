resource "aws_security_group" "Nodes" {
  description = "This is for non Monitor nodes in PublicSbunet"
  vpc_id      = aws_vpc.Project_VPC.id
  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 9100
    protocol    = "tcp"
    to_port     = 9100
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Nginx-SG"
  }
}

resource "aws_security_group" "Monitor_SG" {
  description = "This is for instances in the monitor subnet"
  vpc_id      = aws_vpc.Project_VPC.id
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3000
    protocol    = "tcp"
    to_port     = 3000
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 9090
    protocol    = "tcp"
    to_port     = 9090
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 9115
    protocol    = "tcp"
    to_port     = 9115
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 9093
    protocol    = "tcp"
    to_port     = 9093
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 9300
    protocol    = "tcp"
    to_port     = 9300
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Grafana-SG"
  }
}
#Create SG for private instances
resource "aws_security_group" "Private_instance" {
  vpc_id      = aws_vpc.Project_VPC.id
  description = "This is for the instances in the private subnet"

  ingress {
    from_port       = 22
    protocol        = "tcp"
    to_port         = 22
    cidr_blocks     = ["10.9.1.0/24","10.9.2.0/24"]
    security_groups = [aws_security_group.Nodes.id]
  }
  ingress {
    from_port       = 3306
    protocol        = "tcp"
    to_port         = 3306
    cidr_blocks     = ["10.9.1.0/24","10.9.2.0/24"]
    security_groups = [aws_security_group.Nodes.id]
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Monitor-SG"
  }
}