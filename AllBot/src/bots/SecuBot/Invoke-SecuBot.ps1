param(
  [psobject]$Config,
  [string]  $LogFile
)

# 1) Count inbound "Allow" firewall rules
$allowed = Get-NetFirewallRule -Direction Inbound -Action Allow
$count = $allowed.Count
Write-Host "SecuBot: Found $count inbound allow rules"

# 2) Log the count
Add-Content $LogFile "`$(Get-Date): SecuBot → InboundAllowRules=$count"

# 3) Alert if above threshold
if ($count -gt $Config.MaxAllowedRules) {
  $event = @{
    Bot      = 'SecuBot'
    Type     = 'Alert'
    Severity = 'High'
    Message  = "High inbound allow rule count: $count"
  }
} else {
  $event = @{
    Bot      = 'SecuBot'
    Type     = 'Status'
    Severity = 'Info'
    Message  = "Inbound rules OK: $count"
  }
}

# 4) Return the event
$event | ConvertTo-Json