resource "aws_s3_bucket" "bucket" {
  bucket = "spcr-ftp-demo-${lower(var.env)}"
  acl    = "private"
}

resource "aws_transfer_server" "transfer_server" {
  identity_provider_type = "SERVICE_MANAGED"
  logging_role           = aws_iam_role.transfer_server_role.arn

  tags = {
    NAME = var.transfer_server_name
  }
}

resource "aws_transfer_user" "transfer_server_user" {
  count = length(var.transfer_server_user_names)

  server_id      = aws_transfer_server.transfer_server.id
  user_name      = element(var.transfer_server_user_names, count.index)
  role           = aws_iam_role.transfer_server_role.arn
  home_directory = "/${aws_s3_bucket.bucket.id}"
}

resource "aws_transfer_ssh_key" "transfer_server_ssh_key" {
  count = length(var.transfer_server_user_names)

  server_id = aws_transfer_server.transfer_server.id
  user_name = element(aws_transfer_user.transfer_server_user.*.user_name, count.index)
  body      = element(var.transfer_server_ssh_keys, count.index)
}
