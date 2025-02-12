resource "aws_instance" "ec2-worker-nodes" {
  ami           = "ami-085ad6ae776d8f09c"
  instance_type = "t2.micro"
  count         = 5

  tags = {
    Name = "scale-test-ec2-nodes"
  }
}
