# Run Postgres as a Docker container
resource "docker_container" "postgres" {
  name  = "nycad-postgres"
  image = "postgres:15"

  networks_advanced {
    name = docker_network.nycad_network.name
  }
  
  env = [
    "POSTGRES_DB=fhv",
    "POSTGRES_USER=postgres",
    "POSTGRES_PASSWORD=postgres"
  ]
}

output "pg_connection_info" {
  value = {
    host     = "host.docker.internal"
    port     = 5432
    user     = "postgres"
    password = "postgres"
    database = "fhv"
  }
}

output "pg_host" {
  value = "host.docker.internal"
}

output "pg_port" {
  value = 5432
}

output "pg_user" {
  value = "postgres"
}

output "pg_password" {
  value = "postgres"
}

output "pg_database" {
  value = "fhv"
}