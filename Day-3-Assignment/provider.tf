provider "aws" {
  profile = "iamadmin-prod"
  region  = "ap-southeast-1"
  default_tags {
    tags = {
      Environment = "Test"
      Owner       = "TFProviders"
      Project     = "Test"
    }
  }

}
