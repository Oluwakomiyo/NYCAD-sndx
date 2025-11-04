# Docker network simulating a VPC
resource "docker_network" "nycad_network" {
  name = "nycad_vpc"
}