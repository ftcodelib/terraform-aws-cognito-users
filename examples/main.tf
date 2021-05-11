module "cognito_config" {
  source  = "ftcodelib/cognito-users/aws"
  version = "0.2.0"

  aws_region  = "us-east-1"
  aws_profile = "aws-profile-example"

  cognito_user_pool_id = aws_cognito_user_pool.user_pool.id

  cognito_groups_create = true
  cognito_users_create  = true

  # Using CSV
  cognito_users_list = yamldecode(file("${path.cwd}/list.yaml"))
}