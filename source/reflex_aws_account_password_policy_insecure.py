""" Module for AccountPasswordPolicyInsecureRule """

import json
import os

import boto3

from reflex_core import AWSRule


class AccountPasswordPolicyInsecureRule(AWSRule):
    """ A Reflex Rule for detecting the deletion of an account password policy """

    client = boto3.client("iam")

    def __init__(self, event):
        super().__init__(event)

    def extract_event_data(self, event):
        """ Extract required event data """
        # We don't need any data from the event
        return

    def resource_compliant(self):
        """
        Determine if the resource is compliant with your rule.

        Return True if it is compliant, and False if it is not.
        """
        try:
            current_config = self.client.get_account_password_policy()["PasswordPolicy"]
        except self.client.exceptions.NoSuchEntityException:
            return False

        target_config = self.get_target_password_policy()

        return current_config == target_config

    def remediate(self):
        """ Fix the non-compliant resource so it conforms to the rule """
        target_config = self.get_target_password_policy()

        self.client.update_account_password_policy(**target_config)

    def get_remediation_message(self):
        """ Returns a message about the remediation action that occurred """
        message = "The AWS account password policy was deleted or updated to be insecure. "
        if self.should_remediate():
            message += "It has been reset to the required policy."

        return message

    def get_target_password_policy(self):
        """ Returns a dict with the target password policy configuration """
        target_config = {}

        target_config["MinimumPasswordLength"] = os.environ.get("MINIMUM_PASSWORD_LENGTH", 8)
        target_config["RequireSymbols"] = os.environ.get("REQUIRE_SYMBOLS", True)
        target_config["RequireNumbers"] = os.environ.get("REQUIRE_NUMBERS", True)
        target_config["RequireUppercaseCharacters"] = os.environ.get("REQUIRE_UPPERCASE_CHARACTERS", True)
        target_config["RequireLowercaseCharacters"] = os.environ.get("REQUIRE_LOWERCASE_CHARACTERS", True)
        target_config["AllowUsersToChangePassword"] = os.environ.get("ALLOW_USERS_TO_CHANGE_PASSWORD", True)
        target_config["MaxPasswordAge"] = os.environ.get("MAX_PASSWORD_AGE", None)
        target_config["PasswordReusePrevention"] = os.environ.get("PASSWORD_REUSE_PREVENTION", None)
        target_config["HardExpiry"] = os.environ.get("HARD_EXPIRY", False)

        return self.format_password_policy(target_config)

    def format_password_policy(self, policy):
        """ Converts string values representing a boolean to boolean """
        formatted_policy = {}

        for key, value in policy.items():
            try:
                if value is None:
                    # We don't want to include this key/value pair, since the default is desired
                    # and explicitly providing the default value can cause an Exception
                    continue
                if value.lower() == "true":
                    formatted_policy[key] = True
                elif value.lower() == "false":
                    formatted_policy[key] = False
                elif int(value):
                    formatted_policy[key] = int(value)
                else:
                    formatted_policy[key] = value
            except (AttributeError, ValueError):
                formatted_policy[key] = value

        return formatted_policy

def lambda_handler(event, _):
    """ Handles the incoming event """
    rule = AccountPasswordPolicyInsecureRule(json.loads(event["Records"][0]["body"]))
    rule.run_compliance_rule()
