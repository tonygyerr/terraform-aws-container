## Module ECR
```hcl
module "ecr" {
  source    = "git::https://github.com/tonygyerr/terraform-aws-container.git"
  app_name  = var.app_name
  tags      = merge(map("Name", local.environment_name != local.tf_workspace ? "${local.tf_workspace}-${var.app_name}-ecr" : "${var.app_name}-ecr"), merge(var.tags, var.acn_tags))
}
```

## How to build dockerfile 
<!-- ** Note You can create a repository using the AWS CLI. We have developed a Terraform ECR Module as well.
```bash
aws ecr create-repository --repository-name sagemaker-ecr
``` -->
1. Build your Docker Image
```bash
cd docker/Dockerfile
docker build -f Dockerfile -t sagemaker-ecr:v1 .
```
## How to build Dockerfile using Makefile process
```bash
make docker-build
```

## How to deploy Docker Container
```bash
docker run sagemaker-ecr:v1 /bin/bash
```

## How to Authenticate against AWS ECR
1. Authenticate against the AWS ECR
```bash
aws ecr get-login --no-include-email --region us-east-1
```
2. You will see a long string of output like below
```
docker login -u AWS -p eyJwYXlsb2Fk***************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************
```
3. Run the output command to log in to docker ECR
```bash
docker login -u AWS -p *********ejj********
```

### How to commit docker container and push Image to AWS ECR
```bash
docker commit -m "sagemaker-ecr" -a "stanley.petaway" 9e2e7ad50b82 "123456789012.dkr.ecr.us-east-1.amazonaws.com/sagemaker-ecr:v1"
docker push 123456789012.dkr.ecr.us-east-1.amazonaws.com/sagemaker-ecr:v1
```

### Docker Maintenance Commands
```bash
docker rm $(docker ps -a -q)
docker system prune -a --volumes
```

## Requirements

| Name | Version |
|------|---------|
| aws | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app\_name | Application Name | `string` | `""` | no |
| attributes | Additional attributes (e.g. `policy` or `role`) | `list(string)` | `[]` | no |
| delimiter | Delimiter to be used between `name`, `namespace`, `stage`, etc. | `string` | `"-"` | no |
| enable\_lifecycle\_policy | Set to false to prevent the module from adding any lifecycle policies to any repositories | `bool` | `true` | no |
| enabled | Set to false to prevent the module from creating any resources | `bool` | `true` | no |
| image\_names | List of Docker local image names, used as repository names for AWS ECR | `list(string)` | `[]` | no |
| image\_tag\_mutability | The tag mutability setting for the repository. Must be one of: `MUTABLE` or `IMMUTABLE` | `string` | `"MUTABLE"` | no |
| max\_image\_count | How many Docker Image versions AWS ECR will store | `number` | `500` | no |
| principals\_full\_access | Principal ARNs to provide with full access to the ECR | `list(string)` | `[]` | no |
| principals\_readonly\_access | Principal ARNs to provide with readonly access to the ECR | `list(string)` | `[]` | no |
| protected\_tags | Name of image tags prefixes that should not be destroyed. Useful if you tag images with names like `dev`, `staging`, and `prod` | `set(string)` | `[]` | no |
| regex\_replace\_chars | Regex to replace chars with empty string in `namespace`, `environment`, `stage` and `name`. By default only letters, digits, dash, slash, and underscore are allowed, all other chars are removed | `string` | `"/[^a-z/A-Z_0-9-]/"` | no |
| scan\_images\_on\_push | Indicates whether images are scanned after being pushed to the repository (true) or not (false) | `bool` | `false` | no |
| tags | Additional tags (e.g. `map('BusinessUnit','XYZ')`) | `map(string)` | `{}` | no |
| use\_fullname | Set 'true' to use `namespace-stage-name` for ecr repository name, else `name` | `bool` | `true` | no |
| vpc\_config | configuration option for vpc | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| registry\_id | Registry ID |
| repository\_arn | ARN of first repository created |
| repository\_arn\_map | Map of repository names to repository ARNs |
| repository\_name | Name of first repository created |
| repository\_url | URL of first repository created |
| repository\_url\_map | Map of repository names to repository URLs |