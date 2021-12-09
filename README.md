# terraform-subtrate-archive-cloudfront

Cloudfront distribution for serving archive node backups for the Polkadot ecosystem. Used in conjunction with [terraform-polkadot-aws-node](https://github.com/geometry-labs/terraform-polkadot-aws-node) which creates a bucket and does incremental backups of the archive. 

[comment]: <> (![]&#40;https://github.com/geometry-labs/terraform-polkadot-aws-node/actions/workflows/integration.yaml/badge.svg&#41;)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| aws.usw2 | n/a |

## Modules

No Modules.

## Resources

| Name |
|------|
| [aws_acm_certificate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) |
| [aws_acm_certificate_validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) |
| [aws_cloudfront_distribution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) |
| [aws_cloudfront_origin_access_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_identity) |
| [aws_iam_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) |
| [aws_route53_record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) |
| [aws_route53_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) |
| [aws_s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket) |
| [aws_s3_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| hostname | n/a | `any` | n/a | yes |
| root\_domain\_name | As name - example.com | `string` | n/a | yes |
| s3\_bucket\_name | S3 bucket name - leave blank for root domain name | `string` | n/a | yes |
| tags | Additional tags to associate with resources | `map(string)` | `{}` | no |

## Outputs

No output.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module managed by Geometry Labs

## License

Apache 2 Licensed. See LICENSE for full details.
