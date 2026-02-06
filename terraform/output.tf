output "vpc_id" {
  value = module.network.vpc_id
}

output "all_instance_ips" {
  value       = module.compute.instance_ips
  description = "The public and private IPs of our app nodes"
}
