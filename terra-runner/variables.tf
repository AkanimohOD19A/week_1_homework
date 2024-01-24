variable "credentials" {
  description = "Project Credentials"
  default     = "./keys/my-creds.json"
}

variable "project" {
  description = "Project ID"
  default     = "focus-healer-345005"
}

variable "region" {
  description = "Project Region"
  default     = "us-central1"
}

variable "location" {
  description = "Project Location"
  default     = "US"
}

variable "bq_dataset_name" {
  description = "BiqQuery Dataset Name"
  default     = "demo_dataset"
}

variable "gcs_bucket_name" {
  description = "Bucket Storage Name"
  default     = "afl_12124_tf-demo-bucket"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}