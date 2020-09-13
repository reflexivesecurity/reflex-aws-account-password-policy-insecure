module "cwe" {
  source      = "git::https://github.com/reflexivesecurity/reflex-engine.git//modules/cwe?ref=v2.1.0"
  name        = "AccountPasswordPolicyInsecureRule"
  description = "Ensures the account password policy remains in a secure state"

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

}
