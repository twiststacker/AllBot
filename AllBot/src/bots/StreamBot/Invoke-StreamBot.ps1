<# 
.SYNOPSIS
  SecuBot – enforces a maximum number of firewall rules.
#>

# 1. Load configuration (line 1–2)
$config   = Get-Content "$PSScriptRoot\config.json" | ConvertFrom-Json
$maxRules = $config.SecuBot.MaxAllowedRules

# 2. Count existing SecuBot rules (line 4–6)
$currentRules = Get-NetFirewallRule |
  Where-Object { $_.DisplayName -like 'SecuBot-*' }
$count = $currentRules.Count

# 3. Add missing rules up to $maxRules (line 8–15)
if ($count -lt $maxRules) {
    for ($i = $count; $i -lt $maxRules; $i++) {
        New-NetFirewallRule `
          -DisplayName "SecuBot-Rule$i" `
          -Direction   Inbound `
          -Action      Block `
          -Protocol    TCP `
          -LocalPort   ($i + 10000)
    }
}

# 4. Remove extra rules if above threshold (line 17–22)
if ($count -gt $maxRules) {
    $currentRules |
      Sort-Object DisplayName -Descending |
      Select-Object -First ($count - $maxRules) |
      ForEach-Object { Remove-NetFirewallRule -Name $_.Name }
}

Write-Host "SecuBot applied $maxRules firewall rules."