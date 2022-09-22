provider "aws" { #provider ini sbg identifikasi credentials cloud provider yg akan di execute sama terraform nya
  version = "~> 3.0"
  region  = "ap-southeast-3"
  profile = "zodynoc1" #ini yg tadi gua sempet sounding untuk pembuatan profile aws
}

module "ec2" {                                                                  #ini moudule ec2 penamaan module nya
  source = "git@github.com:zodysatria/terraform-aws-modules-ec2.git?ref=v0.0.1" #ini source repo module nya

  #create                      = 2 #untuk multiple instance, default nya 1
  name                        = "zabbix_server"         #name ini sebagai context server nya
  project                     = "terraform"             #name project nya
  environment                 = "production"            #ini environment nya
  ami                         = "ami-0ddd469b814d7f19d" #"ami-08d4ac5b634553e16" #Ubuntu20/tipe os nya
  instance_type               = "t3.micro"              #tipe instances nya
  vpc_name                    = "vpc-example-terraform" #"poc-vpc-terraform-zody" #nama vpc yg akan di pakai oleh ec2 instance nya, disini gua buat untuk memfilter dari id ke name agar untuk mempermudah
  associate_public_ip_address = true                    #ini untuk menentukan kalau true akan di assign public subnet sebalik nya jika false akan di assign private subnet #noted : ini berkaitan dengan nama format vpc nya jadi harus ada nama vpc nya sekali lagi untuk mempermudah
  volume_size                 = 8                       #ini volume size untuk disk
  user_data_file              = "setup.sh"              #jika butuh script untuk install kalau tidak di pakai bisa di comment aja

  #  security_groups_sg_id = [ #ini di pakai kalau mau nge add sg dengan id yang ada di existing aws
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

  security_groups_cidr = [ #ini untuk konek ke cidr/public dengan IP
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

# yang di create sama terraform nya
#1. instance
#2. id_rsa
#3. security_groups

#naming nya akan ngecount dari index mulai dari 01 - sesuai count server yang di create
