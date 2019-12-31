# Description: Boxstarter Script updated by Hoyb
# Author: Microsoft & Hoyb
# Settings for Hoyb Workstations

Disable-UAC

# Get the base URI path from the ScriptToCall value
$bstrappackage = "-bootstrapPackage"
$helperUri = $Boxstarter['ScriptToCall']
$strpos = $helperUri.IndexOf($bstrappackage)
$helperUri = $helperUri.Substring($strpos + $bstrappackage.Length)
$helperUri = $helperUri.TrimStart("'", " ")
$helperUri = $helperUri.TrimEnd("'", " ")
$helperUri = $helperUri.Substring(0, $helperUri.LastIndexOf("/"))
$helperUri += "/scripts"
write-host "helper script base URI is $helperUri"

function executeScript {
    Param ([string]$script)
    write-host "executing $helperUri/$script ..."
	iex ((new-object net.webclient).DownloadString("$helperUri/$script"))
}

#--- Setting up Windows ---
executeScript "FileExplorerSettings.ps1";
executeScript "RemoveDefaultApps_hoyb.ps1";

#--- Tools ---
#--- Installing core features
Write-Host "Installing Core Features" -ForegroundColor "Yellow"
choco install -y geforce-experience

#--- Installing cloud services
Write-Host "Installing Cloud Services" -ForegroundColor "Yellow"
choco install -y dropbox
choco install -y slack

#--- Installing code editors
Write-Host "Installing Code Editors" -ForegroundColor "Yellow"
choco install -y notepadplusplus.install
choco install -y vscode --params "/NoDesktopIcon"

#--- Installing web browsers
Write-Host "Installing Web Browsers" -ForegroundColor "Yellow"
choco install -y googlechrome
choco install -y firefox

#--- Installing remote access tools
Write-Host "Installing Remote Access Tools" -ForegroundColor "Yellow"
choco install -y git --package-parameters="'/GitAndUnixToolsOnPath /WindowsTerminal'"
Update-SessionEnvironment #refreshing env due to Git install
choco install -y bitvise-ssh-client
choco install -y mremoteng

#--- Installing utilities
Write-Host "Installing Utilities" -ForegroundColor "Yellow"
choco install -y vuescan
choco install -y greenshot
choco install -y 7zip.install
choco install -y myharmony

#--- Installing VM tools
Write-Host "Installing VM Tools" -ForegroundColor "Yellow"
choco install -y virtualbox --params "/NoDesktopShortcut /ExtensionPack"
Update-SessionEnvironment #refreshing env due to VBox install
choco install -y vagrant

# Adobe Acrobat XI Pro
# APC PowerChute
# Java JDK
# Signal
# Tukui
# Battle.net
# Twitch
# Office 365
# Ledger Live
# Scatter
# Newsbin
# Razer Synapse

#--- reenabling critial items ---
Write-Host "Reenabling Critical Items" -ForegroundColor "Yellow"
Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
