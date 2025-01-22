Push-Location $PSScriptRoot
$auth = "UserPassword"
$settings = Get-Content "settings.json" | ConvertFrom-Json
$credential = get-credential -UserName $env:USERNAME -Message "Using Windows Authentication. Please enter your Windows credentials."
$containerName = $settings.name -replace '[^a-zA-Z0-9]', ''
$licenseFile = "N:\_Firma_Entw\4804634 LeBit Dev BC.bclicense"

$version = $settings.versions | Where-Object { $_.version -eq "current" }
$artifact = $version.artifact
$segments = "$artifact/////".Split('/')
$storageAccount = $segments[0];
$type = $segments[1]; if ($type -eq "") { $type = 'Sandbox' }
$version = $segments[2]
$country = $segments[3]; if ($country -eq "") { $country = "us" }
$select = $segments[4]; if ($select -eq "") { $select = "latest" }
$artifactUrl = Get-BCArtifactUrl -storageAccount $storageAccount -type $type -version $version -country $country -select $select | Select-Object -First 1

New-BcContainer -accept_eula:$true `
    -containerName $containerName `
    -artifactUrl $artifactUrl `
    -auth $auth `
    -credential $credential `
    -updateHosts `
    -isolation hyperv `
    -licenseFile $licenseFile `
    -assignPremiumPlan 

function Get-PathsWithWildcards {
    param ($paths)

    if ($paths -is [String]) { $paths = @($paths.Split(',').Trim() | Where-Object { $_ }) }
    $foundPaths = @()
    $paths | ForEach-Object {
        $path = $_
        if ((Test-Path $path) -and ($path.StartsWith('\'))) {
            # Write-Host "Searching $path"
            $path = (Get-Item -Path $path | Sort-Object -Descending { [Version] $(if ($_.BaseName -match "(\d+\.){3}\d+") { $Matches[0] } else { "0.0.0.0" }) } | Select-Object -First 1).FullName
            # Write-Host "Found $path"
        }   
        $foundPaths += $path
    }
    $foundPaths
}


Push-Location .. # workspace

if ($settings.installApps) {
    $installApps = Get-PathsWithWildcards $settings.installApps
    Publish-BcContainerApp -containerName $containerName -appFile $installApps -skipVerification -sync -install -ignoreIfAppExists 
}
# try/catch weil Apps, die DLLs referenzieren, die noch nicht installiert sind, einen Fehler werfen
if ($settings.previousApps) {
    try {
        Publish-BcContainerApp -containerName $containerName -appFile $settings.previousApps -skipVerification -sync -install -useDevEndpoint -credential $credential -ignoreIfAppExists
    }
    catch {
        Write-Error "Error installing previous apps: $_"
    }
}

$newConfiguration = [ordered]@{
    name                           = "Publish: $containerName Docker Container"
    request                        = "launch"
    type                           = "al"
    environmentType                = "OnPrem"
    server                         = "http://${containerName}"
    serverInstance                 = "BC"
    authentication                 = "UserPassword"
    startupObjectId                = 22
    startupObjectType              = "Page"
    breakOnError                   = "ExcludeTry"
    launchBrowser                  = $true
    enableLongRunningSqlStatements = $true
    enableSqlInformationDebugger   = $true
    tenant                         = "default"
}

$folders = $settings.appFolders

$folders.Split(',') | ForEach-Object {
    Push-Location $_ # app folder

    if (-Not (Test-Path ".vscode")) { New-Item ".vscode" -ItemType Directory }

    $launchJsonPath = ".vscode/launch.json"
    if (Test-Path $launchJsonPath) {
        $launchJsonContent = Get-Content $launchJsonPath -Raw | ConvertFrom-Json
        $launchJsonContent.configurations += $newConfiguration
    }
    else {
        $launchJsonContent = [ordered]@{
            version        = "0.2.0"
            configurations = @($newConfiguration)
        }
    }

    $launchJsonContent | ConvertTo-Json -Depth 3 | Set-Content $launchJsonPath

    Pop-Location # app folder
}

Pop-Location # workspace
Pop-Location # script folder