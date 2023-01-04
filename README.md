# Rapid-fire Terraforming Kubernetes
This repository is a rapid-fire version of our in-depth tutorial for Terraforming Kubernetes on Linode with [this post](https://www.codingforentrepreneurs.com/blog/terraforming-kubernetes-on-linode/).

To get started:

## Requirements
- [Git](https://git-scm.com/downloads) installed
- [Terraform](https://developer.hashicorp.com/terraform/downloads) installed
- [Kubectl](https://kubernetes.io/docs/tasks/tools/) installed

## 1. Clone this repo

```
git clone https://github.com/codingforentrepreneurs/terraforming-kubernetes-rapid
cd terraforming-kubernetes-rapid
```

Create an account on [Linode](https://www.linode.com/cfe) and get an API Key in your linode account [here](https://cloud.linode.com/profile/tokens).

Once you have a key, do the following:

```
echo 'linode_api_token="YOUR_API_KEY"' >> terraform.tfvars
```

## 2. Initialize Terraform

```
terraform init
```

## 3. Terraform your Kubernetes Cluster
```
terraform apply
```

## 4. Set your `KUBECONFIG` Environment Variable

```
export KUBECONFIG="./kube/kubeconfig.yaml"
```
> If you are using VSCode, the `KUBECONFIG` variable is set in `tf-k8s.code-workspace` settings.


## 5. Deploy your first app

```
kubectl apply -f k8s.yaml
```

## 6. Get your app's IP address

```
KUBECONFIG="./kube/kubeconfig.yaml" kubectl get service cfe-nginx-service -o "jsonpath={.status.loadBalancer.ingress[0].ip}"
```

## 7. Celebrate