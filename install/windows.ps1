# Stream Kit installer for Windows.
# Run in PowerShell:  irm https://raw.githubusercontent.com/realworldbuilder/stream-kit/main/install/windows.ps1 | iex
$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'   # makes the download much faster in Windows PowerShell 5
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12   # older Windows defaults can't reach GitHub

Write-Host ""
Write-Host "Stream Kit" -ForegroundColor Magenta
Write-Host "Installing Aitum Multistream (stream to Twitch + YouTube and stop each one on its own)."
Write-Host ""

while (Get-Process obs64, obs32 -ErrorAction SilentlyContinue) {
    Write-Host "OBS is open. Close OBS, then press Enter." -ForegroundColor Yellow
    [void](Read-Host)
}

$url = 'https://github.com/Aitum/obs-aitum-multistream/releases/latest/download/aitum-multistream-windows-installer.exe'
$out = Join-Path $env:TEMP 'aitum-multistream-windows-installer.exe'
Write-Host "Downloading the plugin..."
Invoke-WebRequest -Uri $url -OutFile $out -UseBasicParsing

Write-Host "Opening the plugin installer. Click through it (Next, Install, Finish)."
Write-Host "If Windows says 'Windows protected your PC', click 'More info' then 'Run anyway'."
Start-Process -FilePath $out -Wait

Write-Host ""
Write-Host "Done. Opening the Stream Kit page for the next steps." -ForegroundColor Green
Start-Process 'https://realworldbuilder.github.io/stream-kit/'
