instance_map = {
  "frontend-app" = { is_public = true }
  "worker"       = { is_public = false }
  "db-postgres"  = { is_public = false }
}

vpc_name = "voting-app-vpc"
aws_region           = "eu-central-1"
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24"]
private_subnet_cidrs = ["10.0.2.0/24"]

ami_id        = "ami-0a854fe96e0b45e4e"
instance_type = "t2.micro"
key_name      = "wale-reg-b-key"
