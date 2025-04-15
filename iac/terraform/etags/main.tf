resource "aws_s3_bucket" "example" {
}
resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.example.id
  key    = "data.txt"
  source = "data.txt"
  etag = filemd5("data.txt")
}