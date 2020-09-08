#Gets the profile version mapping JSON file from the GitHub repo, on the master branch.
$profileMapping = Invoke-RestMethod -Method "Get" -Uri "https://raw.githubusercontent.com/Smalls1652/My-PowerShell-Profiles/master/install-deps/ProfileDownload.json" -ErrorAction "Stop"

#Parses the profile map based off the version, edition, and platform and gets the object suited for it.
$profileToDownload = $profileMapping | Where-Object { ($PSItem.psPlatform -eq $PSVersionTable.Platform) -and ($PSItem.psEdition -eq $PSVersionTable.PSEdition) }

#Check to see if the directory the profile resides in actually exists. If it doesn't, create it.
if(!([System.IO.Directory]::Exists([System.IO.Path]::GetDirectoryName($profile)))) {
    $null = New-Item -Path ([System.IO.Path]::GetDirectoryName($profile)) -ItemType Directory -Force
}

#Downloads the profile
Invoke-WebRequest -Uri $profileToDownload.profileDownloadUri -OutFile $PROFILE