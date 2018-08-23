variable "repo_src" {
    type = "string"
    description = "Name of Source Repo, must be in form <GithubOrg>/<GithubRepo>"
}
variable "repo_dir" {
    type = "string"
    description = "Location to save repo on Local System"
}
variable "module" {
    default = false
    type = "string"
    description = "Is this a Terraform Module? if so, set to true"
}
