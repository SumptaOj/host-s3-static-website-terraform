// Create a variable for root domain name
variable "root_domain_name" {
  type        = string
  description = "The domain name of the website."
}

// Create a variable for our subdomain 
variable "www_domain_name" {
  type        = string
  description = "The redirect_domain name of the website."
}

// create a tag for our project
variable "hosting_tags" {
  description = "Common tags to be applied to all components."
}
