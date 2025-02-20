provider "aws" {
    region = "us-east-2"
    profile = "scale"
}

provider "aws" {
    region = "us-east-1"
    profile = "scale"
    alias = "us-east-1"
}