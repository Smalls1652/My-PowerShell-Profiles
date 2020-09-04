<#
# Smalls_Microsoft.PowerShell.7.0.0_Profile
## Platform: macOS/Linux
## PowerShell Version: 7.0
## Version: 2020.09.01
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

    $promptKey = ">"

    $promptText = "$($color.Reset)(PS $($PSVersion)) [$($color.Green)$($CurrentDir)$($color.Reset)]$($promptKey)$($color.Reset)"

    "${promptText} "

}

#Set the edit mode to 'Windows'
Set-PSReadLineOption -EditMode "Windows"

#Add 'ctrl+k' as a key combo for activating 'MenuComplete'
Set-PSReadLineKeyHandler -Function "MenuComplete" -Chord "Ctrl+k"

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
                $loadedFunctionsMsg = "Functions loaded through profile -"
                foreach ($loadedFunction in $functionsAfter) {
                    $loadedFunctionsMsg += "`n`t* $($loadedFunction.Name)"
                }
                Write-Warning $loadedFunctionsMsg
                Write-Output ""
                break
            }
        }
        break
    }
}