
variable "root_domain_name" {
  description = "As name - example.com"
  type        = string
}

variable "s3_bucket_name" {
  description = "S3 bucket name - leave blank for root domain name"
  type        = string
}

variable "tags" {
  description = "Additional tags to associate with resources"
  type        = map(string)
  default     = {}
}

data "aws_s3_bucket" "this" {
  bucket = var.s3_bucket_name
}

data "aws_route53_zone" "root" {
  name = "${var.root_domain_name}."
}

resource "aws_route53_record" "root" {
  zone_id = data.aws_route53_zone.root.zone_id

  name = var.root_domain_name
  type = "A"

  alias {
    name                   = aws_cloudfront_distribution.root_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.root_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.root.zone_id

  name = "www.${var.root_domain_name}"
  type = "A"

  alias {
    name                   = aws_cloudfront_distribution.root_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.root_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}
