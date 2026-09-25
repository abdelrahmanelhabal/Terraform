# --------------------------- VPC CONFIGURATION --------------------------- #
variable "vpc_name" {
  type        = string
  description = "Name of the VPC."
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC, for example 10.0.0.0/16."
}

variable "azs" {
  type        = list(string)
  description = "List of Availability Zones used by the VPC."
}

variable "public_subnets" {
  type        = list(string)
  description = "CIDR blocks for the public subnets."
}

variable "private_subnets" {
  type        = list(string)
  description = "CIDR blocks for the private subnets."
}

variable "enable_nat_gateway" {
  type        = bool
  default     = false
  description = "Whether to create and enable a NAT Gateway."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Common tags applied to AWS resources."
}


# --------------------------- EKS SECURITY GROUP CONFIGURATION --------------------------- # 

variable "eks_sg_name" {
  type        = string
  description = "Name of the security group used by EKS."
}

variable "eks_sg_description" {
  type        = string
  description = "Description of the EKS security group."
}

variable "eks_sg_ingress" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))

  description = "Ingress rules for the EKS security group."
}

variable "eks_sg_egress" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))

  description = "Egress rules for the EKS security group."
}


# --------------------------- ALB SECURITY GROUP CONFIGURATION --------------------------- # 

variable "alb_sg_name" {
  type        = string
  description = "Name of the security group used by the Application Load Balancer."
}

variable "alb_sg_description" {
  type        = string
  description = "Description of the ALB security group."
}

variable "alb_sg_ingress" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))

  description = "Ingress rules for the ALB security group."
}

variable "alb_sg_egress" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))

  description = "Egress rules for the ALB security group."
}


# --------------------------- EKS CLUSTER CONFIGURATION --------------------------- # 

variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster."
}

variable "cluster_version" {
  type        = string
  description = "Kubernetes version of the EKS cluster."
}

variable "eks_role_name" {
  type        = string
  description = "IAM role name used by the EKS control plane."
}

variable "env" {
  type        = string
  description = "Deployment environment, for example dev, staging, or prod."
}

variable "infrastructure_region" {
  type        = string
  description = "AWS region where the infrastructure is deployed."
}

variable "endpoint_private_access" {
  type        = bool
  description = "Whether private access to the EKS API endpoint is enabled."
}

variable "endpoint_public_access" {
  type        = bool
  description = "Whether public access to the EKS API endpoint is enabled."
}


# --------------------------- EKS NODE GROUP CONFIGURATION --------------------------- # 

variable "eks_nodes_role_name" {
  type        = string
  description = "IAM role name used by EKS worker nodes."
}

variable "node_group_name" {
  type        = string
  description = "Name of the EKS node group."
}

variable "node_group_desired_size" {
  type        = number
  description = "Desired number of nodes in the EKS node group."
}

variable "node_group_min_size" {
  type        = number
  description = "Minimum number of nodes allowed in the EKS node group."
}

variable "node_group_max_size" {
  type        = number
  description = "Maximum number of nodes allowed in the EKS node group."
}

variable "node_group_ami_type" {
  type        = string
  description = "AMI type used by the EKS worker nodes, for example AL2023_x86_64_STANDARD."
}

variable "node_group_instance_types" {
  type        = list(string)
  description = "List of EC2 instance types used by the EKS worker nodes."
}

variable "node_group_disk_size" {
  type        = number
  description = "Disk size in GiB for each EKS worker node."
}

variable "node_group_version" {
  type        = string
  description = "Kubernetes version used by the EKS node group."
}

variable "node_group_role" {
  type        = string
  description = "Role or configuration identifier used for the EKS node group."
}


# --------------------------- AWS LOAD BALANCER CONTROLLER --------------------------- # 

variable "eks_alb_role_name" {
  type        = string
  description = "IAM role name used by the AWS Load Balancer Controller."
}

variable "alb_version" {
  type        = string
  description = "Helm chart version of the AWS Load Balancer Controller."
}


# --------------------------- HELM CONFIGURATION --------------------------- # 

variable "helm_version" {
  type        = string
  description = "Version of the Helm provider used by Terraform."
}


# --------------------------- LOAD BALANCER / INGRESS CONFIGURATION --------------------------- # 

variable "lb_domain_name" {
  type        = string
  description = "Domain name used by the load balancer ingress."
}

variable "lb_scheme" {
  type        = string
  description = "Load balancer scheme, such as internet-facing or internal."
}

variable "ingress_path" {
  type        = string
  description = "Path used by the Kubernetes ingress."
}

variable "ingress_group_name" {
  type        = string
  description = "AWS ALB ingress group name used to share an ALB between ingresses."
}


# --------------------------- ARGO CD CONFIGURATION --------------------------- # 

variable "server_replica_count" {
  type        = number
  description = "Number of replicas for the Argo CD server."
}

variable "repo_server_replica_count" {
  type        = number
  description = "Number of replicas for the Argo CD repository server."
}

variable "controller_replica_count" {
  type        = number
  description = "Number of replicas for the Argo CD application controller."
}

variable "application_set_controller_replica_count" {
  type        = number
  description = "Number of replicas for the Argo CD ApplicationSet controller."
}

variable "enable_redis_hpa" {
  type        = bool
  description = "Whether to enable Horizontal Pod Autoscaling for Argo CD Redis."
}