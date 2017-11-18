# terraform-ses

Terraform module for deploying and managing AWS SES.

## Disclaimer
This is work in progress. Module subjected to change without notice.

## Available variables

* \[`domain`\]: String(required): Domain to use for SES.
* \[`zone_id`\]: String(optional): Route 53 zone ID for the SES domain verification. If the `zone_id` is not set, we do not create verification record in R53.
* \[`dkim_records`\]: Map(optional): Amazon SES DKIM records to add to R53. You can generate these records from the AWS console.
* \[`create_dkim_records`\] Boolean(optional): Create SES DKIM records. To manage DKIM records in Route 53, use \[`dkim_records`\] map.
* \[`dkim_ttl`\]: String(optional): TTL for DKIM records. Default is 300 seconds
* \[`ses_ttl`\]: String(optional): TTL for SES Verification record. Default is 300 seconds
* \[`rule_sets`\]: Map(optional): Amazon SES Rule Sets to be created in SES
* \[`active_rule_set`\]: String(optional): Set an Amazon SES Rule Set to active
* \[`receipt_filter_name`\]: List(optional): Create IP Address Filter Name
* \[`receipt_filter_cidr`\]: List(optional): Create IP Address Filter CIDR, IP address or address range to filter, in CIDR notation
* \[`receipt_filter_policy`\]: List(optional): Create IP Address Filter Policy, Allow or Block

### Non-importable resources

Terraform does not support importing all resources. The following resources/variables cannot be imported:

* \[`aws_ses_active_receipt_rule_set` - `active_rule_set`\] 
* \[`aws_ses_receipt_rule` - `receipent_rule_*`\]

Use of these variables on imported resources might override or recreate imported resources.

## Output

* \[`domain_identity_arn`\]: String: ARN of the SES domain identity.

## Example

```terraform
module "ses" {
  source  = "github.com/pvicol/tf_aws_ses"
  domain  = "example.com"
  zone_id = "ZONEID"

  dkim_records = {
    "one._domainkey.example.com"   = "one.dkim.amazonses.com"
    "two._domainkey.example.com"   = "two.dkim.amazonses.com"
    "three._domainkey.example.com" = "three.dkim.amazonses.com"
  }

  create_dkim_records   = true
  dkim_ttl              = "3600"
  ses_ttl               = "3600"
  rule_sets             = ["example1", "exmaple2"]
  receipt_filter_name   = ["block-spammer", "allow"]
  receipt_filter_cidr   = ["1.2.3.4", "5.6.7.8/24"]
  receipt_filter_policy = ["Block", "Allow"]

}
```
