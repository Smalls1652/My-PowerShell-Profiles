$profileMapping = Invoke-RestMethod -Method "Get" -Uri "https://raw.githubusercontent.com/Smalls1652/My-PowerShell-Profiles/master/install-deps/ProfileDownload.json" -ErrorAction "Stop"

$profileToDownload = $profileMapping | Where-Object { ($PSItem.psVersion -eq "$($PSVersionTable.PSVersion.Major).$($PSVersionTable.PSVersion.Minor)") -and ($PSItem.psPlatform -eq $PSVersionTable.Platform) -and ($PSItem.psEdition -eq $PSVersionTable.PSEdition) }

Invoke-WebRequest -Uri $profileToDownload.profileDownloadUri -OutFile $PROFILE