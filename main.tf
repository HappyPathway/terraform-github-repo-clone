provider "github" {}

variable "repo_dir" {
  default = "/tmp/repo"
}

data "github_repository" "repo_src" {
  full_name = "${var.repo_src}"
}

resource "null_resource" "clone" {
  triggers = {
    clone_trigger = "${data.github_repository.repo_src.name}"
  }
  provisioner "local-exec" {
    command = "rm -rf ${var.repo_dir}; git clone ${data.github_repository.repo_src.http_clone_url} ${var.repo_dir}"
  }
}

resource "github_repository" "repo_dest" {
  name        = "${data.github_repository.repo_src.name}"
  description = "${data.github_repository.repo_src.name}"
  gitignore_template = "Terraform"
  private = false
}

resource "null_resource" "push" {
  depends_on = [
    "null_resource.clone"
  ]
  triggers = {
    push_trigger = "${github_repository.repo_dest.name}"
  }
  provisioner "local-exec" {
    command = "cd ${var.repo_dir}; rm -rf .git*; git init; git remote add origin ${github_repository.repo_dest.ssh_clone_url}; git pull origin master; git add .; git commit -m 'initial add'; git push -u origin master"
  }
}