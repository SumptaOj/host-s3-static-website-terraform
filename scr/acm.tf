// Use the AWS Certificate Manager to create an SSL cert 
resource "aws_acm_certificate" "ssl_certificate" {
  #provider                  = aws.acm_provider
  domain_name               = var.root_domain_name
  subject_alternative_names = ["*.${var.root_domain_name}"]
  validation_method         = "EMAIL"

  tags = var.hosting_tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "cert_validation" {
  #provider        = aws.acm_provider
  certificate_arn = aws_acm_certificate.ssl_certificate.arn
}


// Deploy an existing acm certificate without creating a new one
data "aws_acm_certificate" "ssl_certificate" {
  provider        = aws.acm_provider
  domain                    = "yourdomain_name"
  types                     = ["AMAZON_ISSUED"]
}