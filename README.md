# reflex-aws-account-password-policy-insecure
A Reflex rule for ensuring the account password policy remains in a secure state.

To learn more about Account Password Policies, see [the AWS Documentation](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_passwords_account-policy.html).

For more information on changing Account Password Policies, see [the AWS Documentation on updating Account Password Policies](https://docs.aws.amazon.com/IAM/latest/APIReference/API_UpdateAccountPasswordPolicy.html).

## Getting Started
To get started using Reflex, check out [the Reflex Documentation](https://docs.cloudmitigator.com/).

## Usage
To use this rule either add it to your `reflex.yaml` configuration file:  
```
rules:
  aws:
    - reflex-aws-account-password-policy-insecure:
        configuration:
          minimum_password_length: 10
          require_symbols: False
          require_numbers: True
          require_uppercase_characters: True
          require_lowercase_characters: True
          allow_users_to_change_password: True
          max_password_age: 365
          password_reuse_prevention: 1
          hard_expiry: False
        version: latest
```

or add it directly to your Terraform:  
```
module "account-password-policy-insecure" {
  source            = "git::https://github.com/cloudmitigator/reflex-aws-account-password-policy-insecure.git?ref=v0.2.0"
  sns_topic_arn                  = module.central-sns-topic.arn
  reflex_kms_key_id              = module.reflex-kms-key.key_id
  minimum_password_length        = "10"
  require_symbols                = "False"
  require_numbers                = "True"
  require_uppercase_characters   = "True"
  require_lowercase_characters   = "True"
  allow_users_to_change_password = "True"
  max_password_age               = "365"
  password_reuse_prevention      = "1"
  hard_expiry                    = "False"
  mode                           = "remediate"
}
```

Note: The `sns_topic_arn` and `reflex_kms_key_id` example values shown here assume you generated resources with `reflex build`. If you are using the Terraform on its own you need to provide your own valid values.

## Configuration
This rule has the following configuration options:

<dl>
  <dt>mode</dt>
  <dd>
  <p>Sets the rule to operate in <code>detect</code> or <code>remediate</code> mode.</p>

  <em>Required</em>: No  

  <em>Type</em>: string

  <em>Possible values</em>: `detect` | `remediate`  

  <em>Default</em>: `detect`
  </dd>

  <dt>minimum_password_length</dt>
  <dd>
  <p>Sets the minimum number of characters allowed in an IAM user password.</p>

  <em>Required</em>: No  

  <em>Type</em>: integer

  <em>Possible values</em>: 6 - 128

  <em>Default</em>: 8
  </dd>

  <dt>require_symbols</dt>
  <dd>
  <p>Sets whether IAM user passwords must contain at least one  of the following non-alphanumeric characters:

  ! @ # $ % ^ & * ( ) _ + - = [ ] { } | ' 
  </p>

  <em>Required</em>: No  

  <em>Type</em>: boolean

  <em>Possible values</em>: `True` | `False`  

  <em>Default</em>: `True`
  </dd>

  <dt>require_numbers</dt>
  <dd>
  <p>Sets whether IAM user passwords must contain at least one numeric character (0 to 9).</p>

  <em>Required</em>: No  

  <em>Type</em>: boolean

  <em>Possible values</em>: `True` | `False`  

  <em>Default</em>: `True`
  </dd>

  <dt>require_uppercase_characters</dt>
  <dd>
  <p>Sets whether IAM user passwords must contain at least one uppercase character from the ISO basic Latin alphabet (A to Z).</p>

  <em>Required</em>: No  

  <em>Type</em>: boolean

  <em>Possible values</em>: `True` | `False`  

  <em>Default</em>: `True`
  </dd>

  <dt>require_lowercase_characters</dt>
  <dd>
  <p>Sets whether IAM user passwords must contain at least one lowercase character from the ISO basic Latin alphabet (a to z).</p>

  <em>Required</em>: No  

  <em>Type</em>: boolean

  <em>Possible values</em>: `True` | `False`  

  <em>Default</em>: `True`
  </dd>

  <dt>allow_users_to_change_password</dt>
  <dd>
  <p>Sets whether all IAM users in your account are able to use the AWS Management Console to change their own passwords.</p>

  <em>Required</em>: No  

  <em>Type</em>: boolean

  <em>Possible values</em>: `True` | `False`  

  <em>Default</em>: `True`
  </dd>

  <dt>max_password_age</dt>
  <dd>
  <p>Sets the number of days that an IAM user password is valid. If you do not specify a value, then the operation uses the default value of 0. The result is that IAM user passwords never expire. </p>

  <em>Required</em>: No  

  <em>Type</em>: integer

  <em>Possible values</em>: 1 - 1095

  <em>Default</em>: 0
  </dd>

  <dt>password_reuse_prevention</dt>
  <dd>
  <p>Sets the number of previous passwords that IAM users are prevented from reusing. If you do not specify a value, then the default value of 0 is used. The result is that IAM users are not prevented from reusing previous passwords. </p>

  <em>Required</em>: No  

  <em>Type</em>: integer

  <em>Possible values</em>: 1 - 24

  <em>Default</em>: 0
  </dd>

  <dt>hard_expiry</dt>
  <dd>
  <p>Prevents IAM users from setting a new password after their password has expired. The IAM user cannot be accessed until an administrator resets the password.</p>

  <em>Required</em>: No  

  <em>Type</em>: boolean

  <em>Possible values</em>: `True` | `False`  

  <em>Default</em>: `False`
  </dd>
</dl>

## Contributing
If you are interested in contributing, please review [our contribution guide](https://docs.cloudmitigator.com/about/contributing.html).

## License
This Reflex rule is made available under the MPL 2.0 license. For more information view the [LICENSE](https://github.com/cloudmitigator/reflex-aws-account-password-policy-insecure/blob/master/LICENSE)
