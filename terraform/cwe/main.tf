module "cwe" {
  source      = "git::https://github.com/cloudmitigator/reflex-engine.git//modules/cwe?ref=v0.6.0"
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
