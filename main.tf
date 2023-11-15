# this is given for reference, in most cases you will want to set the region using environment variables
provider "aws" {
  region = "us-west-2"
}

# AWS reserves the first four IP addresses and the last IP address in any CIDR block for its own use (cumulatively)
module "Live-Rke2" {
  source              = "rancher/access/aws"
  version             = "0.1.0"
  owner               = "kevinaryes"
  vpc_name            = "live-infra"
  vpc_cidr            = "10.0.255.0/24" # gives 256 usable addresses from .1 to .254, but AWS reserves .1 to .4 and .255, leaving .5 to .254
  subnet_name         = "live-infra"
  subnet_cidr         = "10.0.255.224/28" # gives 14 usable addresses from .225 to .238, but AWS reserves .225 to .227 and .238, leaving .227 to .237
  availability_zone   = "us-west-1b"      # check what availability zones are available in your region before setting this
  security_group_name = "live-infra"
  security_group_type = "egress"
  public_ssh_key      = file("${abspath(path.root)}/public_ssh_key")
  ssh_key_name        = "kevin"
}
