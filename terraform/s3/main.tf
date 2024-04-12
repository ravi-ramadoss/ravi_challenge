data "aws_elb_service_account" "main" {}

resource "aws_s3_bucket" "lb_logs" {
  bucket = var.lb_logs_bucket_name
  tags   = var.common_tags

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1429136633762",
      "Action": [
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${var.lb_logs_bucket_name}/*",
      "Principal": {
        "AWS": [
          "${data.aws_elb_service_account.main.arn}"
        ]
      }
    }
  ]
}
POLICY


}

# resource "aws_s3_bucket_policy" "lb_logs_policy" {
#   bucket = aws_s3_bucket.lb_logs.id

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Principal = {
#           Service = "logdelivery.elasticloadbalancing.amazonaws.com"
#         }
#         Action = "s3:PutObject"
#         Resource = "arn:aws:s3:::${var.lb_logs_bucket_name}/lb_logs/*"
#       },
#     ]
#   })
# }