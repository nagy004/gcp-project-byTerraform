#service account for node
resource "google_service_account" "node-acc" {
  account_id = "node-acc"
  display_name = "node-acc"
}
resource "google_project_iam_member" "node-binding" {
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${google_service_account.node-acc.email}"
  project = "nagyproject"
}

#service account for private vm 

resource "google_service_account" "gke-admin" {
  account_id = "gke-admin"
  display_name = "gke-admin"
}

resource "google_project_iam_member" "admin_binding" {
  role    = "roles/container.admin"
  member  = "serviceAccount:${google_service_account.gke-admin.email}"
  project = "nagyproject"
}