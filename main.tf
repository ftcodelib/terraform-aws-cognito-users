##########################
## COGNITO GROUP #########
##########################
resource "aws_cognito_user_group" "this" {
  for_each = var.cognito_groups_create ? toset(distinct(values(
    {
      for k, v in var.cognito_users_list :
      k => lookup(v, "group", "read-only")
    }
  ))) : []
  name         = each.value
  user_pool_id = var.cognito_user_pool_id
}

##########################
## COGNITO USER ##########
##########################
resource "null_resource" "cognito_users" {

  for_each = var.cognito_users_create ? {
    for k, v in var.cognito_users_list :
    v.username => v
  } : {}

  triggers = {
    aws_cmd              = local.aws_cli_path
    cognito_user_pool_id = var.cognito_user_pool_id
  }

  provisioner "local-exec" {
    command = <<-EOT
    ${self.triggers.aws_cmd} cognito-idp admin-create-user --user-pool-id ${self.triggers.cognito_user_pool_id} --username ${each.key} --user-attributes Name=email,Value=${each.value.email}
    EOT
  }

  provisioner "local-exec" {
    command = <<-EOT
    ${self.triggers.aws_cmd} cognito-idp admin-add-user-to-group --user-pool-id ${self.triggers.cognito_user_pool_id} --username ${each.key} --group-name ${lookup(each.value, "group", "read-only")}
    EOT
  }

  provisioner "local-exec" {
    when       = destroy
    command    = <<-EOT
    ${self.triggers.aws_cmd} cognito-idp admin-delete-user --user-pool-id ${self.triggers.cognito_user_pool_id} --username ${each.key}
    EOT
    on_failure = continue
  }
}