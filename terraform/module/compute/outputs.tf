
output "instance_ips" {
  value = {
    for name, instance in aws_instance.app_nodes : name => {
      public_ip  = instance.public_ip
      private_ip = instance.private_ip
    }
  }
}
