# --------------------------------------- VPC ---------------------------------------v # 

module "vpc" {
  source = "git::ssh://git@github.com/abdelrahmanelhabal/tf-modules.git//modules/vpc?ref=main"

  name               = var.vpc_name
  cidr_block         = var.vpc_cidr_block
  azs                = var.azs
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  cluster_name       = var.cluster_name
  enable_nat_gateway = var.enable_nat_gateway
  tags               = var.tags
}


# --------------------------------------- EKS SECURITY GROUP --------------------------------------- #

module "eks_sg" {
  source = "git::ssh://git@github.com/abdelrahmanelhabal/tf-modules.git//modules/security_group?ref=main"

  security_groups = {
    (var.eks_sg_name) = {
      vpc_id          = module.vpc.vpc_id
      description     = var.eks_sg_description
      ingress         = var.eks_sg_ingress
      egress          = var.eks_sg_egress
    }
  }

  tags = merge(
    var.tags,
    {
      Name = var.eks_sg_name
    }
  )
}


# --------------------------------------- ALB SECURITY GROUP --------------------------------------- # 

module "alb_sg" {
  source = "git::ssh://git@github.com/abdelrahmanelhabal/tf-modules.git//modules/security_group?ref=main"

  security_groups = {
    (var.alb_sg_name) = {
      vpc_id          = module.vpc.vpc_id
      description     = var.alb_sg_description
      ingress         = var.alb_sg_ingress
      egress          = var.alb_sg_egress
    }
  }

  tags = merge(
    var.tags,
    {
      Name = var.alb_sg_name
    }
  )
}


# --------------------------------------- EKS CLUSTER --------------------------------------- #

module "eks" {
  source = "git::ssh://git@github.com/abdelrahmanelhabal/tf-modules.git//modules/eks?ref=main"

  cluster_name            = var.cluster_name
  cluster_version         = var.cluster_version
  eks_role_name           = var.eks_role_name
  env                     = var.env
  infrastructure_region   = var.infrastructure_region
  subnets_ids             = module.vpc.private_subnet_ids
  eks_sg_ids              = module.eks_sg.security_group_ids
  endpoint_private_access = var.endpoint_private_access
  endpoint_public_access  = var.endpoint_public_access

  tags = merge(
    var.tags,
    {
      Name = var.cluster_name
    }
  )
}


# --------------------------------------- EKS ACCESS --------------------------------------- # 
 
data "aws_caller_identity" "current" {}

resource "aws_eks_access_entry" "terraform" {
  cluster_name  = module.eks.cluster_name
  principal_arn = data.aws_caller_identity.current.arn

  depends_on = [    module.eks   ]
}

resource "aws_eks_access_policy_association" "terraform" {

  cluster_name  = module.eks.cluster_name
  principal_arn = data.aws_caller_identity.current.arn
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }

  depends_on = [
    aws_eks_access_entry.terraform
  ]
}


# --------------------------------------- EKS NODE GROUP --------------------------------------- # 

module "nodegroup" {
  source = "git::ssh://git@github.com/abdelrahmanelhabal/tf-modules.git//modules/eks_nodegroup?ref=main"

  cluster_name = var.cluster_name
  eks_nodes_role_name        = var.eks_nodes_role_name
  node_group_name            = var.node_group_name
  node_group_desired_size    = var.node_group_desired_size
  node_group_min_size        = var.node_group_min_size
  node_group_max_size        = var.node_group_max_size
  node_group_subnets         = module.vpc.private_subnet_ids
  node_group_ami_type        = var.node_group_ami_type
  node_group_instance_types  = var.node_group_instance_types
  node_group_disk_size       = var.node_group_disk_size
  node_group_version         = var.node_group_version
  node_group_role            = var.node_group_role
}


# --------------------------------------- EKS ADDON - AWS LOAD BALANCER CONTROLLER --------------------------------------- # 

module "alb" {
  source = "git::ssh://git@github.com/abdelrahmanelhabal/tf-modules.git//modules/eks_addons/alb?ref=main"

  vpc_id            = module.vpc.vpc_id
  eks_alb_role_name = var.eks_alb_role_name
  cluster_name      = var.cluster_name
  alb_version       = var.alb_version
  oidc_provider_arn = module.eks.oidc_provider_arn
  oidc_provider_url = module.eks.oidc_provider_url

  depends_on = [
    module.eks,
    module.nodegroup
  ]
}

# --------------------------------------- EKS ADDON - ARGO CD --------------------------------------- # 

module "argocd" {
  source = "git::ssh://git@github.com/abdelrahmanelhabal/tf-modules.git//modules/eks_addons/argo_cd?ref=main"

  helm_version                             = var.helm_version
  node_group_name                          = var.node_group_name
  lb_domain_name                           = var.lb_domain_name
  lb_scheme                                = var.lb_scheme
  ingress_path                             = var.ingress_path
  ingress_group_name                       = var.ingress_group_name
  lb_security_group1                       = module.alb_sg.security_group_ids[0]
  lb_security_group2                       = module.eks_sg.security_group_ids[0]
  lb_subnet1                               = module.vpc.public_subnet_ids[0]
  lb_subnet2                               = module.vpc.public_subnet_ids[1]
  server_replica_count                     = var.server_replica_count
  repo_server_replica_count                = var.repo_server_replica_count
  controller_replica_count                 = var.controller_replica_count
  application_set_controller_replica_count = var.application_set_controller_replica_count
  enable_redis_hpa                         = var.enable_redis_hpa

  depends_on = [
    module.eks,
    module.nodegroup
  ]
}


# --------------------------------------- EKS ADDON - EBS CSI DRIVER --------------------------------------- # 

module "ebs_csi" {
  source = "git::ssh://git@github.com/abdelrahmanelhabal/tf-modules.git//modules/eks_addons/ebs_csi?ref=main"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  depends_on = [
    module.eks,
    module.nodegroup
  ]
}