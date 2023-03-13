provider "aws" {
  region = "local"
}

module "athena" {
  source = "./.."

  name                    = "alb-logs-example-production"
  workspace_bucket_prefix = "athena-workgroup"

  tags = {
    app = "some-service"
    env = "production"
  }
}
