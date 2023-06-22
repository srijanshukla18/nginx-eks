# nginx-eks

This project deploys the plain old nginx container in EKS.
Terraform modules are made of use for basic networking and setting up the EKS cluster.

# Setup steps:
1. Clone this repo
2. Make sure you have terraform installed and AWS credentials set. This code is tested against terraform version 1.5.1
3. Run 'terraform apply', Enter 'yes' when prompted.
4. You should see an output which will contain the hostname of the nginx service deployment and in the current directory there will be a kubeconfig file created which can be used to access the Kubernetes cluster.
