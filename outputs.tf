output "Jenkins_Ip" {
  description = "Web Ip"
  value       = "http://${aws_instance.Jenkins.public_ip}:8080"
}

