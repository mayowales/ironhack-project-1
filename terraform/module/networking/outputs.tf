ouput "vpc_id {
    value = aws_vpc.main.id
}

ouput "public_subnet_ids" {
    value = aws_subnet.public-sn[*].id
}

ouput "private_subnet_ids" {
    value = aws_subnet.private-sn[*].id
}
