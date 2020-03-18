module "reflex_aws_account_password_policy_deleted" {
  source           = "git::https://github.com/cloudmitigator/reflex-engine.git//modules/cwe_lambda?ref=v0.5.4"
  rule_name        = "AccountPasswordPolicyDeletedRule"
  rule_description = "Detects the deletion of an account password policy"

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
      "DeleteAccountPasswordPolicy"
    ]
  }
}
PATTERN

  function_name   = "AccountPasswordPolicyDeletedRule"
  source_code_dir = "${path.module}/source"
  handler         = "reflex_aws_account_password_policy_deleted.lambda_handler"
  lambda_runtime  = "python3.7"
  environment_variable_map = {
    SNS_TOPIC = var.sns_topic_arn,
    
  }

  queue_name    = "AccountPasswordPolicyDeletedRule"
  delay_seconds = 0

  target_id = "AccountPasswordPolicyDeletedRule"

  sns_topic_arn  = var.sns_topic_arn
  sqs_kms_key_id = var.reflex_kms_key_id
}
