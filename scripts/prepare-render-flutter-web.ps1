#Requires -Version 5.1
<#
.SYNOPSIS
  Build Flutter Web and copy to backend/web for Render (no Docker).

.EXAMPLE
  .\scripts\prepare-render-flutter-web.ps1

.EXAMPLE
  .\scripts\prepare-render-flutter-web.ps1 -ApiBaseUrl "https://asir-smart-experience.onrender.com"

.EXAMPLE
  .\scripts\prepare-render-flutter-web.ps1 -ApiBaseUrl "http://127.0.0.1:5000"
#>
[CmdletBinding()]
param(
    [string] $ApiBaseUrl = "https://asir-smart-experience.onrender.com",
    [switch] $SkipPubGet,
    [switch] $OpenOutput
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$BackendWeb = Join-Path $RepoRoot "backend\web"
$BuildWeb = Join-Path $RepoRoot "build\web"

$ApiBaseUrl = $ApiBaseUrl.Trim().TrimEnd("/")
if ($ApiBaseUrl -notmatch '^https?://') {
    throw "ApiBaseUrl must start with http:// or https:// (got: $ApiBaseUrl)"
}

function Write-Step([string] $Message) {
    Write-Host ""
    Write-Host "==> $Message" -ForegroundColor Cyan
}

if (-not (Get-Command flutter -ErrorAction SilentlyContinue)) {
    throw "Flutter not found in PATH. Install: https://docs.flutter.dev/get-started/install"
}

if (-not (Test-Path (Join-Path $RepoRoot "pubspec.yaml"))) {
    throw "pubspec.yaml not found in: $RepoRoot"
}

Write-Host ""
Write-Host "=== Asir Smart Experience - Flutter Web for Render ===" -ForegroundColor Yellow
Write-Host "  API_BASE_URL = $ApiBaseUrl" -ForegroundColor Gray
Write-Host ""

Push-Location $RepoRoot
try {
    if (-not (Test-Path "web")) {
        Write-Step "Add web platform"
        & flutter create . --platforms=web
        if ($LASTEXITCODE -ne 0) { throw "flutter create failed" }
    }

    if (-not $SkipPubGet) {
        Write-Step "flutter pub get"
        & flutter pub get
        if ($LASTEXITCODE -ne 0) { throw "flutter pub get failed" }
    }

    Write-Step "flutter build web (release)"
    & flutter build web `
        --release `
        --base-href "/" `
        --pwa-strategy=none `
        --dart-define="API_BASE_URL=$ApiBaseUrl"
    if ($LASTEXITCODE -ne 0) { throw "flutter build web failed" }

    $index = Join-Path $BuildWeb "index.html"
    if (-not (Test-Path $index)) {
        throw "build/web/index.html missing. See errors above."
    }

    Write-Step "Copy to backend/web"
    if (Test-Path $BackendWeb) {
        Remove-Item -Recurse -Force $BackendWeb
    }
    New-Item -ItemType Directory -Path $BackendWeb -Force | Out-Null
    Copy-Item -Path (Join-Path $BuildWeb "*") -Destination $BackendWeb -Recurse -Force

    $backendIndex = Join-Path $BackendWeb "index.html"
    if (-not (Test-Path $backendIndex)) {
        throw "Copy to backend/web failed"
    }
}
finally {
    Pop-Location
}

Write-Host ""
Write-Host "BUILD OK - ready for Render" -ForegroundColor Green
Write-Host "  backend/web  (Flask UI + /api on same URL)" -ForegroundColor Green
Write-Host ""
Write-Host "Next:" -ForegroundColor Cyan
Write-Host "  git add backend/web" -ForegroundColor Gray
Write-Host "  git commit -m `"build: flutter web for Render`"" -ForegroundColor Gray
Write-Host "  git push" -ForegroundColor Gray
Write-Host ""
Write-Host "Render: single Web service (render.yaml), no Docker." -ForegroundColor DarkGray
Write-Host "  URL: $ApiBaseUrl" -ForegroundColor DarkGray

if ($OpenOutput) {
    Start-Process explorer.exe $BackendWeb
}
