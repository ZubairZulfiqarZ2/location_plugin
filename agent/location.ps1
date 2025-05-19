
Add-Type -AssemblyName System.Device

$GeoWatcher = New-Object System.Device.Location.GeoCoordinateWatcher

$timeoutSeconds = 30
$startTime = Get-Date

try {
    $GeoWatcher.Start()
}
catch {
    Write-Output "<LOCATION/>"
    exit
}

while (($GeoWatcher.Status -ne 'Ready') -and ($GeoWatcher.Permission -ne 'Denied')) {
    if (((Get-Date) - $startTime).TotalSeconds -ge $timeoutSeconds) {
        Write-Output "<LOCATION/>"
        $GeoWatcher.Stop()
        exit
    }
    Start-Sleep -Milliseconds 100
}

# Initialize output
$outputXml = "<LOCATION/>"

if ($GeoWatcher.Permission -eq 'Denied') {
	$outputXml = "<LOCATION>`n"
	$outputXml += "  <PERMISSION>Denied</PERMISSION>`n"
	$outputXml += "</LOCATION>"
}
elseif ($GeoWatcher.Status -eq 'Ready') {
    $location = $GeoWatcher.Position.Location
    if (-not $location.IsUnknown -and 
        $location.Latitude -ne $null -and 
        $location.Longitude -ne $null){

        $outputXml = "<LOCATION>`n"
        $outputXml += "  <LATITUDE>$($location.Latitude)</LATITUDE>`n"
        $outputXml += "  <LONGITUDE>$($location.Longitude)</LONGITUDE>`n"
				$outputXml += "  <PERMISSION>Permitted</PERMISSION>`n"
        
        $altitude = if ($location.Altitude -eq $null -or [double]::IsNaN($location.Altitude)) { "Unknown" } else { $location.Altitude }
        $outputXml += "  <ALTITUDE>$altitude</ALTITUDE>`n"
        
        $horizontalAccuracy = if ($location.HorizontalAccuracy -eq $null -or [double]::IsNaN($location.HorizontalAccuracy)) { "Unknown" } else { $location.HorizontalAccuracy }
        $outputXml += "  <HORIZONTALACCURACY>$horizontalAccuracy</HORIZONTALACCURACY>`n"
        
        $verticalAccuracy = if ($location.VerticalAccuracy -eq $null -or [double]::IsNaN($location.VerticalAccuracy)) { "Unknown" } else { $location.VerticalAccuracy }
        $outputXml += "  <VERTICALACCURACY>$verticalAccuracy</VERTICALACCURACY>`n"
        
        $speed = if ($location.Speed -eq $null -or [double]::IsNaN($location.Speed)) { "Unknown" } else { $location.Speed }
        $outputXml += "  <SPEED>$speed</SPEED>`n"
        
        $outputXml += "</LOCATION>"
    }
}

$GeoWatcher.Stop()

Write-Output $outputXml