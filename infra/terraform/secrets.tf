# Kubernetes secret to store Postgres connection credentials
resource "kubernetes_secret" "postgres_secret" {
  depends_on = [kubernetes_namespace.nycad]
  metadata {
    name      = "postgres-secret"
    namespace = kubernetes_namespace.nycad.metadata[0].name
  }

  data = {
    PGHOST     = "host.docker.internal"
    PGPORT     = "5432"
    PGUSER     = "postgres"
    PGPASSWORD = "postgres"
    PGDATABASE = "fhv"
  }
}