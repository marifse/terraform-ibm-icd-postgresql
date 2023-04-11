module "postgresql_db" {
  source                        = "../../"
  resource_group_id             = var.resource_group_id
  name                          = var.name
  region                        = var.region
  skip_iam_authorization_policy = var.skip_iam_authorization_policy
  service_endpoints             = "private"
  pg_version                    = var.pg_version
  existing_kms_instance_guid    = var.existing_kms_instance_guid
  kms_key_crn                   = var.kms_key_crn
  backup_encryption_key_crn     = var.backup_encryption_key_crn
  resource_tags                 = var.resource_tags
  cbr_rules                     = var.cbr_rules
  configuration                 = var.configuration
  member_memory_mb              = var.member_memory_mb
  member_disk_mb                = var.member_disk_mb
  member_cpu_count              = var.member_cpu_count
  members                       = var.members
}
