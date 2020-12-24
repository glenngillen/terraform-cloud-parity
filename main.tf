terraform {
  backend "remote" {}
}
resource "random_pet" "demo" {
}

output "pet" {
  value = random_pet.demo.id
}