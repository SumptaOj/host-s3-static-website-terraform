// Create a hosted zone for the domain
resource "aws_route53_zone" "zone" {
  name = "${var.root_domain_name}"
  tags = var.hosting_tags
}

// Use an already existing hosted zone instead
data "aws_route53_zone" "zone" {
  name = var.root_domain_name
}

resource "aws_route53_record" "root" {
  zone_id = "${aws_route53_zone.zone.zone_id}"
  // uncomment the below zone_id and name if using existing hosted zone
  #zone_id = data.aws_route53_zone.zone.zone_id 
  #name    = data.aws_route53_zone.zone.name
  name    = "${var.root_domain_name}"
  type = "A"

  alias {
    name                   = aws_cloudfront_distribution.root_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.root_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}


resource "aws_route53_record" "www" {
  zone_id = "${aws_route53_zone.zone.zone_id}"
  // uncomment the below zone_id if using existing hosted zone
  #zone_id = data.aws_route53_zone.zone.zone_id
  name = var.www_domain_name
  type = "A"

  alias {
    name                   = aws_cloudfront_distribution.www_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.www_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}