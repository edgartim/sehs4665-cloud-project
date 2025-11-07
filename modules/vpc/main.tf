# VPC Module
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-vpc"
    }
  )
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-igw"
    }
  )
}

# Public Subnet 1
resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_1_cidr
  availability_zone       = var.availability_zones[0]
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-public-subnet-1"
      Type = "public"
    }
  )
}

# Public Subnet 2
resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_2_cidr
  availability_zone       = var.availability_zones[1]
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-public-subnet-2"
      Type = "public"
    }
  )
}

# Private Subnet 1
resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_1_cidr
  availability_zone = var.availability_zones[0]

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-private-subnet-1"
      Type = "private"
    }
  )
}

# Private Subnet 2
resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_2_cidr
  availability_zone = var.availability_zones[1]

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-private-subnet-2"
      Type = "private"
    }
  )
}

# Data Subnet 1 (for RDS)
resource "aws_subnet" "data_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.data_subnet_1_cidr
  availability_zone = var.availability_zones[0]

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-data-subnet-1"
      Type = "data"
    }
  )
}

# Data Subnet 2 (for RDS)
resource "aws_subnet" "data_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.data_subnet_2_cidr
  availability_zone = var.availability_zones[1]

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-data-subnet-2"
      Type = "data"
    }
  )
}

# Elastic IP for NAT Gateway 1
resource "aws_eip" "nat_1" {
  domain = "vpc"
  depends_on = [aws_internet_gateway.main]

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-nat-eip-1"
    }
  )
}

# Elastic IP for NAT Gateway 2
resource "aws_eip" "nat_2" {
  domain = "vpc"
  depends_on = [aws_internet_gateway.main]

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-nat-eip-2"
    }
  )
}

# NAT Gateway 1
resource "aws_nat_gateway" "nat_1" {
  allocation_id = aws_eip.nat_1.id
  subnet_id     = aws_subnet.public_1.id

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-nat-gateway-1"
    }
  )

  depends_on = [aws_internet_gateway.main]
}

# NAT Gateway 2
resource "aws_nat_gateway" "nat_2" {
  allocation_id = aws_eip.nat_2.id
  subnet_id     = aws_subnet.public_2.id

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-nat-gateway-2"
    }
  )

  depends_on = [aws_internet_gateway.main]
}

# Route Table for Public Subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-public-rt"
    }
  )
}

# Route Table for Private Subnet 1
resource "aws_route_table" "private_1" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_1.id
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-private-rt-1"
    }
  )
}

# Route Table for Private Subnet 2
resource "aws_route_table" "private_2" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_2.id
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-private-rt-2"
    }
  )
}

# Route Table for Data Subnets (no internet access)
resource "aws_route_table" "data" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-data-rt"
    }
  )
}

# Route Table Associations
resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private_1.id
}

resource "aws_route_table_association" "private_2" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private_2.id
}

resource "aws_route_table_association" "data_1" {
  subnet_id      = aws_subnet.data_1.id
  route_table_id = aws_route_table.data.id
}

resource "aws_route_table_association" "data_2" {
  subnet_id      = aws_subnet.data_2.id
  route_table_id = aws_route_table.data.id
}

