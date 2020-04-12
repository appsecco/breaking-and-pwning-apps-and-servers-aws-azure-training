# Script to download and setup xampp on Windows and autodeploy a web application in C:\xampp\htdocs\ping-app\
# Appsecco 2019

Write-Output "This script will download and setup xampp on your system."
 
Pause
 
$xamppurl = "http://downloadsapachefriends.global.ssl.fastly.net/xampp-files/5.6.30/xampp-win32-5.6.30-0-VC11-installer.exe"
$appziponline = "https://s3.amazonaws.com/bapawsazure-artifacts/ping-app.zip"
$httpdpath = "https://s3.amazonaws.com/bapawsazure-artifacts/httpd.conf" 
$desktop =  [Environment]::GetFolderPath("Desktop")
$setupdir = New-Item -ItemType "directory" -Path "$desktop\app-setup\"

Add-Type -AssemblyName System.IO.Compression.FileSystem
function Unzip
{
    param([string]$zipfile, [string]$outpath)

    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}

function downloadFile
{
    param([string]$url, [string]$localpath)
    Import-Module BitsTransfer
    Start-BitsTransfer -Source $url -Destination $localpath
}
 

Write-Output "Ok. This might take some time. Downloading xampp from $xamppurl"

downloadFile $xamppurl $setupdir
 
Write-Output "Downloaded xampp from Apache Friends"
Write-Output "Installing now..."
Write-Output "If you see a firewall alert asking for Apache, allow it through..."

## Install xampp in unattended mode
Start-Process -FilePath "$setupdir\xampp-win32-5.6.30-0-VC11-installer.exe" -ArgumentList "--unattendedmodeui minimal --disable-components xampp_mercury,xampp_tomcat,xampp_webalizer  --mode unattended" -Wait 
Write-Output "Installation complete"

## downloading and deploying app zip folder
Write-Output "Deploying app from public source"

downloadFile $appziponline $setupdir

Unzip "$setupdir\ping-app.zip" "C:\xampp\htdocs\"

Write-Output "Setting up application path and starting Apache on port 80"

downloadFile $httpdpath $setupdir

Move-Item -Path "$setupdir\httpd.conf" -Destination "C:\xampp\apache\conf\httpd.conf" -Force

## Start Apache
Start-Process -FilePath "C:\xampp\apache_stop.bat" -WindowStyle Minimized
Start-Process -FilePath "C:\xampp\apache_start.bat" -WindowStyle Minimized

Write-Output "Done! Browse to port 80 to see the app!"