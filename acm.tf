resource "aws_acm_certificate" "certificate" {
  domain_name       = var.root_domain_name
  validation_method = "DNS"

  subject_alternative_names = ["*.${var.root_domain_name}"]

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}

resource "aws_acm_certificate_validation" "default" {
  certificate_arn = aws_acm_certificate.certificate.arn
  validation_record_fqdns = [
    aws_route53_record.cert_validation.fqdn,
  ]
}

resource "aws_route53_record" "cert_validation" {
  name    = sort(aws_acm_certificate.certificate.domain_validation_options[*].resource_record_name)[0]
  type    = sort(aws_acm_certificate.certificate.domain_validation_options[*].resource_record_type)[0]
  zone_id = data.aws_route53_zone.root.zone_id
  records = [
    sort(aws_acm_certificate.certificate.domain_validation_options[*].resource_record_value)[0],
  ]
  ttl = 60
}