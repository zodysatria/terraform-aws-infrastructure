provider "aws" {
  version = "~> 3.0"
  region  = "us-east-1"
}

module "ec2" {
  source = "../../"

  create                      = 2
  name                        = "terraform"
  project                     = "poc-priv"
  environment                 = "development"
  ami                         = "ami-0cabc39acf991f4f1" #Amazon Linux
  instance_type               = "t2.micro"
  vpc_name                    = "poc-vpc-terraform-jody"
  associate_public_ip_address = false
  volume_size                 = 8
  user_data_file              = "setup.sh"

  security_groups_sg_id = [
    {
      from_port                = 22,
      to_port                  = 22,
      protocol                 = "tcp"
      source_security_group_id = "sg-0739d1e57c08e6462"
      description              = "Terraform poc add sg 1"
    },
    {
      from_port                = 80,
      to_port                  = 80,
      protocol                 = "tcp"
      source_security_group_id = "sg-0739d1e57c08e6462"
      description              = "Terraform poc add sg 2"
    },
  ]

  #  security_groups_cidr = [
  #    {
  #      from_port   = 22
  #      to_port     = 22
  #      protocol    = "tcp"
  #      cidr_blocks = "0.0.0.0/0"
  #      description = "Terraform poc add sg 1"
  #    },
  #    {
  #      from_port   = 80
  #      to_port     = 80
  #      protocol    = "tcp"
  #      cidr_blocks = "0.0.0.0/0"
  #      description = "Terraform poc add sg 2"
  #    },
  #  ]
}
