variable "aws_region" {      # Defining a variable called aws_region
  description = "AWS region" # A description of the variable
  type        = string       # Setting the variable as a string (text)
  default     = "eu-west-1"  # the variable will contain the string "eu-west-1"
}

variable "key_pair_name" {                                # DEfining a variable called key_pair_name
  description = "Name of the AWS key pair to use for RDP" # A description of the variable
  type        = string                                    # Setting the variable as a string (text)
  # Note - This is a empty variable and will be filed by the EC2 instance in main.tf
}