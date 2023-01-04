terraform {
    required_version = ">= 0.15"
    required_providers {
        linode = {
            source = "linode/linode"
        }
    }
     backend "s3" {}
}

provider "linode" {
    token = var.linode_api_token
}

locals {
    root_dir = "${dirname(abspath(path.root))}"
    k8s_config_dir = "${local.root_dir}/.kube/"
    k8s_config_file = "${local.root_dir}/.kube/kubeconfig.yaml"
}

variable "linode_api_token" {
description = "Your Linode API Personal Access Token. (required)"
  sensitive   = true
}

variable "k8s_version" {
    description = "The Kubernetes version to use for this cluster. (required)"
    default = "1.24"
}

variable "k8s_label" {
    description = "The unique label to assign to this cluster. (required)"
    default = "tf-k8s-cluster"
}

variable "k8s_region" {
    description = "The region where your cluster will be located. (required)"
    default = "us-east"
}

variable "tags" {
    description = "Tags to apply to your cluster for organizational purposes."
    type = list(string)
    default = ["tf-k8s-cluster"]
}

variable "pools" {
    description = "The Node Pool specifications for the Kubernetes cluster. (required)"
    type = list(object({
        type = string
        count = number
    }))
    default = [
        {
            type = "g6-standard-1"
            count = 3
        }
    ]
}

resource "linode_lke_cluster" "terraformk8s" {
    k8s_version = var.k8s_version
    label = var.k8s_label
    region = var.k8s_region
    tags = var.tags

    dynamic "pool" {
        for_each = var.pools
        content {
            type  = pool.value["type"]
            count = pool.value["count"]
        }
    }
}


resource "local_file" "k8s_config" {
    content = "${nonsensitive(base64decode(linode_lke_cluster.terraformk8s.kubeconfig))}"
    filename = "${local.k8s_config_file}"
    file_permission = "0600"
}

