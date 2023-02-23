# S3 Secure Static Website Using Terraform

Hosting a static website over SSL with S3, ACM, CloudFront, Route53 and Terraform.

Below is a step by step guide:

## Initial Setup

- Create provider.tf file for terraform configuration
  2 providers can be created:
  - AWS provider (default provider) where majority of the components will be created.
    This can be in any region.
  - 2nd AWS provider is for SSL cert as it needs to be created in us-east-1 for cloudfront to use it.
- Create a variables.tf for domain and subdomain names.
- Create terraform.tf to update the variables with the name of your actual domain and subdomain.

### Create 2 buckets

The bucket names must match your domain and subdomain names.
- S3 root domain bucket (yourdomain.com) to host your website content.
- S3 subdomain bucket (www.yourdomain.com) to redirect request to yourdomain.com.

### Generate an SSL Certificate

Generate an SSL certificate that covers your domain and subdomain names using AWS Certificate Manager.

### Host with Cloudfront

Create 2 cloudfront distribution for each s3 bucket.

### Create Route53 records

Set up Route53 records to point to the respective CloudFront distribution.

### NOTE:

SSL certificate is validated using email in this project. Alternatively, DNS validation can be applied. You can follow the validation instructions from the terraform ACM page.

The code for using already existing hosted zone and ssl certificate can be uncommented. incase, you already have this and want to use it rather than creating a new one.

Alternatiely, you can use the AWS CLI command to upload your website files. Just cd to the directory containing your files and run:

```
aws s3 sync . s3://www.yourdomain.com
```











