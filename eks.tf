data "aws_ami" "eks_worker" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-1.27-v*"]
  }

  most_recent = true
  owners      = ["602401143452"] # Amazon EKS AMI account ID
}

module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name    = "my-eks-cluster"
  cluster_version = "1.27"
  subnet_ids      = module.vpc.public_subnets
  vpc_id          = module.vpc.vpc_id

  cluster_endpoint_public_access = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  eks_managed_node_group_defaults = {
    disk_size = 10
  }

  eks_managed_node_groups = {
    general = {
      desired_size = 1
      min_size     = 1
      max_size     = 10

      labels = {
        role = "general"
      }

      instance_types = ["t3.small"]
      capacity_type  = "ON_DEMAND"
    }
  }

}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
}