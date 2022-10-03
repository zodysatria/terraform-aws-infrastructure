provider "aws" {
  version = "~> 3.0"
  region  = "ap-southeast-3"
  profile = "zodynoc1"
}

module "ec2" {
  source = "git@github.com:zodysatria/terraform-aws-modules-ec2.git?ref=v0.0.1"

  name                        = "vip"
  project                     = "terraform"
  environment                 = "production"
  ami                         = "ami-06704743af22a1200" #Ubuntu 20.04
  instance_type               = "t2.micro"
  vpc_name                    = "vpc-example-terraform"
  associate_public_ip_address = true
  volume_size                 = 8
  user_data_file              = "setup.sh"

  #  security_groups_sg_id = [
  #    {
  #      from_port                = 22,
  #      to_port                  = 22,
  #      protocol                 = "tcp"
  #      source_security_group_id = "sg-0c1011e9e5e6ec8e6"
  #      description              = "example add sg 1"
  #    },
  #    {
  #      from_port                = 80,
  #      to_port                  = 80,
  #      protocol                 = "tcp"
  #      source_security_group_id = "sg-0c1011e9e5e6ec8e6"
  #      description              = "example add sg 2"
  #    },
  #  ]

  security_groups_cidr = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
      description = "Terraform poc add sg 1"
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
      description = "Terraform poc add sg 2"
    },
  ]
}
