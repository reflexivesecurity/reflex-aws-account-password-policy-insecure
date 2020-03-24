module "reflex_aws_account_password_policy_insecure" {
  source           = "git::https://github.com/cloudmitigator/reflex-engine.git//modules/cwe_lambda?ref=v0.5.4"
  rule_name        = "AccountPasswordPolicyInsecureRule"
  rule_description = "Ensures the account password policy remains in a secure state"

  event_pattern = <<PATTERN
{
  "source": [
    "aws.iam"
  ],
  "detail-type": [
    "AWS API Call via CloudTrail"
  ],
  "detail": {
    "eventSource": [
      "iam.amazonaws.com"
    ],
    "eventName": [
      "UpdateAccountPasswordPolicy",
      "DeleteAccountPasswordPolicy"
    ]
  }
}
PATTERN

  function_name   = "AccountPasswordPolicyInsecureRule"
  source_code_dir = "${path.module}/source"
  handler         = "reflex_aws_account_password_policy_insecure.lambda_handler"
  lambda_runtime  = "python3.7"
  environment_variable_map = {
    SNS_TOPIC = var.sns_topic_arn,
    
  }
  custom_lambda_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iam:GetAccountPasswordPolicy",
        "iam:UpdateAccountPasswordPolicy"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF

  queue_name    = "AccountPasswordPolicyInsecureRule"
  delay_seconds = 0

  target_id = "AccountPasswordPolicyInsecureRule"

  sns_topic_arn  = var.sns_topic_arn
  sqs_kms_key_id = var.reflex_kms_key_id
}
