<#
# Smalls_Microsoft.PowerShell.7.0.0_Profile
## Platform: Windows
## Version: 2020.09.00
#>

function Prompt {
    $color = @{
        Reset         = "`e[0m"
        Red           = "`e[31;1m"
        Green         = "`e[32;1m"
        Yellow        = "`e[33;1m"
        Grey          = "`e[37;0m"
        White         = "`e[37;1m"
        Invert        = "`e[7m"
        RedBackground = "`e[41m"
    }

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

    $PSVersion = "$($PSVersionTable.PSVersion.Major).$($PSVersionTable.PSVersion.Minor).$($PSVersionTable.PSVersion.Patch)"

    $promptKey = $null
    switch ((New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        $true {
            $promptKey = "$($color.Red)`$"
            break
        }

        Default {
            $promptKey = ">"
            break
        }
    }

    $promptText = "$($color.Reset)(PS $($PSVersion)) [$($color.Green)$($CurrentDir)$($color.Reset)]$($promptKey)$($color.Reset)"

    "${promptText} "

}