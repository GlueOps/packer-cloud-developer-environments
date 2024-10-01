# custom-img-v2.pkr.hcl
variable "base_image" {
  type    = string
  default = "debian-12"
}

variable "server_name" {
  type    = string
  default = "image"
}

variable "version" {
  type    = string
  default = "v1.0.0"
}

variable "glueops_codespaces_container_tag" {
  type = string
}

source "hcloud" "base-amd64" {
  image         = var.base_image
  location      = "nbg1"
  server_type   = "cx11"
  server_name   = "${var.server_name}-${var.version}"
  ssh_username  = "root"
  snapshot_name = "${var.version}"
  snapshot_labels = {
    base    = var.base_image,
    version = var.version
  }
}

build {
  sources = ["source.hcloud.base-amd64"]
  provisioner "shell" {
    scripts = [
      "os-setup.sh",
    ]
    env = {
      BUILDER = "packer"
    }
  }
  provisioner "shell" {
    inline = [
      "sudo docker pull ghcr.io/glueops/codespaces:${var.glueops_codespaces_container_tag}",
    ]
  }
}

# packer.pkr.hcl
packer {
  required_plugins {
    hcloud = {
      source  = "github.com/hetznercloud/hcloud"
      version = ">= 1.2.0"
    }
  }
}