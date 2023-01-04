# Rapid-fire Terraforming Kubernetes
This repository is a rapid-fire version of our in-depth tutorial for Terraforming Kubernetes on Linode with [this post](https://www.codingforentrepreneurs.com/blog/terraforming-kubernetes-on-linode/).

To get started:

## Requirements
- [Git](https://git-scm.com/downloads) installed
- [Terraform](https://developer.hashicorp.com/terraform/downloads) installed
- [Kubectl](https://kubernetes.io/docs/tasks/tools/) installed

## 1. Clone this repo

```bash
git clone https://github.com/codingforentrepreneurs/terraforming-kubernetes-rapid
cd terraforming-kubernetes-rapid
```

Create an account on [Linode](https://www.linode.com/cfe) and get an API Key in your linode account [here](https://cloud.linode.com/profile/tokens).

Once you have a key, do the following:

```bash
echo 'linode_api_token="YOUR_API_KEY"' >> terraform.tfvars
```

## 2. Initialize Terraform

```bash
terraform init
```

## 3. Terraform your Kubernetes Cluster
```bash
terraform apply
```
> Use `terraform apply -auto-approve` if you're really in a hurry.

## 4. Set your `KUBECONFIG` Environment Variable

```bash
export KUBECONFIG="./.kube/kubeconfig.yaml"
```
> If you are using VSCode, the `KUBECONFIG` variable is set in `tf-k8s.code-workspace` settings.

Verify your `KUBECONFIG` is set correctly:

```bash
kubectl get nodes
```

## 5. Deploy your first app

```bash
kubectl apply -f k8s.yaml
```

## 6. Get your app's IP address

```bash
kubectl get service cfe-nginx-service -o "jsonpath={.status.loadBalancer.ingress[0].ip}"
```

Or
```
export IP_ADDRESS=$(kubectl get service cfe-nginx-service -o "jsonpath={.status.loadBalancer.ingress[0].ip}")
open http://$IP_ADDRESS
```

## 7. Celebrate

_P.S._ Destroy everything with `terraform apply -destroy -auto-approve` to avoid incurring any charges.