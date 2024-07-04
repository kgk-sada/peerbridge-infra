resource "google_compute_instance" "dev_traceability_app_server" {
  project         = local.application_project_id
  name         = "dev-traceability-app-server"
  machine_type = "e2-standard-4"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      size = 100
      image = "windows-server-2016-dc-v20240612"
    }
    auto_delete = false
  }

  network_interface {
    network = data.google_compute_network.network.id
    subnetwork = data.google_compute_network.network.subnetworks_self_links[0]
    # access_config {
    #   // Ephemeral public IP
    # }
  }

  lifecycle {
    ignore_changes = [
      metadata
    ]
  
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = module.traceability_app_service_account.email
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance_group" "dev_traceability_umig" {
  name        = "dev-treaceability-umig"

  instances = [
    google_compute_instance.dev_traceability_app_server.self_link
  ]

  named_port {
    name = "http"
    port = "80"
  }

  named_port {
    name = "https"
    port = "443"
  }

  zone = "us-central1-a"
}

# instance template
resource "google_compute_instance_template" "instance_template" {
  name         = "l7-ilb-mig-template-startup-script"
  provider     = google-beta
  project      = var.gcp_bucket_project_id
  machine_type = "e2-standard-4"

  network_interface {
    network    = local.network_self_link
    subnetwork = local.subnet_01_self_link
    # access_config {
    #   # add external ip to fetch packages
    # }
  }

  disk {
    source_image = "windows-server-2016-dc-v20240612"
    auto_delete  = true
    boot         = true
    disk_size_gb = 100
    disk_type    = "pd-ssd"
  }

  metadata = {
    windows-startup-script-ps1 = <<-EOT
      $ErrorActionPreference = "Stop"

      $source = "$env:TEMP\app\PackageTmp"
      $destination= 'C:\inetpub\wwwroot'
      $secretName = "traceability-service-account-cred"  
      $artifactPath = "gs://prj-d-backend-tp-s2sb-artifacts/traceability-base-v1.zip"
      $jsonFilePath = "C:\traceability-config\prj-d-backend-tp-s2sb-a27930e13624.json"  

      # Download application package from Cloud Storage
      gsutil cp $artifactPath $env:TEMP\app.zip

      # Install IIS
      Enable-WindowsOptionalFeature -Online -FeatureName `
              NetFx4Extended-ASPNET45, `
              IIS-WebServerRole, `
              IIS-WebServer, `
              IIS-CommonHttpFeatures, `
              IIS-HttpErrors, `
              IIS-HttpRedirect, `
              IIS-ApplicationDevelopment, `
              IIS-HealthAndDiagnostics, `
              IIS-HttpLogging, `
              IIS-LoggingLibraries, `
              IIS-RequestMonitor, `
              IIS-HttpTracing, `
              IIS-Security, `
              IIS-RequestFiltering, `
              IIS-Performance, `
              IIS-WebServerManagementTools, `
              IIS-IIS6ManagementCompatibility, `
              IIS-Metabase, `
              IIS-DefaultDocument, `
              IIS-ApplicationInit, `
              IIS-NetFxExtensibility45, `
              IIS-ISAPIExtensions, `
              IIS-ISAPIFilter, `
              IIS-ASPNET45, `
              IIS-HttpCompressionStatic

      # Extract application package to wwwroot
      New-Item -ItemType directory -Path $env:TEMP\app
      Add-Type -AssemblyName System.IO.Compression.FileSystem
      [System.IO.Compression.ZipFile]::ExtractToDirectory("$env:TEMP\app.zip", "$env:TEMP\app")
      Remove-Item $env:TEMP\app.zip

      Remove-Item C:\inetpub\wwwroot\* -Recurse -Force

      # Set base directory for outer Get-ChildItem and Resolve-Path -Relative
      Push-Location $source  
      try {
          Get-ChildItem -Path $source | ForEach-Object {
              Get-ChildItem -Path $_.Fullname -File -Recurse |
                  ForEach-Object {
                      # Make the current file path relative to $source
                      $relativePath = Resolve-Path $_.Fullname -Relative

                      # Build up the full destination file path
                      $destinationFullPath = Join-Path $destination $relativePath
                      
                      # Create destination directory if not already exists (-force)
                      $null = New-Item (Split-Path $destinationFullPath -Parent) -ItemType Directory -Force

                      # Copy the current file
                      Copy-Item -Path $_.Fullname -Destination $destinationFullPath
                  }
          }
      }
      finally {
          Pop-Location  # Restore the current directory
      }

      $secretValue = gcloud secrets versions access latest --secret="$secretName"
      $secretValue | Out-File -FilePath $jsonFilePath -Force
      Write-Output "Secret JSON file downloaded successfully to: $jsonFilePath"
    EOT
  }

  lifecycle {
    create_before_destroy = true
  }
}


# MIG
resource "google_compute_region_instance_group_manager" "mig" {
  name     = var.mig_name
  provider = google-beta
  project  = var.gcp_bucket_project_id
  region   = "us-central1"
  version {
    instance_template = google_compute_instance_template.instance_template.id
    name              = "primary"
  }
  auto_healing_policies {
    initial_delay_sec = 300
    health_check      =  google_compute_health_check.autohealing.id
  }
  named_port {
    name = "http"
    port = 80
  }
  
  base_instance_name = "traceability-portal"
  target_size        = 1
  update_policy {
    type = "PROACTIVE"
    minimal_action = "REPLACE"
    max_surge_fixed = 3
  }
}

resource "google_compute_health_check" "autohealing" {
  name                = "autohealing-health-check-mig"
  check_interval_sec  = 30
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 10

  http_health_check {
    port         = "80"
  }
}

# Granting Google APIs Service Agent compute.subnetworks.use permission at Network project

resource "google_project_iam_member" "mig" {
  project = local.network_project_id
  role    = "roles/compute.networkUser"
  member  = "serviceAccount:${data.google_project.project_number.number}@cloudservices.gserviceaccount.com"
}