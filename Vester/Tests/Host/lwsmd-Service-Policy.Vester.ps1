# Test file for the Vester module - https://github.com/WahlNetwork/Vester
# Called via Invoke-Pester VesterTemplate.Tests.ps1

# Test title, e.g. 'DNS Servers'
$Title = 'lwsmd (Active Directory) Service Policy'

# Test description: How New-VesterConfig explains this value to the user
$Description = 'Policy for lwsmd (Active Directory) service (on,off,automatic)'

# The config entry stating the desired values
$Desired = $cfg.host.lwsmdservicepolicy

# The test value's data type, to help with conversion: bool/string/int
$Type = 'string'

# The command(s) to pull the actual value for comparison
# $Object will scope to the folder this test is in (Cluster, Host, etc.)
[ScriptBlock]$Actual = {
    ($Object | Get-VMHostService | Where-Object -FilterScript {
        $_.Key -eq 'lwsmd'
    }).Policy
}

# The command(s) to match the environment to the config
# Use $Object to help filter, and $Desired to set the correct value
[ScriptBlock]$Fix = {
   Set-VMHostService -HostService ($Object |
            Get-VMHostService |
            Where-Object -FilterScript {
                $_.Key -eq 'lwsmd'
        }) -Policy $Desired -ErrorAction Stop
}
