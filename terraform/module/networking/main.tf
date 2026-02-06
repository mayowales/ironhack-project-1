# Creating VPC
resources "aws_vpc" "main" {
    cidr_block            = var.vpc_cidr
    enable_dns_hostnames  = true
    enable_dns_support    = true

    tags = {
        Name = "wale-project-vpc"
    }
}

# creating Subnets
resources "aws_subnet" "public-sn" {
    count                 = length(var.public_subnet_cidrs)
    vpc_id                = aws_vpc.main.vpc_id
    cidr_block            = var.public_subnet_cidrs[count.index]
    map_public_ip_lunch   = true

    tags = {
        Name = "Public-subnet-${count.index + 1}"
    }    
}


resources "aws_subnet" "public-sn" {
    count                 = length(var.private_subnet_cidrs)
    vpc_id                = aws_vpc.main.vpc_id
    cidr_block            = var.private_subnet_cidrs[count.index]
    map_public_ip_lunch   = false
    
    tags = {
        Name = "Private-subnet-${count.index + 1}"
    }    
}

# Internet Gateway
resources "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "wales-igw"
    }
}

# NAT Gateway
resources "aws_nat_gateway" "nat" {
    subnet_id     = aws_subnet.public-sn.id

    tags = {
        Name = "wales-nat-gw"
    }
}

# Route Tables
resources "aws_route_table" "public-rt" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "wale-public-rt"
    }
}

resources "aws_route_table" "private-rt" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "wale-private-rt"
    }
}

# Associations
resources ""aws_rout_table_association" "wale-public" {
    count            = length(var.public_subnet_cidr)
    subnet_id        = aws_subnet.public-sn[count.index].id
    route_table_id   = aws_route_table.public-rt.id
}

resources ""aws_rout_table_association" "wale-private" {
    count            = length(var.private_subnet_cidr)
    subnet_id        = aws_subnet.private-sn[count.index].id
    route_table_id   = aws_route_table.private-rt.id
}
