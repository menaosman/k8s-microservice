variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "stage-eks-cluster"
}

variable "node_desired_capacity" {
  description = "Number of worker nodes"
  type        = number
  default     = 2
}
