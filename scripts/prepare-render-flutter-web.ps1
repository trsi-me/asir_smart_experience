# Local Flutter Web build (output: build/web). Same artifacts Render copies to backend/web.
# If pubspec or web/ is missing: flutter create . --project-name asir_smart_experience --platforms=web
[CmdletBinding()]
param(
    [string]$ProjectRoot = "",
    [string]$BaseHref = "/",
    [string]$ApiBaseUrl = ""
)

$ErrorActionPreference = "Stop"
$utf8 = [System.Text.UTF8Encoding]::new($false)
[Console]::OutputEncoding = $utf8
$OutputEncoding = $utf8

if ([string]::IsNullOrWhiteSpace($ProjectRoot)) {
    $ProjectRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
}

$pubspec = Join-Path $ProjectRoot "pubspec.yaml"
if (-not (Test-Path $pubspec)) {
    throw "pubspec.yaml not found in: $ProjectRoot. Restore files or run: flutter create . --platforms=web"
}

Set-Location $ProjectRoot

if (-not (Get-Command flutter -ErrorAction SilentlyContinue)) {
    throw "flutter is not on PATH."
}

$webDir = Join-Path $ProjectRoot "web"
if (-not (Test-Path $webDir)) {
    Write-Warning "web/ missing; adding web platform with flutter create."
    & flutter create . --platforms=web
}

Write-Host "==> flutter pub get" -ForegroundColor Cyan
& flutter pub get

$defineArgs = @()
if (-not [string]::IsNullOrWhiteSpace($ApiBaseUrl)) {
    $defineArgs += "--dart-define=API_BASE_URL=$ApiBaseUrl"
}
Write-Host "==> flutter build web --release --base-href $BaseHref $($defineArgs -join ' ')" -ForegroundColor Cyan
if ($defineArgs.Count -gt 0) {
    & flutter build web --release --base-href $BaseHref --pwa-strategy=none @defineArgs
} else {
    Write-Warning "No -ApiBaseUrl. Default in code is Android emulator (10.0.2.2). For web use e.g. -ApiBaseUrl https://your-api.onrender.com"
    & flutter build web --release --base-href $BaseHref --pwa-strategy=none
}
if ($LASTEXITCODE -ne 0) {
    throw "flutter build web failed (exit code $LASTEXITCODE)."
}

$webOut = Join-Path $ProjectRoot "build\web"
if (-not (Test-Path (Join-Path $webOut "index.html"))) {
    throw "Build failed: build/web/index.html not found."
}

Write-Host ""
Write-Host "Done: $webOut" -ForegroundColor Green
Write-Host "Deploy: connect repo to Render; render.yaml uses one Python Web service (Flask + web/)." -ForegroundColor DarkGray
