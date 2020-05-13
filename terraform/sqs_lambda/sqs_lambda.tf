module "sqs_lambda" {

  function_name   = "AccountPasswordPolicyInsecureRule"
  source_code_dir = "${path.module}/source"
  handler         = "reflex_aws_account_password_policy_insecure.lambda_handler"
  lambda_runtime  = "python3.7"
  environment_variable_map = {
    SNS_TOPIC = var.sns_topic_arn,
    MODE      = var.mode,
    MINIMUM_PASSWORD_LENGTH = var.minimum_password_length,
    REQUIRE_SYMBOLS = var.require_symbols,
    REQUIRE_NUMBERS = var.require_numbers,
    REQUIRE_UPPERCASE_CHARACTERS = var.require_uppercase_characters,
    REQUIRE_LOWERCASE_CHARACTERS = var.require_lowercase_characters,
    ALLOW_USERS_TO_CHANGE_PASSWORD = var.allow_users_to_change_password,
    MAX_PASSWORD_AGE = var.max_password_age,
    PASSWORD_REUSE_PREVENTION = var.password_reuse_prevention,
    HARD_EXPIRY = var.hard_expiry
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

}
