
# DNS Zone Update Script

This PowerShell script allows you to select an existing DNS zone on a Microsoft DNS server and import new DNS records from a specified file. It automates the process of updating DNS zones using a text file that contains DNS records (e.g., `A` records).

## Features

- Lists all available DNS zones on the server.
- Allows the user to select a zone to update.
- Reads a file containing new DNS records and adds them to the selected zone.
- Automatically handles `A` record additions from the file.

## Prerequisites

- Windows Server with the DNS Server role installed.
- PowerShell 5.1 or higher.
- Administrative privileges to run the script.
- The `DnsServer` PowerShell module installed (it comes with the DNS Server role).

## Installation

1. Clone the repository or download the script.

   ```bash
   git clone https://github.com/samsesh/winDNSimport.git
   ```

2. Open PowerShell with Administrator privileges.

3. Ensure that the `DnsServer` module is installed by running:

   ```powershell
   Import-Module DnsServer
   ```

4. Set the PowerShell execution policy to allow the script to run if needed:

   ```powershell
   Set-ExecutionPolicy RemoteSigned
   ```

## Usage

1. Open PowerShell as an Administrator.
   
2. Run the script:

   ```powershell
   .\Update-DnsZone.ps1
   ```

3. The script will:
   - Fetch the list of available DNS zones on your server.
   - Display the zones for you to select.
   - Prompt you to enter the full path to the file containing the new DNS records.
   - Import the new records into the selected DNS zone.

### File Format for DNS Records

The file containing the DNS records should be in the following format:

```
$TTL 2d

$ORIGIN example.com.

@               IN      SOA     ns.example.com. info.example.com. (
                                2024082809      ; serial (YYYYMMDDVV)
                                12h             ; refresh
                                15m             ; retry
                                3w              ; expire
                                2h              ; minimum ttl
                                )

                IN      NS      ns.example.com.

ns              IN      A       192.168.1.1
www             IN      A       192.168.1.2
mail            IN      A       192.168.1.3
```

### Sample Run

```bash
Fetching list of DNS zones...

Select a zone from the list below:

example.com
example.local
example.team

Enter the name of the zone you want to update: example.com

Enter the full path to the file containing new DNS records: C:\path\to\records.txt

Records imported successfully from C:\path\to\records.txt into zone example.com.
```

## Error Handling

- If the specified DNS zone doesn't exist, the script will output an error message and exit.
- If the file path provided is invalid, the script will prompt you to check the path and try again.

## Troubleshooting

### No DNS Zones Found

Ensure that the DNS server is running and properly configured. You can verify the zones using the `DNS Manager` or by running the following command:

```powershell
Get-DnsServerZone
```

### PowerShell Script Execution Error

If you encounter issues running the script due to execution policies, try setting the execution policy to allow script running:

```powershell
Set-ExecutionPolicy RemoteSigned
```

### Records Not Importing

Check that your DNS records file is formatted correctly. Only `A` records are handled by the script in its current form. You may need to adapt the script for other types of DNS records (e.g., `MX`, `CNAME`).

## Support

If you found this project useful and would like to support future development, consider [donating here](https://github.com/samsesh/donate).

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.

## Repository

Find the project on GitHub: [DNS Zone Update Script](https://github.com/samsesh/winDNSimport).

