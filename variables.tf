variable "domain" {
  description = "Domain to use for SES"
}

variable "zone_id" {
  description = "Route 53 zone ID for the SES domain verification"
  default     = ""
}

variable "dkim_records" {
  description = "Amazon SES DKIM records to add to R53"
  type        = "map"
  default     = {}
}

variable "create_dkim_records" {
  description = "Create Amazon SES DKIM records"
  default     = false
}

variable "rule_sets" {
  description = "Amazon SES Rule Sets"
  type        = "list"
  default     = []
}

variable "receipt_filter_name" {
  description = "Amazon SES IP Adress Filter name of the filter"
  type        = "list"
  default     = []
}

variable "receipt_filter_cidr" {
  description = "Amazon SES IP Address Filter IP address or address range to filter, in CIDR notation"
  type        = "list"
  default     = []
}

variable "receipt_filter_policy" {
  description = "Amazon SES IP Address Filter policy to 'Allow' or 'Block'"
  type        = "list"
  default     = []
}

variable "dkim_ttl" {
  description = "TTL for DKIM records. Default is 300 seconds"
  default     = "300"
}

variable "ses_ttl" {
  description = "TTL for SES Verification record. Default is 300 seconds"
  default     = "300"
}

variable "active_rule_set" {
  description = "Name of Rule Set to be active"
  default     = ""
}

variable "receipt_rule_name" {
  description = "AWS SES Receipt Rule Name"
  default     = ""
}

variable "receipt_rule_rule_set_name" {
  description = "AWS SES Receipt Rule rule set name"
  default     = ""
}

variable "receipt_rule_recipients" {
  description = "AWS Receipt Rule recipients list"
  type        = "list"
  default     = []
}

variable "receipt_rule_enabled" {
  description = "Enable rule"
  default     = false
}

variable "receipt_rule_scan_enabled" {
  description = "Incoming emails will be scanned for spam and viruses"
  default     = true
}

variable "receipt_rule_header_names" {
  description = "List of headers names to be added to rule"
  type        = "list"
  default     = []
}

variable "receipt_rule_header_values" {
  description = "List of headers values to be added to rule"
  type        = "list"
  default     = []
}

variable "receipt_rule_tls_policy" {
  description = "Require or Optional, default is Optional"
  default     = "Optional"
}
