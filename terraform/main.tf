
provider "aws" {
  region = "us-west-2"
}

data "aws_route53_zone" "main" {
  name = "raviramadoss.me"
}

module "vpc" {
  source = "./vpc"
  common_tags = var.common_tags
  name_prefix       = var.name_prefix
}

module "dns" {
  source = "./dns"
  lb_dns_name = module.load_balancer.lb_dns_name
  lb_zone_id = module.load_balancer.lb_zone_id
  common_tags = var.common_tags
  name_prefix = var.name_prefix
  sub_domain_name = var.sub_domain_name
}

module "certificate" {
  source = "./certificate"
  sub_domain_name = var.sub_domain_name
  zone_id = data.aws_route53_zone.main.zone_id
  common_tags = var.common_tags
  name_prefix       = var.name_prefix
}

module "load_balancer" {
  source = "./load_balancer"
  vpc_id = module.vpc.vpc_id
  subnet_1_id = module.vpc.subnet_1_id
  subnet_2_id = module.vpc.subnet_2_id
  security_group_id = module.security_group.lb_security_group_id
  use_blue = var.use_blue
  common_tags = var.common_tags
  lb_logs_bucket = module.s3.lb_logs_bucket
  name_prefix = var.name_prefix
  subdomain_certificate_arn = module.certificate.subdomain_certificate_arn
}

module "ec2" {
  source = "./ec2"
  blue_target_group_arn = module.load_balancer.blue_target_group_arn
  green_target_group_arn = module.load_balancer.green_target_group_arn
  common_tags = var.common_tags
  ami_id = var.ami_id
  key_name = var.key_name
  subnet_1_id = module.vpc.subnet_1_id 
  subnet_2_id = module.vpc.subnet_2_id
  ec2_security_group_id = module.security_group.ec2_security_group_id
  lb_security_group_id = module.security_group.lb_security_group_id
  name_prefix = var.name_prefix
}

module "security_group" {
  source = "./security_group"
  vpc_id = module.vpc.vpc_id
  common_tags = var.common_tags
  name_prefix       = var.name_prefix
  
}

module "s3" {
  source = "./s3"
  common_tags = var.common_tags
  lb_logs_bucket_name = var.lb_logs_bucket_name
  lb_arn = module.load_balancer.lb_arn
  account_id = var.account_id
  name_prefix       = var.name_prefix
}

