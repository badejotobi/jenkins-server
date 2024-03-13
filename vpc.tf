resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "myvpc"
    }
  
}

resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-west-1a"
  tags = {
    Name = "public1"
  }
}
resource "aws_subnet" "public2" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-west-1b"
  tags = {
    Name = "public2"
  }
}

#---------------------------------------------------
#INTERNET GATEWAY
#lets create our internet gateway
resource "aws_internet_gateway" "igw"{
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "IGW"
  }
}


#------------------------------------------------------


#lets create our route table
resource "aws_route_table" "publicroute" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
    
  }
  tags = {
    Name = "JenkinsPublicRoute"
  }
}

#route association
resource "aws_route_table_association" "a" {
  subnet_id= aws_subnet.public1.id
  route_table_id = aws_route_table.publicroute.id

}
resource "aws_route_table_association" "b" {
  subnet_id= aws_subnet.public2.id
  route_table_id = aws_route_table.publicroute.id
}




######################

#sec group

resource "aws_security_group" "jenkins" {
  vpc_id = aws_vpc.myvpc.id
  name   = join("_", ["jenkinssg", aws_vpc.myvpc.id])
  dynamic "ingress" {
    for_each = var.rules
    content {
      from_port   = ingress.value["port"]
      to_port     = ingress.value["port"]
      protocol    = ingress.value["proto"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "jenkins-Dynamic-SG"
  }
}