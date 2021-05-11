locals {
  aws_cli_path = (
    var.aws_cli_path != null
    ?
    "${var.aws_cli_path} --region ${var.aws_region} --profile ${var.aws_profile}"
    :
    "aws --region ${var.aws_region} --profile ${var.aws_profile}"
  )
}