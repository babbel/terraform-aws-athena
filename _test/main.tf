provider "aws" {
  region = "local"
}

module "athena" {
  source = "./.."

  name             = "alb-logs-example-production"
  workgroup_bucket = "athena-workgroup-alb-logs-example-production"

  default_tags = {
    app = "some-service"
    env = "production"
  }
}
