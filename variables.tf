variable "region" {
  description = "The AWS region to deploy in"
  default     = "us-west-2"
}

variable "instance_type" {
  description = "The type of instance to use on AWS ONLY"
  default     = "t2.micro"
}
