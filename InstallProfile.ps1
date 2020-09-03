Invoke-Command -ScriptBlock {
    $profileMapping = Invoke-RestMethod -Method "Get" -Uri "https://raw.githubusercontent.com/Smalls1652/My-PowerShell-Profiles/master/profiles/install-deps/ProfileDownload.json" -ErrorAction "Stop" | ConvertFrom-Json

    $profileToDownload = $profileMapping | Where-Object { ($PSItem.psVersion -eq "$($PSVersionTable.PSVersion.Major).$($PSVersionTable.PSVersion.Major)") -and ($PSItem.psPlatform -eq $PSVersionTable.Platform) -and ($PSItem.psEdition -eq $PSVersionTable.PSEdition) }

    Invoke-WebRequest -Uri $profileToDownload.profileDownloadUri -OutFile $PROFILE
}