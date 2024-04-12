resource "aws_acm_certificate" "subdomain" {
  domain_name       = var.sub_domain_name
  validation_method = "DNS"

  tags = var.common_tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_validation" {
  name    = "${element(aws_acm_certificate.subdomain.domain_validation_options.*.resource_record_name, 0)}"
  type    = "${element(aws_acm_certificate.subdomain.domain_validation_options.*.resource_record_type, 0)}"
  zone_id = "${var.zone_id}"
  records = ["${element(aws_acm_certificate.subdomain.domain_validation_options.*.resource_record_value, 0)}"]
  ttl     = 60

}

# resource "aws_acm_certificate_validation" "cert" {
#   certificate_arn         = "${aws_acm_certificate.subdomain.arn}"
#   validation_record_fqdns = ["${aws_route53_record.cert_validation.fqdn}"]
# }

resource "aws_acm_certificate_validation" "subdomain" {
  certificate_arn         = aws_acm_certificate.subdomain.arn
  validation_record_fqdns = [for record in aws_acm_certificate.subdomain.domain_validation_options : record.resource_record_name]

}