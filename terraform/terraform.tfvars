instance_map = {
  "wale-frontend-app" = { is_public = true }
  "wale-worker"       = { is_public = false }
  "wale-db-postgres"  = { is_public = false }
}

vpc_name             = "voting-app-vpc"
aws_region           = "us-east-1"
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24"]
private_subnet_cidrs = ["10.0.2.0/24"]

ami_id        = "ami-0c398cb65a93047f2"
instance_type = "t2.micro"
key_name      = "wale-ubuntu-key"
