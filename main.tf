# 1. Create a repository in Google Artifact Registry to store our Docker images.
resource "google_artifact_registry_repository" "app_repo" {
  provider      = google
  location      = var.region
  repository_id = "data-entry-app-repo" # You can change this name
  description   = "Docker repository for the data entry application."
  format        = "DOCKER"
}

# 2. Create the Google Cloud Run service to run our container.
resource "google_cloud_run_v2_service" "app_service" {
  provider = google
  name     = "data-entry-app-service" # You can change this name
  location = var.region

  # This defines the container to be deployed.
  # We use a placeholder image for now. Cloud Build will update this later.
  template {
    containers {
      image = "us-central1-docker.pkg.dev/openshift-460710/data-entry-app-repo/data-entry-app:latest"
    }
  }
}

# 3. Allow public (unauthenticated) access to the Cloud Run service.
resource "google_cloud_run_v2_service_iam_binding" "allow_public_access" {
  provider = google
  project  = google_cloud_run_v2_service.app_service.project
  location = google_cloud_run_v2_service.app_service.location
  name     = google_cloud_run_v2_service.app_service.name
  role     = "roles/run.invoker"
  members  = [
    "allUsers",
  ]
}

# 4. Output the URL of the deployed service so we know where to access it.
output "service_url" {
  description = "The URL of the deployed Cloud Run service."
  value       = google_cloud_run_v2_service.app_service.uri
}
