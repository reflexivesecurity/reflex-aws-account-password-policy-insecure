variable "cloudwatch_event_rule_id" {
  description = "Easy name of CWE"
  type        = string
}

variable "cloudwatch_event_rule_arn" {
  description = "Full arn of CWE"
  type        = string
}

variable "sns_topic_arn" {
  description = "SNS topic arn of central or local sns topic"
  type        = string
}

variable "reflex_kms_key_id" {
  description = "KMS Key Id for common reflex usage."
  type        = string
}

variable "package_location" {
  description = "Path for the Lambda deployment package"
  type        = string
  default     = "../package_build/account-password-policy-insecure.zip"
}

variable "minimum_password_length" {
  description = "Minimum characters for password required."
  type        = number
  default     = 8
}

variable "require_symbols" {
  description = "Require symbols in password"
  type        = bool
  default     = true
}

variable "require_numbers" {
  description = "Require numbers in password"
  type        = bool
  default     = true
}

variable "require_uppercase_characters" {
  description = "Require upper characters in password."
  type        = bool
  default     = true
}

variable "require_lowercase_characters" {
  description = "Require lower characters in password."
  type        = bool
  default     = true
}

variable "allow_users_to_change_password" {
  description = "Allow users to change password"
  type        = bool
  default     = true
}

variable "max_password_age" {
  description = "Maximume age in days of password (0 for none)"
  type        = number
  default     = 0
}

variable "password_reuse_prevention" {
  description = "Number of passwords to prevent reuse (0 for no prevention)."
  type        = number
  default     = 0
}

variable "hard_expiry" {
  description = "Whether or not to lock out users with expired passwords."
  type        = bool
  default     = false
}

variable "mode" {
  description = "The mode that the Rule will operate in. Valid choices: DETECT | REMEDIATE"
  type        = string
  default     = "detect"
}
