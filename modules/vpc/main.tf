# ------------------------------------- #
#                VPC                    #
# ------------------------------------- #
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

# ------------------------------------- #
#            Internet Gateway           #
# ------------------------------------- #
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.igw_name
  }
}

# ------------------------------------- #
#             Public Subnet             #
# ------------------------------------- #
resource "aws_subnet" "public_subents" {
  count = length(var.public_subnet_cidr)

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_cidr[count.index]
  availability_zone       = var.availability_zone[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-${count.index + 1}"
  }
}

# ------------------------------------- #
#             private Subnet            #
# ------------------------------------- #
resource "aws_subnet" "private_subents" {
  count = length(var.private_subnet_cidr)

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnet_cidr[count.index]
  availability_zone       = var.availability_zone[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "private-${count.index + 1}"
  }
}

# ------------------------------------- #
#              Elastic Ips              #
# ------------------------------------- #
resource "aws_eip" "nat" {
  count = length(aws_subnet.public_subents)

  domain = "vpc"

  tags = {
    Name = "eip-${count.index}"
  }
}

# ------------------------------------- #
#              Nat Gateway              #
# ------------------------------------- #
resource "aws_nat_gateway" "nat_gateway" {
  count = length(aws_subnet.public_subents)

  allocation_id = aws_eip.nat[count.index].id

  subnet_id = aws_subnet.public_subents[count.index].id

  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "nat-${count.index + 1}"
  }
}

# -------------------------------------------- #
#              Public Route Table              #
# -------------------------------------------- #
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.public_route_table_name
  }
}

# -------------------------------------------- #
#              Private Route Table             #
# -------------------------------------------- #
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway[0].id
  }

  tags = {
    Name = var.private_route_table_name
  }
}

# -------------------------------------------- --- #
#              Association Route Table             #
# ------------------------------------------------ #
resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public_subents)

  subnet_id      = aws_subnet.public_subents[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private_subents)

  subnet_id      = aws_subnet.private_subents[count.index].id
  route_table_id = aws_route_table.public.id
}
