resource "aws_internet_gateway" "igw_pg_cloud_infrastructure" {
  vpc_id = aws_vpc.pg_cloud_infrastructure.id

  tags = {
    Name = "IGW-PGCloudInfrastructure"
  }
}

resource "aws_internet_gateway" "igw_pg_demo_poc" {
  vpc_id = aws_vpc.pg_demo_poc.id

  tags = {
    Name = "IGW-PGDemoPOC"
  }
}

resource "aws_eip" "pg_cloud_infrastructure" {
  vpc = true
}

resource "aws_eip" "pg_demo_poc" {
  vpc = true
}


resource "aws_nat_gateway" "pg_cloud_nat_gateway" {
  allocation_id = aws_eip.pg_cloud_infrastructure.id
  subnet_id     = aws_subnet.pg_cloud_subnet_public.id

  tags = {
    Name = "NGW-PGCloudInfrastructure"
  }

  depends_on = [aws_internet_gateway.igw_pg_cloud_infrastructure]
}

resource "aws_nat_gateway" "pg_demo_poc_nat_gateway" {
  allocation_id = aws_eip.pg_demo_poc.id
  subnet_id     = aws_subnet.pg_demo_poc_subnet_public.id

  tags = {
    Name = "NGW-PGDemoPOC"
  }

  depends_on = [aws_internet_gateway.igw_pg_demo_poc]
}

resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.pg_cloud_infrastructure.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_pg_cloud_infrastructure.id
  }

  tags = {
    Name = "RT-Public"
  }
}

resource "aws_route_table" "rt_pg_cloud_insfrastructure" {
  vpc_id = aws_vpc.pg_demo_poc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.pg_cloud_nat_gateway.id
  }
  route {
    cidr_block     = "10.10.0.0/16"
    nat_gateway_id = aws_nat_gateway.pg_cloud_nat_gateway.id
  }
  route {
    cidr_block     = "10.100.0.0/16"
    nat_gateway_id = aws_nat_gateway.pg_cloud_nat_gateway.id
  }

  tags = {
    Name = "RT-PGCloudInfrastructure"
  }
}

resource "aws_route_table" "rt_pg_demo_poc" {
  vpc_id = aws_vpc.pg_demo_poc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.pg_demo_poc_nat_gateway.id
  }

  tags = {
    Name = "RT-PGDemoPOC"
  }
}


# # route table association for the public subnets
# resource "aws_route_table_association" "prod-crta-public-subnet-1" {
#   subnet_id      = aws_subnet.subnet-public-1.id
#   route_table_id = aws_route_table.public-crt.id
# }
