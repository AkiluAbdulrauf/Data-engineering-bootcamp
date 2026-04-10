
variable "project" {
  description = "Project"
  default     = "data-engineering-492615-c7"
}

variable "credentials" {
  description = "My Credentials"
  default     = "./credentials/data-engineering-492615-c7-694bd2568fd2.json"
}

variable "region" {
  description = "Region"
  default     = "EU-south"
}

variable "location" {
  description = "Project Location"
  default     = "EU"
}

variable "bq_dataset_name" {
  description = "My BigQuery Dataset Name"
  default     = "bigQuery_dataset"
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  default     = "zoomcamp-demo-terra-bucket"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}
