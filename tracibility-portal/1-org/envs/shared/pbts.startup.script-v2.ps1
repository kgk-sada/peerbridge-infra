    # Download application package from Cloud Storage
    gsutil cp gs://prj-d-backend-tp-s2sb-artifacts/traceability-base-v2.zip $env:TEMP\app.zip

    # Install IIS
    Enable-WindowsOptionalFeature -Online -FeatureName NetFx4Extended-ASPNET45, IIS-WebServerRole, IIS-WebServer, IIS-CommonHttpFeatures, IIS-HttpErrors, IIS-HttpRedirect, IIS-ApplicationDevelopment, IIS-HealthAndDiagnostics, IIS-HttpLogging, IIS-LoggingLibraries, IIS-RequestMonitor, IIS-HttpTracing, IIS-Security, IIS-RequestFiltering, IIS-Performance, IIS-WebServerManagementTools, IIS-IIS6ManagementCompatibility, IIS-Metabase, IIS-DefaultDocument, IIS-ApplicationInit, IIS-NetFxExtensibility45, IIS-ISAPIExtensions, IIS-ISAPIFilter, IIS-ASPNET45, IIS-HttpCompressionStatic

    # Extract application package to wwwroot
    New-Item -ItemType directory -Path $env:TEMP\app
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    [System.IO.Compression.ZipFile]::ExtractToDirectory("$env:TEMP\app.zip", "$env:TEMP\app")
    Remove-Item $env:TEMP\app.zip

    Remove-Item C:\inetpub\wwwroot\* -Recurse -Force


    # Set base directory for outer Get-ChildItem and Resolve-Path -Relative
    Push-Location $env:TEMP\app\PackageTmp  
    try {
        Get-ChildItem -Path $env:TEMP\app\PackageTmp | ForEach-Object {
            Get-ChildItem -Path $_.Fullname -File -Recurse |
                ForEach-Object {
                    # Make the current file path relative to source
                    $relativePath = Resolve-Path $_.Fullname -Relative

                    # Build up the full destination file path
                    $destinationFullPath = Join-Path C:\inetpub\wwwroot $relativePath

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


    $secretValue = gcloud secrets versions access latest --secret="traceability-service-account-cred"

    $directoryPath = "C:\traceability-config"
    $filePath = "$directoryPath\prj-d-backend-tp-s2sb-a27930e13624.json"

    # Check if the directory exists
    if (-not (Test-Path -Path $directoryPath -PathType Container)) {
        # If the directory does not exist, create it
        New-Item -ItemType Directory -Path $directoryPath
    }
    $secretValue | Out-File -FilePath $filePath -Force

    Write-Output "Secret JSON file downloaded successfully to: C:\traceability-config\prj-d-backend-tp-s2sb-a27930e13624.json"
