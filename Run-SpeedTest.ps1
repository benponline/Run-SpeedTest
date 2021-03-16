$workingDirectory = ".\speedtest"
$tempFilePath = "$workingDirectory\temp.csv"
$speedTestFilePath = "$workingDirectory\speedtest.exe"

#Checking for directory to place files required for the script.
if((Test-Path -Path $workingDirectory) -eq $false){
    New-Item -Path ".\" -Name "speedtest" -ItemType "directory" | Out-Null
}

#Download and prepare Ookla SpeedTest application for current operating system. 
If($IsWindows -eq $true){
    if((Test-Path -Path $speedTestFilePath) -eq $false){
        Invoke-WebRequest -Uri https://bintray.com/ookla/download/download_file?file_path=ookla-speedtest-1.0.0-win64.zip -OutFile .\speedtest\ookla.zip;
        Expand-Archive -Path .\speedtest\ookla.zip -DestinationPath .\speedtest;
        Remove-Item -Path .\speedtest\ookla.zip -Force;
    }
}elseif($IsLinux -eq $true){
    if((Get-Command "speedtest" -ErrorAction SilentlyContinue) -eq $false){
        Invoke-WebRequest -Uri https://bintray.com/ookla/rhel/rpm -OutFile ./speedtest/bintray-ookla-rhel.repo
        Move-Item -Path ./speedtest/bintray-ookla-rhel.repo -Destination /etc/yum.repos.d/
        yum install -y speedtest
    }
}else{
    Write-Host "This operating system is not supported. Stopping script."
    return
}

#Run Ookla SpeedTest Application and write results to temp file.
$job = Start-Job -ScriptBlock {
    param($jobTempFilePath)

    if(Test-Path -Path $jobTempFilePath){
        $output = .\speedtest\speedtest.exe --accept-license -f csv
    }else{
        $output = .\speedtest\speedtest.exe -f csv --output-header
    }

    Add-Content -Path $jobTempFilePath -Value $output
} -ArgumentList $tempFilePath

#Wait for job to complete.
While($job.State -ne "Completed"){
    Start-Sleep -Seconds 1
}

#Import results
$results = Import-Csv -Path $tempFilePath

#Place results in new PS Object.
$resultsFiltered = [PSCustomObject]@{
    DateTime = (Get-Date -Format "yyyy-MM-dd HH:mm:ss").ToString()
    ServerName = $results."server name"
    ServerID = $results."server id"
    DownLoadMBPS = [math]::Round($results."download bytes" / 1MB, 2)
    UpLoadMBPS = [math]::Round($results."upload bytes" / 1MB, 2)
    LatencyMS = [math]::Round($results.latency, 2)
    PacketLossPercent = [math]::Round($results."packet loss" -as [int], 2)
}

Remove-Item -Path $workingDirectory -Recurse -Force

return $resultsFiltered