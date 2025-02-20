
variable "plural_console_url" {
  description = "Plural Console URL"
  type        = string
}

variable "plural_console_token" {
  description = "Plural Console Token"
  type        = string
  sensitive   = true
}

variable "dockerhub_username" {
  description = "Docker Hub username"
  type        = string
}

variable "dockerhub_access_token" {
  description = "Docker Hub Access Token"
  type        = string
  sensitive   = true
}
