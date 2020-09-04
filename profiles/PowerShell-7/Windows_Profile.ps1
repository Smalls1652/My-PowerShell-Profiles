<#
# Smalls_Microsoft.PowerShell.7.0.0_Profile
## Platform: Windows
## Version: 2020.09.1.1
#>

function Prompt {
    $colorTable = @{
        "Reset"  = "`e[0m";
        "Red"    = "`e[31;1m";
        "Green"  = "`e[32;1m";
        "Yellow" = "`e[33;1m";
        "Grey"   = "`e[37;0m";
        "White"  = "`e[37;1m";
        "Invert" = "`e[7m";
        "RedBg"  = "`e[41m";
        "CyanBg" = "`e[46m";
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
            $promptKey = "$($colorTable.Red)`$"
            break
        }

        Default {
            $promptKey = ">"
            break
        }
    }

    $promptText = "$($colorTable.Reset)(PS $($PSVersion)) [$($colorTable.Green)$($CurrentDir)$($colorTable.Reset)]$($promptKey)$($colorTable.Reset)"

    "${promptText} "

}

#Import profile functions if the folder exists in the profile's directory
$profileFunctionsFolder = [System.IO.Path]::Combine($PSScriptRoot, "profile-functions")

switch (Test-Path -Path $profileFunctionsFolder) {
    $true {
        $profileFunctions = Get-ChildItem -Path $profileFunctionsFolder -Recurse | Where-Object { $PSItem.Extension -eq ".ps1" }
        $functionsBefore = Get-ChildItem -Path "Function:\"
        foreach ($func in $profileFunctions) {
            . "$($func.FullName)"
        }
        $functionsAfter = Get-ChildItem -Path "Function:\" | Where-Object { $PSItem -notin $functionsBefore }

        switch (($functionsAfter | Measure-Object).Count -gt 0) {
            $true {
                switch ($null -ne $env:WT_SESSION) {
                    $true {
                        Write-Output "$("`e[33;1m")❗❗ WARNING ❗❗"
                        Write-Output "Functions loaded through profile:"
                        break
                    }

                    Default {
                        Write-Output "$("`e[33;1m")WARNING: Functions loaded through profile -"
                        break
                    }
                }
                foreach ($loadedFunction in $functionsAfter) {
                    Write-Output "* $($loadedFunction.Name)"
                }
                Write-Output "$("`e[0m")"
                break
            }
        }
        break
    }
}