# Security Groups
resource "aws_security_group" "public_sg" {
  name   = "frontend-sg"
  vpc_id = var.vpc_id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "private_sg" {
  name   = "backend-sg"
  vpc_id = var.vpc_id
  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.public_sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instances
resource "aws_instance" "app_nodes" {
  for_each = var.instance_map

  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  
  # Logic: If the map says "public", use the public subnet, else private
  subnet_id              = each.value.is_public ? var.public_subnet_id : var.private_subnet_id
  
  # Logic: If public, use public SG, else private SG
  vpc_security_group_ids = [each.value.is_public ? aws_security_group.public_sg.id : aws_security_group.private_sg.id]

  tags = {
    Name = "${each.key}-server"
  }
}
