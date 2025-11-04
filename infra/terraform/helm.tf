# Create namespace
resource "kubernetes_namespace" "nycad" {
  metadata {
    name = "nycad-app"
  }
}

# Deploy backend via Helm
resource "helm_release" "backend" {
  name             = "backend"
  chart            = "../backend"
  namespace        = kubernetes_namespace.nycad.metadata[0].name
  create_namespace = true

  # Pass Terraform outputs to Helm chart dynamically
  values = [
    yamlencode({
      env = {
        PGHOST     = "host.docker.internal"
        PGPORT     = "5432"
        PGUSER     = "postgres"
        PGPASSWORD = "postgres"
        PGDATABASE = "fhv"
      }
    })
  ]

  depends_on = [
    kubernetes_namespace.nycad,
    kubernetes_secret.postgres_secret,
    docker_container.postgres
  ]
}