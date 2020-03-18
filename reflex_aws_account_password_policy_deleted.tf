module "reflex_aws_account_password_policy_deleted" {
  source           = "git::https://github.com/cloudmitigator/reflex-engine.git//modules/cwe_lambda"
  rule_name        = "AccountPasswordPolicyDeletedRule"
  rule_description = "TODO: Provide rule description"

  event_pattern = <<PATTERN
# TODO: Provide event pattern
PATTERN

  function_name   = "AccountPasswordPolicyDeletedRule"
  source_code_dir = "${path.module}/source"
  handler         = "reflex_aws_account_password_policy_deleted.lambda_handler"
  lambda_runtime  = "python3.7"
  environment_variable_map = {
    SNS_TOPIC = var.sns_topic_arn,
    
  }
  custom_lambda_policy = <<EOF
# TODO: Provide required lambda permissions policy
EOF



  queue_name    = "AccountPasswordPolicyDeletedRule"
  delay_seconds = 0

  target_id = "AccountPasswordPolicyDeletedRule"

  sns_topic_arn  = var.sns_topic_arn
  sqs_kms_key_id = var.reflex_kms_key_id
}