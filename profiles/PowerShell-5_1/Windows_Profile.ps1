<#
# Smalls_Microsoft.PowerShell.5.1.0_Profile
## Platform: Windows
## Version: 2020.09.00
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