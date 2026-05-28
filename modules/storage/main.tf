# Módulo de almacenamiento: bucket S3 con versionado y bloqueo de acceso público.
resource "random_id" "sufijo" {
  byte_length = var.suffix_byte_length
}

resource "aws_s3_bucket" "almacenamiento" {
  bucket = "${var.bucket_prefix}-${random_id.sufijo.hex}"
  acl    = "private"

  tags = merge(var.tags, {
    Name = var.bucket_name
  })
}

resource "aws_s3_bucket_versioning" "versionado" {
  bucket = aws_s3_bucket.almacenamiento.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "restriccion_publica" {
  bucket                  = aws_s3_bucket.almacenamiento.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
