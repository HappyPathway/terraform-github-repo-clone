output "ssh_clone_url" {
    value = "${github_repository.repo_dest.ssh_clone_url}"
}

output "http_clone_url" {
    value = "${github_repository.repo_dest.http_clone_url}"
}

output "repo_name" {
    value = "${data.github_repository.repo_src.name}"
}
