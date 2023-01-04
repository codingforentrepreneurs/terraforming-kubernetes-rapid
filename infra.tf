terraform {
    required_version = ">= 0.15"
    required_providers {
        linode = {
            source = "linode/linode"
        }
    }
}

provider "linode" {
    token = var.linode_api_token
}

locals {
    root_dir = "${abspath(path.root)}"
    k8s_config_dir = "${local.root_dir}/.kube/"
    k8s_config_file = "${local.root_dir}/.kube/kubeconfig.yaml"
}

variable "linode_api_token" {
    description = "Your Linode API Personal Access Token. (required)"
    sensitive   = true
}

resource "linode_lke_cluster" "terraform_k8s" {
    k8s_version="1.24"
    label="terraform-k8s"
    region="us-east"
    tags=["terraform-k8s"]
    pool {
        type  = "g6-standard-1"
        count = 3

    }
}

resource "local_file" "k8s_config" {
    content = "${nonsensitive(base64decode(linode_lke_cluster.terraform_k8s.kubeconfig))}"
    filename = "${local.k8s_config_file}"
    file_permission = "0600"
}

