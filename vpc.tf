resource "aws_vpc" "pg_cloud_infrastructure" {
  cidr_block           = "10.20.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  instance_tenancy     = "default"

  tags = {
    Name = "PG Cloud Infrastructure"
  } 
}

resource "aws_vpc" "pg_demo_poc" {
  cidr_block           = "10.21.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  instance_tenancy     = "default"

  tags = {
    Name = "PG Demo/POC"
  } 
}

#PG Cloud Subnets
resource "aws_subnet" "pg_cloud_subnet_public" {
  vpc_id                  = aws_vpc.pg_cloud_infrastructure.id
  cidr_block              = "10.20.0.0/24"
  availability_zone       = var.SUBNET_AZ

  tags = {
    Name = "PG Cloud Public"
  } 

}

resource "aws_subnet" "pg_cloud_subnet_private"  {
  vpc_id                  = aws_vpc.pg_cloud_infrastructure.id
  cidr_block              = "10.20.1.0/24"
  availability_zone       = var.SUBNET_AZ

  tags = {
    Name = "PG Cloud Private"
  }
}

resource "aws_subnet" "pg_cloud_subnet_shared_service"  {
  vpc_id                  = aws_vpc.pg_cloud_infrastructure.id
  cidr_block              = "10.20.5.0/24"
  availability_zone       = var.SUBNET_AZ

  tags = {
    Name = "PG Cloud Shared Service"
  }
}

#PG Demo/POC subnet
resource "aws_subnet" "pg_demo_poc_subnet_public" {
  vpc_id                  = aws_vpc.pg_demo_poc.id
  cidr_block              = "10.21.0.0/24"
  availability_zone       = var.SUBNET_AZ

  tags = {
    Name = "PG Demo/POC"
  }

}

resource "aws_subnet" "pg-cloud-subnet-private"  {
  vpc_id                  = aws_vpc.pg_demo_poc.id
  cidr_block              = "10.21.1.0/24"
  availability_zone       = var.SUBNET_AZ

  tags = {
    Name = "PG Demo/POC"
  }
}

resource "aws_subnet" "pg-cloud-subnet-shared-service"  {
  vpc_id                  = aws_vpc.pg_demo_poc.id
  cidr_block              = "10.21.5.0/24"
  availability_zone       = var.SUBNET_AZ

  tags = {
    Name = "PG Demo/POC"
  }
}