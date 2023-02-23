terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

// This aws provider is the default where majority of the
// components will be created.
provider "aws" {
  region = "us-east-1"
}

// This aws provider is specifically for SSL cert as it needs
// to be created in us-east-1 for cloudfront to use it.
/*provider "aws" {
  alias  = "acm_provider"
  region = "us-east-1"
}*/