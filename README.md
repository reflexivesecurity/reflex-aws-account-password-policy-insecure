# reflex-aws-account-password-policy-insecure
A Reflex Rule for ensuring the account password policy remains in a secure state.

## Configuration
You can configure this rule to automatically apply the desired account password policy.
To do so, simply set the following environment variables to the desired configuration.
For more information, see the [AWS Documentation](https://docs.aws.amazon.com/IAM/latest/APIReference/API_UpdateAccountPasswordPolicy.html).

`MINIMUM_PASSWORD_LENGTH`
* Default: 8
* Allowed values: 6 - 128

`REQUIRE_SYMBOLS`
* Default: `True`
* Allowed values: `True` | `False`

`REQUIRE_NUMBERS`
* Default: `True`
* Allowed values: `True` | `False`

`REQUIRE_UPPERCASE_CHARACTERS`
* Default: `True`
* Allowed values: `True` | `False`

`REQUIRE_LOWERCASE_CHARACTERS`
* Default: `True`
* Allowed values: `True` | `False`

`ALLOW_USERS_TO_CHANGE_PASSWORD`
* Default: `True`
* Allowed values: `True` | `False`

`MAX_PASSWORD_AGE`
* Default: 0
* Allowed values: 1 - 1095

`PASSWORD_REUSE_PREVENTION`
* Default: 0
* Allowed values: 1 - 24

`HARD_EXPIRY`
* Default: `False`
* Allowed values: `True` | `False`


## Usage
To use this rule either add it to your `reflex.yaml` configuration file:  
```
rules:
  - reflex-aws-account-password-policy-insecure:
      configuration:
        - environment_variable_map:
            MINIMUM_PASSWORD_LENGTH: 10
            REQUIRE_SYMBOLS: False
```

or add it directly to your Terraform:  
```
...

module "reflex-aws-account-password-policy-insecure" {
  source           = "github.com/cloudmitigator/reflex-aws-account-password-policy-insecure"
  email            = "example@example.com"
  environment_variable_map = {
    MINIMUM_PASSWORD_LENGTH: 10
    REQUIRE_SYMBOLS: False
  }
}

...
```

## License
This Reflex rule is made available under the MPL 2.0 license. For more information view the [LICENSE](https://github.com/cloudmitigator/reflex-aws-account-password-policy-insecure/blob/master/LICENSE)
