terraform {
  backend "s3" {
    bucket = "dissertation-state-store"
    key   = "terraform.tfstate"
    use_lockfile = true
    region = "eu-west-1"
  }
}
