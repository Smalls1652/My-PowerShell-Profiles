# My PowerShell Profiles

![My custom PowerShell profile](/.repofiles/prompt-demo.gif)

These are my personal PowerShell profiles with a customized prompt. The primary style of my prompt was to have a visual indicator as to what version of PowerShell I am running. I tend to work in PowerShell 7.0 more than PowerShell 5.1; however, due to some compatability issues with 7.0, I have to flip-flop between the two. Most of my compatability concerns lie with some Microsoft modules not supporting **.NET Core** yet (Crazy, right?) or if I have to do something that can only be done in 5.1.

**On Windows**, I even have it change the `>` to a `$` when running in an administrator context.

![PowerShell prompt in admin context](/.repofiles/prompt-admin_example.png)

## Installation of the profile

To make installation quick and simple, I've made a *"one-liner"* that automatically downloads and installs the correct profile for the version **and** platform that PowerShell is running on. I hop between multiple different VMs or servers, so I needed a quick and easy way for me to be able to add it to those devices.

To run it, copy and paste this into a PowerShell prompt:

```powershell
$promap = irm -Uri "https://raw.githubusercontent.com/Smalls1652/My-PowerShell-Profiles/master/install-deps/ProfileDownload.json" ; $p2d = $proMap | ? { (($_.psPlatform -eq $PSVersionTable.Platform) -and ($_.psEdition -eq $PSVersionTable.PSEdition)) } ; if(!([System.IO.Directory]::Exists([System.IO.Path]::GetDirectoryName($profile)))) { $null = ni ([System.IO.Path]::GetDirectoryName($profile)) -type Directory -force } ; iwr -Uri $p2d.profileDownloadUri -OutFile $profile
```

To explain what that one-liner does, I have a script in this repo ([InstallProfile.ps1](/InstallProfile.ps1)) that expands out all of the aliases with comments explaining what each step does.

You can always install it however you want to. Just ensure that you create the correct file in the right directory, which can be found by typing `$PROFILE` in a PowerShell prompt.

## Updates

- [View updates changelogs](/Updates.md)