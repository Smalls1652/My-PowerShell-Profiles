<#
# Smalls_Microsoft.PowerShell.5.1.0_Profile
## Platform: Windows
## Version: 2020.09.01
#>

function Prompt {

    $CurrentDir = (Get-Location).Path

    switch ($CurrentDir -like "$($env:USERPROFILE)*") {
        $true {
            $CurrentDir = $CurrentDir.Replace($env:USERPROFILE, "~")
            break
        }

        Default {
            break
        }
    }

    $PSVersion = "(PS $($PSVersionTable.PSVersion.Major).$($PSVersionTable.PSVersion.Minor))"

    Write-Host $PSVersion -NoNewline
    Write-Host " " -NoNewline
    Write-Host "[" -NoNewline
    Write-Host $CurrentDir -ForegroundColor Green -NoNewline
    Write-Host "]" -NoNewline

    $promptKey = $null
    switch ((New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        $true {
            $promptKey = "`$ "
            break
        }

        Default {
            $promptKey = "> "
            break
        }
    }

    return $promptKey
}

#Import profile functions if the folder exists in the profile's directory
$profileFunctionsFolder = [System.IO.Path]::Combine($PSScriptRoot, "profile-functions")

switch (Test-Path -Path $profileFunctionsFolder) {
    $true {
        $profileFunctions = Get-ChildItem -Path $profileFunctionsFolder -Recurse | Where-Object { $PSItem.Extension -eq ".ps1" }
        foreach ($func in $profileFunctions) {
            . "$($func.FullName)"
        }
    }
}