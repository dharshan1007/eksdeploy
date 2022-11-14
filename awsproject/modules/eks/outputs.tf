output "cluster_name" {
  value = aws_eks_cluster.ev_pilot_innova.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.ev_pilot_innova.endpoint
}

output "cluster_ca_certificate" {
  value = aws_eks_cluster.ev_pilot_innova.certificate_authority[0].data
}
