terraform { # Required version of Terraform needs to be greater than or equal to 1.3.0
  required_version = ">= 1.3.0"

  required_providers { # Setting aws as the provider, getting the terraform init details from hashicorp, and the version of this has to be greater than 5.0
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "local" { # Using local Terraform rather than remote (Terraform cloud)
    path = "terraform.tfstate"
  }
}

provider "aws" { # Setting the region we are using in AWS.  This comes from a variable set in variables.tf
  region = var.aws_region
}