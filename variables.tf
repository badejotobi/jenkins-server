variable "region" {
  default = "us-west-1"
}

variable "rules" {
  default = [
    {
      port        = 80
      proto       = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 22
      proto       = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 8080
      proto       = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 3306
      proto       = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}
