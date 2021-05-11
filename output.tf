output "cognito_groups" {
  value = aws_cognito_user_group.this
}

output "cognito_users" {
  value = null_resource.cognito_users
}
