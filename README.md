# Run-SpeedTest

This script measures the download and upload speeds a computer has to the internet. It downloads the Ookla SpeedTest application, runs it, and returns an object with the results of the speed test. 

This script creates a directory at the location that it is run from to store the application and some other files that are generated. The script deletes this diectory at its completion. 

The script was written and tested with PowerShell Core.

## Install PowerShell Core
1. Download the lastest Long Term Support version of PowerShell Core at https://github.com/powershell/powershell.
2. Install PowerShell Core.

## How to use
1. Download the Run-SpeedTest.ps1 file.
2. Open PowerShell and run the following command: 
`Set-ExecutionPolicy -ExecutionPolicy RemoteSigned`
3. This will allow PowerShell to run the script.
4. Navigate to the directory where Run-SpeedTest.ps1 is located. You can use `Set-Location` for this.
5. Use the command `.\Run-SpeedTest.ps1` to run the script. 

## Results
An object with the following properties will be returned.

```
DateTime          : 2021-03-17 11:28:10
ServerName        : Whitesky Communications LLC - Atlanta, GA
ServerID          : 8169
DownLoadMBPS      : 95.8
UpLoadMBPS        : 128.29
LatencyMS         : 3.56
PacketLossPercent : 2
```