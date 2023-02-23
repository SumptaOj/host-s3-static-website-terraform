// create s3 root domain bucket for website hosting
resource "aws_s3_bucket" "root" {
  bucket = var.root_domain_name
  acl    = "public-read"
  policy = <<POLICY
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Sid":"AddPerm",
      "Effect":"Allow",
      "Principal": "*",
      "Action":["s3:GetObject"],
      "Resource":["arn:aws:s3:::${var.root_domain_name}/*"]
    }
  ]
}
POLICY


  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags = var.hosting_tags
}

// Template module for uploading files to s3
module "template_files" {
  source = "hashicorp/dir/template"

  base_dir = "${path.module}/../web"
}

// Upload files to a bucket
resource "aws_s3_object" "hosting_bucket_files" {
  bucket = aws_s3_bucket.root.id

  for_each = module.template_files.files

  key          = each.key
  content_type = each.value.content_type

  source  = each.value.source_path
  content = each.value.content

  etag = each.value.digests.md5
}

// cretae s3 subdomain bucket for website redirect
resource "aws_s3_bucket" "www" {
  bucket = var.www_domain_name
  acl    = "public-read"
  policy = <<POLICY
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Sid":"AddPerm",
      "Effect":"Allow",
      "Principal": "*",
      "Action":["s3:GetObject"],
      "Resource":["arn:aws:s3:::${var.www_domain_name}/*"]
    }
  ]
}
POLICY

  website {
    redirect_all_requests_to = "https://${var.root_domain_name}"
  }

  tags = var.hosting_tags
}