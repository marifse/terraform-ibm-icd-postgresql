##############################################################################
# Resource Group
##############################################################################

module "resource_group" {
  source = "git::https://github.com/terraform-ibm-modules/terraform-ibm-resource-group.git?ref=v1.0.5"
  # if an existing resource group is not set (null) create a new one using prefix
  resource_group_name          = var.resource_group == null ? "${var.prefix}-resource-group" : null
  existing_resource_group_name = var.resource_group
}

data "ibm_database_point_in_time_recovery" "database_pitr" {
  deployment_id = var.pitr_id
}

# New ICD postgresql database instance pointing to a PITR time
module "postgresql_db_pitr" {
  source            = "../.."
  resource_group_id = module.resource_group.resource_group_id
  name              = "${var.prefix}-postgres-pitr"
  region            = var.region
  resource_tags     = var.resource_tags
  configuration     = var.configuration
  member_memory_mb  = var.member_memory_mb
  member_disk_mb    = var.member_disk_mb
  member_cpu_count  = var.member_cpu_count
  pitr_id           = var.pitr_id
  pitr_time         = data.ibm_database_point_in_time_recovery.database_pitr.earliest_point_in_time_recovery_time
}
