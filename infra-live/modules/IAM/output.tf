output "cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}

output "node_role_arn" {
  value = aws_iam_role.eks_nodes_role.arn
}
# output "jenkins_profile_name" {
#   value = aws_iam_instance_profile.jenkins_profile.name
# }

# output "jenkins_role_arn" {
#   value = aws_iam_role.jenkins_role.arn
# }