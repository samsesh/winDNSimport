# Function to list all DNS zones
function Get-DnsZones {
    try {
        $zones = Get-DnsServerZone
        return $zones
    } catch {
        Write-Host "Error retrieving DNS zones: $_" -ForegroundColor Red
        exit
    }
}

# Function to import DNS records from a file into a specific zone
function Import-DnsRecords {
    param (
        [string]$ZoneName,
        [string]$FilePath
    )

    # Check if the file exists
    if (-Not (Test-Path $FilePath)) {
        Write-Host "The file path provided does not exist. Please check the file path and try again." -ForegroundColor Red
        return
    }

    # Read the file content
    $zoneData = Get-Content $FilePath

    # Assuming the file is in a format that PowerShell can parse directly. This may require additional processing.
    # Here we use an example approach. You may need to adapt it based on your file's format.
    $zoneData | ForEach-Object {
        # Process each line and add records to the zone
        # This is a placeholder for actual record processing
        # Example: Assuming the file contains A records in the format: "name IN A IPAddress"
        $line = $_.Trim()
        if ($line -match "^(\S+)\s+IN\s+A\s+(\S+)$") {
            $name = $matches[1]
            $ip = $matches[2]
            Add-DnsServerResourceRecordA -Name $name -IPv4Address $ip -ZoneName $ZoneName
        }
    }

    Write-Host "Records imported successfully from $FilePath into zone $ZoneName." -ForegroundColor Green
}

# Main script
Write-Host "Fetching list of DNS zones..."
$zones = Get-DnsZones

if ($zones.Count -eq 0) {
    Write-Host "No DNS zones found. Please create a zone first." -ForegroundColor Red
    exit
}

# Display the list of zones
Write-Host "Select a zone from the list below:`n"
$zoneList = $zones | ForEach-Object { $_.ZoneName }
if ($zoneList.Count -eq 0) {
    Write-Host "No zones available to display." -ForegroundColor Red
    exit
}
$zoneList | ForEach-Object { Write-Host $_ }

# Prompt user to select a zone
$zoneName = Read-Host "Enter the name of the zone you want to update"

# Verify the selected zone exists
if ($zoneList -notcontains $zoneName) {
    Write-Host "The selected zone does not exist. Please check the zone name and try again." -ForegroundColor Red
    exit
}

$filePath = Read-Host "Enter the full path to the file containing new DNS records"

Import-DnsRecords -ZoneName $zoneName -FilePath $filePath
