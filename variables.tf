variable "aws_region" {
  description = "AWS cli region."
  type        = string
}

variable "aws_profile" {
  description = "AWS cli region."
  type        = string
}

variable "aws_cli_path" {
  description = "AWS cli path."
  type        = string
  default     = null
}

variable "cognito_user_pool_id" {
  description = "AWS Cognito user pool id."
  type        = string
}

variable "cognito_groups_create" {
  description = "Enable cognito groups creation."
  type        = bool
  default     = true
}

variable "cognito_users_create" {
  description = "Enable cognito users creation."
  type        = bool
  default     = true
}

variable "cognito_users_list" {
  description = "List object of users to be created."
  type = list(object({
    username = string
    group    = string
    email    = string
  }))
}