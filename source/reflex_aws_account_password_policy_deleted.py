""" Module for AccountPasswordPolicyDeletedRule """

import json

from reflex_core import AWSRule


class AccountPasswordPolicyDeletedRule(AWSRule):
    """ A Reflex Rule for detecting the deletion of an account password policy """

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
        # We simply want to know when this event occurs. Since this rule was
        # triggered we know that happened, and we want to alert. Therefore
        # the resource is never compliant.
        return False

    def get_remediation_message(self):
        """ Returns a message about the remediation action that occurred """
        return f"The AWS account password policy was deleted."


def lambda_handler(event, _):
    """ Handles the incoming event """
    rule = AccountPasswordPolicyDeletedRule(json.loads(event["Records"][0]["body"]))
    rule.run_compliance_rule()
