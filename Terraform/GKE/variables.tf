variable "project_id" {
  description = "The ID of the project in which resources will be created."
  type        = string
}

variable "region" {
  description = "The GCP region to deploy the resources."
  type        = string
  default     = "us-central1"
}
