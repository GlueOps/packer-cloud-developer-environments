variable "aws_access_key" {
  type = string
}

variable "aws_secret_key" {
  type = string
}

#https://github.com/GlueOps/codespaces/pkgs/container/codespaces
variable "glueops_codespaces_container_tag" {
  type = string
}

source "amazon-ebs" "example" {
  access_key    = "${var.aws_access_key}"
  secret_key    = "${var.aws_secret_key}"
  region        = "us-west-2"
  source_ami    = "ami-0efcece6bed30fd98" // Use a valid base AMI ID
  instance_type = "t3a.large"
  ssh_username  = "ubuntu"
  launch_block_device_mappings {
    device_name           = "/dev/sda1"
    volume_size           = 50
    volume_type           = "gp2"
    delete_on_termination = true
  }
  ami_virtualization_type = "hvm"
  ami_regions             = ["us-west-2", "us-east-1"]

  ami_name = "{{timestamp}}-${var.glueops_codespaces_container_tag}"
}

build {
  sources = ["source.amazon-ebs.example"]

  provisioner "file" {
    source      = ".glueopsrc"
    destination = "/home/ubuntu/.glueopsrc"
  }

  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/glueops-bootstrap.sh"
  }
  provisioner "shell" {
    inline = [
      "sudo /tmp/glueops-bootstrap.sh"
    ]
  }

  provisioner "shell" {
    inline = [
      "sudo docker pull ghcr.io/glueops/codespaces:${var.glueops_codespaces_container_tag}"
    ]
  }

}




packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
  }
}
