resource "aws_instance" "webapp_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  primary_network_interface {
    network_interface_id = aws_network_interface.example.id
  }
  tags = {
    Name = "webapp-server"
  }

  depends_on = [aws_internet_gateway.gw]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install nginx -y
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF
}

resource "aws_network_interface" "example" {
  subnet_id = aws_subnet.public.id
  tags = {
    Name = "primary_network_interface"
  }
  security_groups = [aws_security_group.webapp_sg.id]
}

resource "aws_eip" "example" {
  network_interface = aws_network_interface.example.id
}

resource "aws_eip_association" "name" {
  network_interface_id = aws_network_interface.example.id
  allocation_id        = aws_eip.example.id
}

resource "aws_security_group" "webapp_sg" {
  name        = "webapp_sg"
  description = "Security group for webapp server"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
