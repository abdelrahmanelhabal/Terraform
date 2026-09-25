# ----------------------- VPC CONFIGURATION ----------------------- # 

vpc_name           = "business-management-vpc"
vpc_cidr_block     = "10.0.0.0/16"
azs                = [ "eu-west-1a" , "eu-west-1b" ]
public_subnets     = [ "10.0.1.0/24" , "10.0.2.0/24" ]
private_subnets    = [ "10.0.101.0/24" , "10.0.102.0/24" ]
enable_nat_gateway = true


# ----------------------- COMMON RESOURCE TAGS ----------------------- #

tags = {
  name        = "business-management"
  environment = "dev"
  project     = "business-management"
  managed_by  = "terraform"
}


# ----------------------- EKS SECURITY GROUP ----------------------- # 

eks_sg_name        = "business-management-eks-sg"
eks_sg_description = "Security group for EKS cluster"
eks_sg_ingress = [
  {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    description = "Allow node-to-node communication"
    cidr_blocks = ["10.0.0.0/16"]
  },
  {
    protocol    = "tcp"
    from_port   = 8080
    to_port     = 8080
    description = "Allow application traffic from ALB"
    cidr_blocks = ["10.0.0.0/16"]
  }
]
eks_sg_egress = [
  {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    description = "Allow all outbound traffic"
    cidr_blocks = ["0.0.0.0/0"]
  }
]


# ----------------------- APPLICATION LOAD BALANCER SECURITY GROUP ----------------------- #

alb_sg_name        = "business-management-alb-sg"
alb_sg_description = "Security group for web traffic"
alb_sg_ingress = [
  {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    description = "Allow all inbound traffic"
    cidr_blocks = ["0.0.0.0/0"]
  }
]
alb_sg_egress = [
  {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    description = "Allow all outbound traffic"
    cidr_blocks = ["0.0.0.0/0"]
  }
]


# ----------------------- EKS CLUSTER CONFIGURATION ----------------------- # 

cluster_name            = "business-management-cluster"
cluster_version         = "1.31"
eks_role_name           = "dev-eks-controle-plane"
env                     = "dev"
infrastructure_region   = "eu-west-1"
endpoint_private_access = true
endpoint_public_access  = true


# ----------------------- EKS NODE GROUP CONFIGURATION ----------------------- # 

eks_nodes_role_name       = "dev-eks-workers"
node_group_name           = "dev-worker"
node_group_desired_size   = 2
node_group_min_size       = 1
node_group_max_size       = 3
node_group_ami_type       = "AL2023_x86_64_STANDARD"
node_group_instance_types = [  "c7i-flex.large"]
node_group_disk_size      = 50
node_group_version        = "1.31"
node_group_role           = "worker"


# ----------------------- AWS LOAD BALANCER CONTROLLER ----------------------- # 

eks_alb_role_name = "dev-aws-load-balancer-controller"
alb_version       = "1.7.1"


# ----------------------- HELM / ARGO CD CONFIGURATION ----------------------- # 

helm_version       = "5.46.7"
lb_domain_name     = "argocd.example.com"
lb_scheme          = "internet-facing"
ingress_path       = "/"
ingress_group_name = "argocd-alb"


# ----------------------- ARGO CD REPLICAS ----------------------- # 

server_replica_count                     = 1
repo_server_replica_count                = 1
controller_replica_count                 = 1
application_set_controller_replica_count = 1
enable_redis_hpa                         = false