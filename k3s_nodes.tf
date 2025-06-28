resource "random_string" "k3s_token" {
  length  = 32
  special = false
  upper   = true
  lower   = true
}
