param(
  [psobject]$Config,
  [string]  $LogFile
)

# 1) Test API throttle endpoint
try {
  $resp = Invoke-RestMethod -Uri "http://localhost:$($Config.ApiPort)/api/throttle" -TimeoutSec 5
  $status = 'OK'
} catch {
  $status = 'Fail'
}

# 2) Log and event
Add-Content $LogFile "`$(Get-Date): ThrottleBot → API Status=$status"

$event = @{
  Bot      = 'ThrottleBot'
  Type     = 'Status'
  Severity = if ($status -eq 'OK') { 'Info' } else { 'Error' }
  Message  = "API throttle endpoint returned $status"
}

$event | ConvertTo-Json