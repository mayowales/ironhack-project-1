
variable "vpc_cidr" {
    type = string
    description = "The cidr block for the VPC"
}

variable "vpc_name" {
    type = string
    description = "The cidr block for the VPC"
}

variable "public_subnet_cidrs" {
    type = list(string)
    description = "Public subnet IP range"
}

variable "private_subnet_cidrs" {
    type = list(string)
    description = "Private subnet ip range"
}
