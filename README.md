# AWS Cognito Users Module

This terraform module provide a workaround for creating the cognito users and group. As of this module creation, a resource to create cognito users is not yet available in Terraform aws provider.

## Requirements

AWS cli must be installed in the machine that runs this terraform code.

## Usage example

An example of Terraform file is contained in the [examples directory](./examples).

```hcl
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
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
|aws\_region|AWS cli region|`string`|`null`|yes|
|aws\_profile|AWS cli profile|`string`|`null`|yes|
|aws\_cli\_path|AWS cli path in the machine|`string`|`null`|no|
|cognito\_user\_pool\_id|AWS Cognito user pool id|`string`|`null`|yes|
|cognito\_groups\_create|Enable cognito groups creation|`bool`|`true`|no|
|cognito\_users\_create|Enable cognito users creation|`bool`|`true`|no|
|cognito\_users\_list|EKS Cluster endpoint url|`list(object({})`|`null`|yes|


## Outputs

| Name | Description |
|---|---|
|cognito\_groups|AWS Cognito user group resource output. Please [HERE](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_group) for the output details|
|cognito\_users|AWS null resource output which will contain the created users list.|


## Cognito user creation list

You can provide a map or file type YAML, JSON or CSV which contains the user list. Please refer to example or list below for the format.


## Using list object

Code example:
```hcl
cognito_users_list = [
  { "username" = "john", "group" = "admin", "email" = "john@example.com" },
  { "username" = "ali", "group" = "read-only", "email" = "ali@example.com" },
  { "username" = "mike", "group" = "read-only", "email" = "mike@example.com" }
]
```


### Using CSV

Code example:
```hcl
cognito_users_list = csvdecode(file("${path.cwd}/list.csv"))
```

CSV file example:
```csv
username,group,email
john,admin,john@example.com
ali,read-only,ali@example.com
mike,read-only,mike@example.com
```


### Using YAML

Code example:
```hcl
cognito_users_list = yamldecode(file("${path.cwd}/list.yaml"))
```

YAML file example:
```yaml
---
- username: john
  group: admin
  email: john@example.com
- username: ali
  group: read-only
  email: ali@example.com
- username: mike
  group: read-only
  email: mike@example.com
```


### Using JSON

Code example:
```hcl
cognito_users_list = jsondecode(file("${path.cwd}/list.yaml"))
```

JSON file example:
```json
[
  {
    "username": "john",
    "group": "admin",
    "email": "john@example.com"
  },
  {
    "username": "ali",
    "group": "read-only",
    "email": "ali@example.com"
  },
  {
    "username": "mike",
    "group": "read-only",
    "email": "mike@example.com" 
  }
]
```

**Note:** `path.cwd` is current working directory


## Authors

Created by [M.Farhan Taib](https://github.com/ftcodelib) - https://my.linkedin.com/in/mohdfarhantaib.


## License

Apache License 2.0 Licensed. See [LICENSE](https://github.com/ftcodelib/aws_cognito_users/LICENSE) for full details.