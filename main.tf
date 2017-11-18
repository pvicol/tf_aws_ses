resource "aws_ses_domain_identity" "domain" {
  domain = "${var.domain}"
}

resource "aws_route53_record" "domain_amazonses_dkim_record" {
  count   = "${var.zone_id != "" ? length(var.dkim_records) : 0}"
  zone_id = "${var.zone_id}"
  name    = "${element(keys(var.dkim_records), count.index)}"
  type    = "CNAME"
  ttl     = "${var.dkim_ttl}"
  records = ["${element(values(var.dkim_records), count.index)}"]
}

resource "aws_route53_record" "domain_amazonses_verification_record" {
  count   = "${var.zone_id != "" ? 1 : 0}"
  zone_id = "${var.zone_id}"
  name    = "_amazonses.${var.domain}"
  type    = "TXT"
  ttl     = "${var.ses_ttl}"
  records = ["${aws_ses_domain_identity.domain.verification_token}"]
}

resource "aws_ses_domain_dkim" "amazonses_dkim_records" {
  count  = "${var.create_dkim_records == true ? 1 : 0}"
  domain = "${aws_ses_domain_identity.domain.domain}"
}

resource "aws_ses_receipt_rule_set" "rule_set" {
  count         = "${length(var.rule_sets) != 0 ? length(var.rule_sets): 0 }"
  rule_set_name = "${element(var.rule_sets, count.index)}"
}

resource "aws_ses_active_receipt_rule_set" "active_rule_set" {
  depends_on    = ["aws_ses_receipt_rule_set.rule_set"]
  count         = "${var.active_rule_set != "" ? 1 : 0 }"
  rule_set_name = "${var.active_rule_set}"
}

resource "aws_ses_receipt_filter" "filter" {
  count  = "${length(var.receipt_filter_name) != 0 ? length(var.receipt_filter_name) : 0}"
  name   = "${element(var.receipt_filter_name, count.index)}"
  cidr   = "${element(var.receipt_filter_cidr, count.index)}"
  policy = "${element(var.receipt_filter_policy, count.index)}"
}

resource "aws_ses_receipt_rule" "rule" {
  depends_on    = ["aws_ses_receipt_rule_set.rule_set"]
  count         = "${var.receipt_rule_name != "" ? 1 : 0 }"
  name          = "${var.receipt_rule_name}"
  rule_set_name = "${var.receipt_rule_rule_set_name}"
  recipients    = ["${var.receipt_rule_recipients}"]
  enabled       = "${var.receipt_rule_enabled}"
  scan_enabled  = "${var.receipt_rule_scan_enabled}"
  tls_policy    = "${var.receipt_rule_tls_policy}"
}
