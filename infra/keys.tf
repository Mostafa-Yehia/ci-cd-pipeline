resource "tls_private_key" "tls" {
  algorithm = "RSA"
}

resource "aws_key_pair" "my-kp" {
  key_name   = "my-kp"
  public_key = tls_private_key.tls.public_key_openssh
  tags = {
    Name = "my-kp"
  }
}
resource "aws_secretsmanager_secret" "my-sm-2" {
  name = "my-sm-2"
}

resource "aws_secretsmanager_secret_version" "my-smv" {
  secret_id     = aws_secretsmanager_secret.my-sm-2.id
  secret_string = tls_private_key.tls.private_key_pem
}

resource "local_file" "private_key" {
  depends_on = [
    tls_private_key.tls,
  ]
  content  = tls_private_key.tls.private_key_pem
  filename = "~/private.pem"
}

