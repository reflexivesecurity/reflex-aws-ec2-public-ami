provider "aws" {
  region = "us-east-1"
}

module "enforce_no_public_ami" {
  source           = "git@github.com:cloudmitigator/reflex.git//modules/cwe_lambda"
  rule_name        = "EnforceNoPublicAMI"
  rule_description = "Rule to check if AMI is modified to be public"

  event_pattern = <<PATTERN
{
  "detail-type": [
    "AWS API Call via CloudTrail"
  ],
  "source": [
    "aws.ec2"
  ],
  "detail": {
    "eventSource": [
      "ec2.amazonaws.com"
    ],
    "eventName": [
      "ModifyImageAttribute"
    ]
  }
}
PATTERN

  function_name            = "EnforceNoPublicAMI"
  source_code_dir          = "${path.module}/source"
  handler                  = "enforce_no_public_ami.lambda_handler"
  lambda_runtime           = "python3.7"
  environment_variable_map = { SNS_TOPIC = module.enforce_no_public_ami.sns_topic_arn }
  custom_lambda_policy     = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:DescribeImageAttribute",
        "ec2:ModifyImageAttribute"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF


  queue_name    = "EnforceNoPublicAMI"
  delay_seconds = 0

  target_id = "EnforceNoPublicAMI"

  topic_name = "EnforceNoPublicAMI"
  email      = var.email
}
