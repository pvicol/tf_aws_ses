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
   default = ""
 }