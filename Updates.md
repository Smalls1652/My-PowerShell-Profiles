# Updates

## 2020.09.01

- Added importing of profile functions that don't reside in the profile code itself.
    - It *"dot-sources"* whatever `.ps1` scripts are located in a `./profile-functions/` folder.
    - To make sure the user is aware of what functions were loaded, a message is shown for each new PowerShell console session with all of the new functions.

## 2020.09.00

- Changed the handling of the location path if the current directory structure is the user's profile. Instead of showing the whole path, it will show `~` as the location.
    - For example if the user's profile is `C:\Users\jdoe123` and the current directory is `C:\Users\jdoe123\Downloads`, it will show up as `~\Downloads` in the prompt.