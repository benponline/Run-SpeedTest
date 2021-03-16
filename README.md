# Run-SpeedTest

This script measures the download and upload speeds a computer has from the interent. It downloads the Ookla SpeedTest application, runs it, and returns an object with the results of the speed test. 

This script creates a directory at the location that it is run from to store the application and some other files that are generated. The script deletes this diectory at its completion. 

The script was written and tested with PowerShell Core.

## Install PowerShell Core
1. Download the lastest Long Term Support version of PowerShell Core at https://github.com/powershell/powershell.
2. Install PowerShell Core.
 - 

## How to use
1. Download the Run-SpeedTest.ps1 file.
2. Open your Downloads folder or the directory you saved the file to.
5. Open your version of PowerShell and run the following command: 
`Set-ExecutionPolicy -ExecutionPolicy RemoteSigned`
6. This will allow PowerShell to read the contents of the module.
7. Open a new PowerShell session and you are good to go.