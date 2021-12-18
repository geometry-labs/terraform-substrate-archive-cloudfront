# terraform-subtrate-archive-cloudfront

Cloudfront distribution for serving archive node backups for the Polkadot ecosystem. Used in conjunction with [terraform-polkadot-aws-node](https://github.com/geometry-labs/terraform-polkadot-aws-node) which creates a bucket and does incremental backups of the archive. 

[comment]: <> (![]&#40;https://github.com/geometry-labs/terraform-polkadot-aws-node/actions/workflows/integration.yaml/badge.svg&#41;)

## Using the endpoints 

To download the entire database, we recommend using a tool called aria2, which allows for multiple simultaneous downloads against the manifest file, resumption of interrupted downloads, on top of other useful features.

To use aria2, you just need to provide the options of the output folder location (-d) and the input file either from a previously downloaded copy of the manifest or by piping from cURL.
For example, if your Polkadot client is configured to use the base path of /data, the database files would be stored at /data/chains/polkadot/db/full/, which is where we will want the files. We can then download the manifest and the files in one command:

```bash
curl -s https://substrate.archive.aws.geometry.io/polkadot_manifest.txt | aria2c -d /data/chains/polkadot/db/full/ -i -
```

Here we are downloading the manifest with cURL, piping to aria2 (the -i — tells aria2 to read from stdin), and to download all of the files to /data/chains/polkadot/db/full/.

The one important thing to note is that each manifest has a window during which it is valid. If you try and download the database using that manifest outside of that window, you may have an inconsistency. The window is given at the top of the manifest and looks like this:

```bash
#VALID FROM 2021-12-01T00:00:00+00:00 TO 2021-12-01T06:00:00+00:00
```

If you find your download spans a valid window, most likely because of download errors from aria2, you can finish the download normally, and then refresh the files by downloading a fresh copy of the manifest and catching any files you missed. This window is a consequence of the CloudFront caching, which isn’t ideal, but allows smaller file diffs overall.

The last thing you’ll need to do, as a quirk from the way RocksDB works, is to ensure the value in the CURRENT file matches the latest MANIFEST-* file you have. You can manually do this by checking which MANIFEST-* file you have, but you can also use a little bit of bash magic. To get the main DB:

```bash
ls /path/to/db/files/MANIFEST* | xargs -n 1 basename > /path/to/db/files/CURRENT
```

To get the parachains DB:

```bash
ls /path/to/db/files/parachains/db/MANIFEST* | xargs -n 1 basename > /path/to/db/files/parachains/db/CURRENT
```

Just be sure to change /path/to/db/files/ with whatever is appropriate for your configuration.
Now you’re all set to start up the binary for the network of your choice!

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
