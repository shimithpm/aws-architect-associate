resource "aws_s3_bucket" "mys3bucket" {
  bucket = "my-tf-test-bucket-shimithdemo"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}